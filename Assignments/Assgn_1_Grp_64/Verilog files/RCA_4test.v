`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// assignment no.: 1
// problem no.: 2(c)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////

module RCA_4test;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg cin;

	// Outputs
	wire [3:0] s;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	FullAdder_4 uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.s(s), 
		.carry(carry)
	);

	initial begin
		a = 4'b0000;
		b = 4'b0000;
		cin = 0;
		#2 
		a = 4'b0001;
		b = 4'b0001;
		cin = 1;
		#2 
		a = 4'b0110;
		b = 4'b1100;
		cin = 1;
		#2 
		a = 4'b0110;
		b = 4'b0001;
		cin = 1;
		#2 
		a = 4'b1110;
		b = 4'b0001;
		cin = 1;
		#2 
		a = 4'b1111;
		b = 4'b1111;
		cin = 1;
		#2 
$finish;

	end
      
endmodule

