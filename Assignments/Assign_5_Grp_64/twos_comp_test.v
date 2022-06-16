`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:19:04 09/27/2021
// Design Name:   Twos_comp
// Module Name:   C:/Users/charan sai/Documents/Sem - 5/COAd/lab/assg/XILAB/Assin_2/twos_comp_test.v
// Project Name:  Assin_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Twos_comp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
// assignment no.: 5
// problem no.: 2
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
////////////////////////////////////////////////////////////////////////////////

module twos_comp_test;

	// Inputs
	reg I;
	reg clk;
	reg res;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	Twos_comp uut (
		.I(I), 
		.clk(clk), 
		.res(res), 
		.out(out)
	);
	// initialize inputs
	reg [15:0]sequence;
	reg [15:0]output_seq;
	integer i;
	initial begin
		// Initialize Inputs
		I = 0;
		clk = 0;
		res = 1;
		assign sequence =  16'b0101011101110010;
		i=0;
		// Wait 100 ns for global reset to finish
		#5;
		res = 0;
      for( i = 0; i <= 15; i = i + 1)
		begin
			I = sequence[i];
			clk = 1;
			#2;
			clk = 0;
			#2;
			output_seq[i] = out;
			//$display(" Input = ", inp, ", Output = ", out);
		end
		// Add stimulus here

	end
      
endmodule

