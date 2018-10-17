`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2018 16:47:18
// Design Name: 
// Module Name: rx
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


module rx #(
        parameter N_CLOCKS = 163,
                  N_BITS = 8,
                  TICK_STEPS = 16
    )
    (
        output [N_BITS-1:0] d_rx2ic,
        output reg rx_done,
        input clk,
        input rst,
        input s_tick,
        input rx
    );
    
    localparam [1:0]
        IDLE = 2'b00,
        START = 2'b01,
        DATA = 2'b10,
        STOP = 2'b11;
    
    reg [1:0] state, state_act;
    reg [3:0] n_ticks_strt, n_ticks_strt_act;
    reg [2:0] d_bits_rcvd, d_bits_rcvd_act;
    reg [N_BITS-1:0] b_saved, b_saved_act;
    
    
always @(posedge clk) //Memory
	if (rst)  
		begin  
			state <= IDLE;  
			n_ticks_strt <=0;  
			d_bits_rcvd <=0;  
			b_saved <=0;  
		end 
	else  
		begin  
			state <= state_act;
			n_ticks_strt <= n_ticks_strt_act;  
			d_bits_rcvd <= d_bits_rcvd_act;  
			b_saved <= b_saved_act;  
		end 

always @ * // Next-state logic
	begin
		state_act=state; 
		rx_done=1'b0;  
		n_ticks_strt_act=n_ticks_strt;
		d_bits_rcvd_act=d_bits_rcvd;  
		b_saved_act=b_saved;  
		case (state)
			2'b00:                                   // IDLE
                if (rx==0)
                begin
                    state_act = START;
                    n_ticks_strt_act=0;
                end
			2'b01: 
			     begin                              // START
                    if (s_tick==1)
                        if(n_ticks_strt==7)
                            begin
                                n_ticks_strt_act=0;
                                d_bits_rcvd_act=0;
                                state_act = DATA;
                            end
                        else
                            n_ticks_strt_act=n_ticks_strt+1;
                end
						
			2'b10:                                         // DATA
                if (s_tick==1)
                    if(n_ticks_strt==15)
                        begin
                        n_ticks_strt_act=0;
                        b_saved_act={rx,b_saved[N_BITS-1:1]};
                        if (d_bits_rcvd==N_BITS-1)
                            state_act = STOP;
                        else
                            d_bits_rcvd_act=d_bits_rcvd+1;
                        end	
                    else
                        n_ticks_strt_act=n_ticks_strt+1;
									
							
			2'b11:                                       // STOP
			      begin                                  
                    if (s_tick==1)
                        if (n_ticks_strt==(TICK_STEPS-1))
                            begin
                            rx_done=1'b1;
                            state_act = IDLE;
                            end
                        else
                            n_ticks_strt_act=n_ticks_strt+1;
                 end
		endcase	
	end

    assign d_rx2ic = b_saved;
    
endmodule
