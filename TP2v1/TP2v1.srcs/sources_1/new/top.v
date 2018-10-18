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
    output dout,
    input clk,
    input rst,
    input rx
    //input rd
    );
    
    wire tick;
    wire rx_done_tick,rx_empty_tick, alu_ready2rd, alu2uart, ic_tx_empty_tick, tx_done_tick;
    wire [7:0] d_rx2fifo, d_rx2alu, val_A, val_B, d_alu2ic, d_alu2fifo, d_ic2tx;
    wire [5:0] val_OC;

    
    brg
    BaudRateGenerator(
                        .s_tick(tick),
                        .clk(clk),
                        .rst(rst)
                    );
                    
    rx
    Receptor (
                .d_rx2ic(d_rx2fifo),//), dout
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
                .wr_uart(alu2uart),//
                .rd_uart(alu_ready2rd),
                .data_alu_out(d_alu2fifo),//data_alu_out
                .data_A(val_A),
                .data_B(val_B),
                .data_OC(val_OC),
                .data_alu_in(d_rx2alu),
                .data_rslt(d_alu2ic),
                .clk (clk),
                .rst (rst),
                .rx_empty_in (rx_empty_tick)   
       );  
       
     alu
     Alu (	
         .Adata(val_A),
         .Bdata(val_B),
         .op_code(val_OC),
         .alu_output(d_alu2ic)//data_alu_out)
       );
     
     fifo 
      TxInterface (
                  .empty (ic_tx_empty_tick),
                  .out_data (d_ic2tx),
                  .clk (clk) ,
                  .rst (rst) ,    
                  .wr (alu2uart), 
                  .rd (tx_done_tick),
                  .in_data (d_alu2fifo)   
             );
    tx
    Transmisor (
                 .tx(dout),
                 .tx_done(tx_done_tick),
                 .clk(clk),
                 .rst(rst),
                 .s_tick(tick),
                 .d_ready2tx(ic_tx_empty_tick),
                 .d_fortx(d_ic2tx)
                 );
endmodule
