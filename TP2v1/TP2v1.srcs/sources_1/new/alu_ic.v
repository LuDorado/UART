`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:34 08/24/2017 
// Design Name: 
// Module Name:    placa 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu_ic #( 
    parameter   N_BITS = 8    //  #  data bits
    )
    (
        output reg wr_uart,
        output reg rd_uart,
        output wire [N_BITS-1:0] data_alu_out,
        output wire [N_BITS-1:0] data_A,
        output wire [N_BITS-1:0] data_B,
        output wire [5:0] data_OC,
        input wire [N_BITS-1:0] data_alu_in,
        input wire [N_BITS-1:0] data_rslt,
        input wire clk,
        input wire rst,
        input wire rx_empty_in
    );
    
    //estados
    localparam [1:0] 
        GET_A = 2'b00,
        GET_B = 2'b01,
        GET_OP = 2'b10,
        GET_RSLT = 2'b11;
    
    //registros	 
    reg signed [N_BITS-1:0] get_data_A,get_data_A_state;
    reg signed [N_BITS-1:0] get_data_B,get_data_B_state;
    reg signed [N_BITS-1:0] get_rslt,get_rslt_state;

    reg [5:0] get_OP,get_OP_state;
    
    //variables de ejecucion
    reg [3:0] crnt_state = GET_A;
    reg [3:0] state_saved = GET_B;
    
    always @(posedge clk)
    if(rst)
        begin
            get_data_A<= 8'b00000000;
            get_data_B<=8'b00000000;
            get_OP<=6'b000000;
            get_rslt<=8'b00000000;
            crnt_state <= GET_A;
        end
    else
        begin

            get_data_A <= get_data_A_state;
            get_data_B <= get_data_B_state;
            get_OP <= get_OP_state;
            get_rslt <= get_rslt_state;
            crnt_state <= state_saved;
        end
    
    always @ * 
    begin
        state_saved = crnt_state;  
        rd_uart = 1'b0;
        wr_uart = 1'b0;
        get_data_A_state = get_data_A;
        get_data_B_state = get_data_B;
        get_OP_state = get_OP;
        get_rslt_state = get_rslt;
        case (crnt_state)
            GET_A:
                        if(~rx_empty_in)
                        begin
                            get_data_A_state = data_alu_in;
                            rd_uart = 1'b1;
                            get_rslt_state = 0;
                            wr_uart = 1'b0;
                            state_saved = GET_B;
                        end
                
            GET_B:	
                    begin
                        if(~rx_empty_in)
                        begin
                            get_data_B_state = data_alu_in;
                            rd_uart = 1'b1;
                            state_saved = GET_OP;
                        end
                        get_rslt_state = 0;
                        wr_uart = 1'b0;
                    end
                            
            GET_OP: 
                    begin
                        if(~rx_empty_in)
                        begin
                            get_OP_state = {data_alu_in[5:0]};
                            rd_uart = 1'b1;
                            state_saved = GET_RSLT;
                        end
                    get_rslt_state = 0;
                    wr_uart = 1'b0;
                    end
                    
            GET_RSLT:	 
                    begin
                        get_rslt_state = data_rslt;
                        wr_uart = 1'b1;
                        state_saved = GET_A;		
                    end
        endcase
    end
    
      assign data_A = get_data_A;
      assign data_B = get_data_B;
      assign data_OC = get_OP;
      assign data_alu_out = get_rslt;

endmodule