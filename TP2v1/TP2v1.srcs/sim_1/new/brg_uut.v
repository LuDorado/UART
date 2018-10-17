`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2018 13:25:51
// Design Name: 
// Module Name: brg_uut
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


module brg_uut();
    
    localparam T= 50;
    wire s_tick;
    reg clk;
    reg rst;
    brg uut(
        .s_tick(s_tick),
        .clk(clk),
        .rst(rst)
        );
        initial
        begin
            #(T/2);
            rst = 1'b1;
            clk = 1'b1;
            #(T/2);
            rst = ~rst;
            clk = 0'b1;
        end
        
    always
    begin
        #T;
        clk = ~clk;
        #T;
    end
    

    
endmodule
