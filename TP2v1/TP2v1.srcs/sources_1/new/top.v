`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2018 17:30:22
// Design Name: 
// Module Name: top
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


module top(
    output [7:0] dout,
    output tx_empty_start,
    input clk,
    input rst,
    input rx
    );
    
    wire tick;
    wire rx_done_tick, rx_empty_tick, alu_ready2rd, alu2uart;
    wire [7:0] d_rx2fifo, d_rx2alu, data_alu_out;

    
    brg
    BaudRateGenerator(
                        .s_tick(tick),
                        .clk(clk),
                        .rst(rst)
                    );
                    
    rx
    Receptor (
                .d_rx2ic(d_rx2fifo),
                .rx_done(rx_done_tick),
                .clk(clk),
                .rst(rst),
                .s_tick(tick),
                .rx(rx)
             );
    fifo 
    RxInterface (
                .empty (rx_empty_tick),
                .out_data (d_rx2alu),
                .clk (clk) ,
                .rst (rst) ,    
                .wr (rx_done_tick), 
                .rd (alu_ready2rd),
                .in_data (d_rx2fifo)   
           );
   
   alu_ic
   AluInterface (
           .wr_uart(alu2uart),
           .rd_uart(alu_ready2rd),
           .data_alu_out(data_alu_out),
           .data_alu_in(d_rx2alu),
           .clk (clk),
           .rst (rst),
           .rx_empty_in (rx_empty_tick)
           
       );  
     fifo 
      TxInterface (
                  .empty (tx_empty_start),
                  .out_data (dout),
                  .clk (clk) ,
                  .rst (rst) ,    
                  .wr (alu2uart), 
                  .rd (),
                  .in_data (data_alu_out)   
             );
             
endmodule
