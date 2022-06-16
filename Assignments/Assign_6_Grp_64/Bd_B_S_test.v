`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:04:56 09/29/2021
// Design Name:   Bd_B_S
// Module Name:   C:/Users/charan sai/Documents/Sem - 5/COAd/lab/assg/XILAB/Assign_6/Bd_B_S_test.v
// Project Name:  Assign_6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Bd_B_S
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// assignment no.: 6
// problem no.: 1
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
// 
////////////////////////////////////////////////////////////////////////////////

module Bd_B_S_test;

	// Inputs
	reg [7:0] in;
	reg [2:0] shamt;
	reg dir;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	Bd_B_S uut (
		.in(in), 
		.shamt(shamt), 
		.dir(dir), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		in = 8'b10001011;
		shamt = 3'b011;
		dir = 0; // left shift

		// Wait 100 ns for global reset to finish
		#10;
		shamt = 3'b100;
      dir = 1;  // right shift
		#10;
		$finish;
		// Add stimulus here

	end
      
endmodule

