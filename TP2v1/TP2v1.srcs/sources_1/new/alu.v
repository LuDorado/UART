`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2018 01:26:51
// Design Name: 
// Module Name: alu
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


module alu #(
    parameter N_BITS = 8,
              BITS_OC = 6
   )
   (
        input signed [N_BITS-1:0] Adata,
        input [N_BITS-1:0] Bdata,
        input [BITS_OC-1:0] op_code,
        output reg[N_BITS-1:0] alu_output
    );
	 
    always @(*)
    begin
        if(op_code ==6'b100000)begin alu_output = Adata + Bdata; end                  // ADD
            else if (op_code == 6'b100010)begin alu_output = Adata - Bdata; end      // SUB
            else if (op_code == 6'b100100)begin alu_output = Adata & Bdata; end      // AND
            else if (op_code == 6'b100101)begin alu_output = Adata | Bdata; end      // OR
            else if (op_code == 6'b100110)begin alu_output = Adata ^ Bdata; end      // XOR
            else if (op_code == 6'b000011)begin alu_output = Adata >>> Bdata; end    // SRA
            else if (op_code == 6'b000010)begin alu_output = Adata >> Bdata; end     // SRL
            else if(op_code == 6'b100111)begin alu_output = ~(Adata|Bdata); end      // NOR
        else
            alu_output =0;
        end
endmodule
