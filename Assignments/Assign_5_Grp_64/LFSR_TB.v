`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:05:56 09/25/2021
// Design Name:   LFSR
// Module Name:   C:/Users/charan sai/Documents/Sem - 5/COAd/lab/assg/XILAB/Assin_2/LFSR_TB.v
// Project Name:  Assin_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LFSR
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// assignment no.: 5
// problem no.: 1
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
////////////////////////////////////////////////////////////////////////////////

module LFSR_TB;

	// Inputs
	reg [3:0] seed;
	reg res;
	reg clk;
	reg sel;

	// Outputs
	wire [3:0] w;

	// Instantiate the Unit Under Test (UUT)
	LFSR uut (
		.seed(seed), 
		.res(res), 
		.clk(clk), 
		.sel(sel), 
		.w(w)
	);

	initial begin
		// Initialize Inputs
		seed = 4'b1111;
		res = 0;
		clk = 0;
		sel = 0;

		// Wait 100 ns for global reset to finish
        
		// Add stimulus here

	end
	
	always #1 clk = ~clk;
	
	initial
	begin
		#1 sel = 1'b1;
		#4 res = 1'b1;
		#2 res = 1'b0;
		#5 seed = 4'b1001;
		#1 sel = 1'b0;
		#2 sel = 1'b1;

	end
      
endmodule

