`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:51:21 09/28/2021
// Design Name:   Comparator
// Module Name:   C:/Users/charan sai/Documents/Sem - 5/COAd/lab/assg/XILAB/Assin_2/Comparater_test.v
// Project Name:  Assin_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// assignment no.: 5
// problem no.: 4
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
//
////////////////////////////////////////////////////////////////////////////////

module Comparater_test;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg clk;
	reg res;
	reg load;
	reg op;

	// Outputs
	wire L;
	wire E;
	wire G;

	// Instantiate the Unit Under Test (UUT)
	Comparator uut (
		.a(a), 
		.b(b), 
		.clk(clk), 
		.res(res), 
		.load(load), 
		.op(op), 
		.L(L), 
		.E(E), 
		.G(G)
	);
	initial begin
		// Initialize Inputs
		a = 32'b0000000000000000000000;
		b = 32'b0000000000000000000000;
		clk = 0;
		res = 0;
		op = 0;
		load = 0;
        
		// Add stimulus here

	end
	always #1 clk = ~clk; 					// clock cycle = 2
	
	parameter aL = 32'b01000100010001000100010001000100; 	// aL, bL to compare lessthan(L)
	parameter bL = 32'b01000100010001100100010001000100;
	parameter aE = 32'b01000100010001000100010001000100;  // aE, bE to compare equality(E)
	parameter bE = 32'b01000100010001000100010001000100;
	parameter aG = 32'b01000100010001100100010001000100;
	parameter bG = 32'b01000100010001000100010001000100;   // aG, bG to compare greaterthan(G)
	
	initial begin
		// Initialize Inputs
		#2 res = 1;
		#2 res = 0;
		a = aL;
		b = bL;
		load = 1;
		op = 0;
		#2 load = 0;
		#68 op = 1;
		#4 op = 0;
		#2 res =1;
		#2 res = 0;
		a = aE;
		b = bE;
		load = 1;
		#2 load = 0;
		#68 op = 1;
		#4 op = 0;
		#2 res =1;
		#2res = 0;
		a = aG;
		b = bG;
		load = 1;
		#2 load = 0;
		#68 op = 1;
		#10 $finish;

	end
      
endmodule

