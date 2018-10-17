`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2018 15:23:37
// Design Name: 
// Module Name: fifo
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


module fifo #(
    parameter N_BITS = 8 
   )
   (
        output wire empty,
        output wire [N_BITS-1:0] out_data,
        input wire clk ,rst ,    
        input wire  wr , rd,
        input wire [N_BITS-1:0] in_data
    );
    
    //signal declaration
    reg [N_BITS-1:0] buffer, crnt_buffer;
    reg flag_op_state, new_flag_op_state;
    
    // body
     //FF & register
     always @(posedge clk)
        if(rst)                            //iF RESET -> INITIALIZATION
            begin
                buffer <= 0;                // Empty buffer
                flag_op_state <= 1'b0;      // no signal to Alu
            end
        else
            begin
                buffer <= crnt_buffer;               // Update buffer's content
                flag_op_state <= new_flag_op_state;  // Update buffer's state
            end
     
     //next-state logic
     always @*
        begin
            crnt_buffer = buffer;                 // Load output's values
            new_flag_op_state = flag_op_state;
            
            if (wr)                               // If there's something to be written
                begin
                    crnt_buffer = in_data;         // Send current buffer to exit
                    new_flag_op_state = 1'b1;      // Senf a notification to next module
                end
            else if (rd)                          // If somebody wants to read
                new_flag_op_state = 1'b0;        // allow the reading
        end
      
     //output logic
     assign out_data = buffer;
     assign empty = ~flag_op_state;
endmodule
