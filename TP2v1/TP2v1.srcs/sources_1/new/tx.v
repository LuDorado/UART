`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2018 12:24:39
// Design Name: 
// Module Name: tx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tx #(
        parameter N_CLOCKS = 163,
                  N_BITS = 8,
                  TICK_STEPS = 16
    )
    (
        output tx,
        output reg tx_done,
        input clk,
        input rst,
        input s_tick,
        input d_ready2tx,
        input [N_BITS-1:0] d_fortx
    );
    
    localparam [1:0]
        IDLE = 2'b00,
        START = 2'b01,
        DATA = 2'b10,
        STOP = 2'b11;
    
    // s i g n a l d e c l a r a t i o n
    reg [1:0] state, state_saved;    //ESTADOS
    reg [3:0] n_ticks, n_ticks_saved;            //NRO TICKS
    reg [2:0] bit_rcvd, bit_rcvd_saved;            //NRO DE BITS RECIBIDOS
    reg [7:0] b_saved , b_saved_act;           //DONDE SE ALMACENAN LOS BITS
    reg tx_reg, tx_saved;
    
    // body
    // FSMD state & DATA registers
    
    always @(posedge clk)
    if (rst)
    begin
        state <= IDLE;
        n_ticks <= 0;
        bit_rcvd <= 0 ;
        b_saved <= 0 ;
        tx_reg <= 1'b1;
    end
    else
    begin
        state <= state_saved;
        n_ticks <= n_ticks_saved;
        bit_rcvd <= bit_rcvd_saved;
        b_saved <= b_saved_act;
        tx_reg <= tx_saved;
    end
    // FSMD next_state logic & functional units
    
    always @*
    begin
        state_saved = state;
        tx_done = 1'b0;
        n_ticks_saved = n_ticks;
        bit_rcvd_saved = bit_rcvd;
        b_saved_act = b_saved;
        tx_saved = tx_reg ;
        case (state)
            IDLE:
                begin
                    tx_saved = 1'b1;
                    if (~d_ready2tx)
                    begin
                        state_saved = START;
                        n_ticks_saved = 0;
                        b_saved_act = d_fortx;
                        tx_done = 1'b1;
                    end
                end
                
            START:
                begin
                    tx_saved = 1'b0;
                    if (s_tick)
                    if (n_ticks==15)
                    begin
                        state_saved =DATA;
                        n_ticks_saved = 0;
                        bit_rcvd_saved = 0;
                    end
                    else
                        n_ticks_saved = n_ticks+1 ;
                end
            DATA :
                begin
                    tx_saved = b_saved[0] ;
                    if (s_tick)
                        if (n_ticks==15)
                        begin
                            n_ticks_saved = 0 ;
                            b_saved_act = b_saved >> 1 ;
                            if (bit_rcvd==(N_BITS-1))
                                state_saved = STOP;
                            else
                                bit_rcvd_saved = bit_rcvd + 1;
                        end
                        else
                            n_ticks_saved = n_ticks + 1 ;
               end
            STOP:
            begin
                tx_saved = 1'b1;
                if (s_tick)
                    if (n_ticks==(TICK_STEPS - 1))
                    begin
                        state_saved = IDLE ;
                        tx_done = 1'b1;
                    end
                    else
                        n_ticks_saved = n_ticks + 1;
            end
        endcase
    end
    // o u t p u t
    assign tx = tx_reg;
    
endmodule
