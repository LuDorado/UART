`timescale 1ns / 1ps

module alu2fifo_uut;
// Inputs
	reg clk;
	reg rx;
	reg rst;

	// Outputs
	wire dout;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.rx(rx), 
		.rst(rst),   
		.dout(dout)
	);

	initial begin
	// Initialize Inputs
		 #5;
           rst = 1'b1;
           clk = 1'b1;
           rx = 1'b1;
           #5;
           rst = ~rst;
           //clk = 1'b0;
           
		/** señal de entrada S+dato+P
		 datoA=00101010 (42)d **/
		rx=0; //S bit de start
		#52160
			rx=0;	//D0 LSB
		#52160
			rx=1;	//D1
		#52160
			rx=0;	//D2
		#52160
			rx=1;	//D3
		#52160
			rx=0;	//D4
		#52160
			rx=1;	//D5
		#52160
			rx=0;	//D6
		#52160
			rx=0; //D7 MSB
		#52160
			rx=1;	//P bit de stop
		
		#305000	// tiempo entre cada dato
		
	
		/** señal de entrada S+dato+P
		 datoB=00001010 (10)d **/
		rx=0; //S bit de start
		#52160
			rx=0;	//D0 LSB
		#52160
			rx=1;	//D1
		#52160
			rx=0;	//D2
		#52160
			rx=1;	//D3
		#52160
			rx=0;	//D4
		#52160
			rx=0;	//D5
		#52160
			rx=0;	//D6
		#52160
			rx=0; //D7 MSB
		#52160
			rx=1;	//P bit de stop
			
		#305000	// tiempo entre cada dato
		
		/** señal de entrada S+dato+P
		 operacion=00100000 (suma)**/
		rx=0; //S bit de start
		#52160
			rx=0;	//D0 LSB
		#52160
			rx=0;	//D1
		#52160
			rx=0;	//D2
		#52160
			rx=0;	//D3
		#52160
			rx=0;	//D4
		#52160
			rx=1;	//D5
		#52160
			rx=0;	//D6
		#52160
			rx=0; //D7 MSB
		#52160
			rx=1;	//P bit de stop

	end
	
	always begin //clock de la placa 100Mhz (#5)
		#5 clk=~clk;
	end
endmodule