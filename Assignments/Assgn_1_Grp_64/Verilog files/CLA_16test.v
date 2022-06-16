`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Module Name:    CLA_16
//
// assignment no.: 1
// problem no.: 2(c)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////

module CLA_16test;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg cin;

	// Outputs
	wire [15:0] sum;
	wire cout;
	wire [3:0] P;
	wire [3:0] G;

	// Instantiate the Unit Under Test (UUT)
	CLA_16 uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.sum(sum), 
		.cout(cout), 
		.P(P), 
		.G(G)
	);

	initial begin
		a = 16'b0000000000000000;
		b = 16'b0000000000000000;
		cin = 0;
		#2 
		a = 16'b0000000000000001;
		b = 16'b0000000000000001;
		cin = 1;
		#2 
		a = 16'b1111111111110110;
		b = 16'b1111111111111100;
		cin = 1;
		#2 
		a = 16'b1111111111110110;
		b = 16'b1111111111110001;
		cin = 1;
		#2 
		a = 16'b0111111111111110;
		b = 16'b0111111111110001;
		cin = 1;
		#2 
		a = 16'b1111111111111111;
		b = 16'b1111111111111111;
		cin = 1;
		#2 
$finish;

	end
      
endmodule

