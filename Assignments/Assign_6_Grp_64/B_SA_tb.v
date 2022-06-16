`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:43:21 10/01/2021
// Design Name:   B_SA
// Module Name:   C:/Users/charan sai/Documents/Sem - 5/COAd/lab/assg/XILAB/Assign_6/B_SA_tb.v
// Project Name:  Assign_6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: B_SA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// assignment no.: 6
// problem no.: 2
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
// 
////////////////////////////////////////////////////////////////////////////////

module B_SA_tb;

	// Inputs
	reg [7:0] a;
	reg [7:0] b;
	reg load;
	reg clk;
	reg res;

	// Outputs
	wire [7:0] Sum;

	// Instantiate the Unit Under Test (UUT)
	B_SA uut (
		.a(a), 
		.b(b), 
		.load(load), 
		.clk(clk), 
		.res(res), 
		.Sum(Sum)
	);
always #0.5 clk = ~clk;
	initial begin
		// Initialize Inputs
		res = 1;
		clk = 1;
		load = 1;
		#1;
		res = 0;
		a = 8'b00101101;
		b = 8'b10111111;

		// Wait 100 ns for global reset to finish
		#1 load = 0;
		#9 $finish;
		
		  
        
		// Add stimulus here

	end
      
endmodule

