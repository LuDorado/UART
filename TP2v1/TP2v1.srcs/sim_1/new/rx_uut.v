`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2018 17:48:22
// Design Name: 
// Module Name: rx_uut
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


module rx_uut();
    
    wire dout;
    //output rx_empty_tick,//,tx_empty_start
    reg clk;
    reg rst;
    reg rx;
    
    top uut
        (.dout(dout),
        .clk(clk),
        .rst(rst),
        .rx(rx)
        );
    initial
    begin
        #5;
        rst = 1'b1;
        clk = 1'b1;
        rx = 1'b1;
        #5;
        rst = ~rst;
        clk = 1'b0;
        
        #52160;
        rx = 0;     //Datoa = CC
        #52160;
        rx = 1'b0; //d0
        #52160;
        rx = 1'b0;  //D1
        #52160;
        rx = 1'b1;  //D2
        #52160;
        rx = 1'b1;  //D3
        #52160;
        rx = 1'b0;    //D4
        #52160; 
        rx = 1'b0;  //D5
        #52160;
        rx = 1'b1;  //D6
        #52160;
        rx = 1'b1;  //D7
        #52160;
        rx = 1'b1;  //PARITY
        
        #52160;
        rx = 0;     //DatoB = 48
        #52160;
        rx = 1'b0; //d0
        #52160;
        rx = 1'b0;  //D1
        #52160;
        rx = 1'b0;  //D2
        #52160;
        rx = 1'b1;  //D3
        #52160;
        rx = 1'b0;  //D4
        #52160; 
        rx = 1'b0;  //D5
        #52160;
        rx = 1'b1;  //D6
        #52160;
        rx = 1'b0;  //D7
        #52160;
        rx = 1'b1;  //PARITY
        
        #52160;
        rx = 0;     //DatoOP = ADD
        #52160;
        rx = 1'b0; //d0
        #52160;
        rx = 1'b0;  //D1
        #52160;
        rx = 1'b0;  //D2
        #52160;
        rx = 1'b0;  //D3
        #52160;
        rx = 1'b0;  //D4
        #52160; 
        rx = 1'b1;  //D5
        #52160;
        rx = 1'b0;  //D6
        #52160;
        rx = 1'b0;  //D7
        #52160;
        rx = 1'b1;  //PARITY

    end
        
    always
    begin
        #5;
        clk = ~clk;
        #5;
    end
  endmodule  
    
  /*  
    
    localparam T = 500;

    wire [7:0] dout;
    wire rx_empty_tick;
    reg clk;
    reg rst;
    wire tick;
    reg [7:0] rx;
    
    top uut
        (.dout(dout),
         .rx_empty_tick(rx_empty_tick),
        .clk(clk),
        .rst(rst),
        .rx(rx));
    brg brg_uut(
                .s_tick(tick),
                .clk(clk),
                .rst(rst)
                );
    rx rx_uut (
                .d_rx2ic(dout),
                .rx_done(rx_empty_tick),
                .clk(clk),
                .rst(rst),
                .s_tick(tick),
                .rx(rx));
    initial
    begin
        #(T/20);
        rst = 1'b1;
        clk = 1'b1;
        #(T/20);
        rst = ~rst;
        clk = 0'b1;
        
        #T;
        rx = 1'b1; //d0
        #(2*T);
        rx = 1'b0;  //D1
        #(2*T);
        rx = 1'b1;  //D2
        #(2*T);
        rx = 1'b1;  //D3
        #(2*T);
        rx = 1'b0;    //D4
        #(2*T); 
        rx = 1'b0;  //D5
        #(2*T);
        rx = 1'b1;  //D6
        #(2*T);
        rx = 1'b1;  //D7
                      
                
    end
    always
        begin
            #(T/10);
            clk = ~clk;
            #(T/10);
        end
endmodule
*/