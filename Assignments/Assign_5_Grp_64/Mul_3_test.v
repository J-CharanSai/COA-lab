`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:29:54 09/27/2021
// Design Name:   Multiple_of_3
// Module Name:   C:/Users/charan sai/Documents/Sem - 5/COAd/lab/assg/XILAB/Assin_2/Mul_3_test.v
// Project Name:  Assin_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Multiple_of_3
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// assignment no.: 5
// problem no.: 3
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
// 
////////////////////////////////////////////////////////////////////////////////

module Mul_3_test;

	// Inputs
	reg I;
	reg clk;
	reg res;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	Multiple_of_3 uut (
		.I(I), 
		.clk(clk), 
		.res(res), 
		.out(out)
	);
	reg [9:0]inp;
	reg [9:0] inp1;
	reg [9:0] out_seq;
	reg [9:0] out1_seq;
	integer i;
	initial begin
		// Initialize Inputs
		inp[9:0] = 10'b1010101101;
		inp1[9:0] = 10'b100101010;
		I = 0;
		clk = 0;
		res = 1;

		// Wait 100 ns for global reset to finish
      #10;
		// Add stimulus here
		res = 0;
		for(i=0;i<10;i=i+1) begin
			I = inp[i];
			#4;
			out_seq[i] = out;
		end
		
		res = 1;
		#12;
		res = 0;
		for(i=0;i<10;i=i+1) begin
			I = inp1[i];
			#2;
			out1_seq[i] = out;
			#4;
		end
	end
	always begin
		#2 clk = !clk;
	end
      
endmodule

