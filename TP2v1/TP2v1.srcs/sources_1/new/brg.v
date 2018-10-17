`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2018 09:57:31
// Design Name: 
// Module Name: brg
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


module brg 
    (
        output s_tick,
        input clk,
        input rst
    );
    
    // constants
    parameter CLK_FREQ = 50_000_000;  // system clock frequency
    parameter BAUD_RATE = 9_600; //baud rate
    parameter DIV_SAMPLE = 16; //16oversampling4
    parameter DIV_COUNTER = 163; //CLK_FREQ/(BAUD_RATE*DIV_SAMPLE);  
    // this is the number we have to divide the system clock frequency to get a frequency (DIV_SAMPLE) time higher than (BAUD_RATE)
    parameter MID_SAMPLE = (DIV_SAMPLE/2);  // this is the middle point of a bit where you want to sample it
    parameter DIV_BIT = 10; // 1 start, 8 data, 1 stop
    
    reg [DIV_BIT-1:0] counter;
    //wire [DIV_BIT-1:0] counter_act;
    reg tick;
    
    assign s_tick= tick;
    
    always@(posedge clk)
    begin
        if (rst)
        begin
            counter <= 0;
            tick <= 1'b0;
        end
        else
          /*  counter <= counter_act;
    end
    
    assign counter_act = (counter == (DIV_COUNTER-1)) ? 0 : counter + 1;
    assign s_tick = (counter == (DIV_COUNTER-1)) ? 1'b1 : 1'b0; 
*/
        begin
            counter <= counter + 1;           
            if (counter == (DIV_COUNTER - 1))
            begin
                counter <= 0;
                tick <= 1'b1;
            end
            else
                tick <= 1'b0;
        end
    end

endmodule
