// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2.2 (lin64) Build 2348494 Mon Oct  1 18:25:39 MDT 2018
// Date        : Fri Oct 12 18:08:00 2018
// Host        : Aragorn running 64-bit Ubuntu 18.04.1 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /media/lu/Data/FACU/ARQUITECTURA/PRACTICOS/2018/TP2/TP2v1/TP2v1.sim/sim_1/synth/func/xsim/top_func_synth.v
// Design      : top
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticpg236-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module rx
   (rx_IBUF,
    rst_IBUF,
    clk_IBUF_BUFG);
  input rx_IBUF;
  input rst_IBUF;
  input clk_IBUF_BUFG;

  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire clk_IBUF_BUFG;
  wire rst_IBUF;
  wire rx_IBUF;
  (* RTL_KEEP = "yes" *) wire [1:0]state;

  LUT5 #(
    .INIT(32'h0000AAAB)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(state[0]),
        .I1(rx_IBUF),
        .I2(state[0]),
        .I3(state[1]),
        .I4(rst_IBUF),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(state[1]),
        .I1(rx_IBUF),
        .I2(state[0]),
        .I3(state[1]),
        .I4(rst_IBUF),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:01,iSTATE0:10,iSTATE1:00,iSTATE2:11" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state[0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "iSTATE:01,iSTATE0:10,iSTATE1:00,iSTATE2:11" *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state[1]),
        .R(1'b0));
endmodule

(* NotValidForBitStream *)
module top
   (dout,
    rx_done_tick,
    clk,
    rst,
    rx);
  output [7:0]dout;
  output rx_done_tick;
  input clk;
  input rst;
  input rx;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [7:0]dout;
  wire rst;
  wire rst_IBUF;
  wire rx;
  wire rx_IBUF;
  wire rx_done_tick;

  rx Receptor
       (.clk_IBUF_BUFG(clk_IBUF_BUFG),
        .rst_IBUF(rst_IBUF),
        .rx_IBUF(rx_IBUF));
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  OBUF \dout_OBUF[0]_inst 
       (.I(1'b0),
        .O(dout[0]));
  OBUF \dout_OBUF[1]_inst 
       (.I(1'b0),
        .O(dout[1]));
  OBUF \dout_OBUF[2]_inst 
       (.I(1'b0),
        .O(dout[2]));
  OBUF \dout_OBUF[3]_inst 
       (.I(1'b0),
        .O(dout[3]));
  OBUF \dout_OBUF[4]_inst 
       (.I(1'b0),
        .O(dout[4]));
  OBUF \dout_OBUF[5]_inst 
       (.I(1'b0),
        .O(dout[5]));
  OBUF \dout_OBUF[6]_inst 
       (.I(1'b0),
        .O(dout[6]));
  OBUF \dout_OBUF[7]_inst 
       (.I(1'b0),
        .O(dout[7]));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
  IBUF rx_IBUF_inst
       (.I(rx),
        .O(rx_IBUF));
  OBUF rx_done_tick_OBUF_inst
       (.I(1'b0),
        .O(rx_done_tick));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
