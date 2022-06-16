`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:26:13 10/09/2021
// Design Name:   Booth
// Module Name:   C:/Users/charan sai/Documents/Sem - 5/COAd/lab/assg/XILAB/Assign_6/Booth_tb.v
// Project Name:  Assign_6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Booth
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// assignment no.: 6
// problem no.: 3
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
// 
////////////////////////////////////////////////////////////////////////////////

module Booth_tb;

	// Inputs
	reg [7:0] X;
	reg [7:0] Y;
	reg clk;
	reg load;

	// Outputs
	wire [15:0] Z;

	// Instantiate the Unit Under Test (UUT)
	Booth uut (
		.X(X), 
		.Y(Y), 
		.clk(clk), 
		.load(load), 
		.Z(Z)
	);

	initial begin
		// Initialize Inputs
		X = 4;
		Y = -2;
		clk = 0;
		load = 1;

		// Wait 100 ns for global reset to finish
		#5;
      load = 0;
		#5;
		// Add stimulus here
		#50 $finish;

	end
      
	always begin
		#1 clk = ~clk;
	end
      
endmodule

