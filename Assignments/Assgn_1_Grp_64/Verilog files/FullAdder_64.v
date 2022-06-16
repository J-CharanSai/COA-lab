`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// assignment no.: 1
// problem no.: 1(c)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////
module FullAdder_64(a,b,cin,s,carry);
	input [63:0] a,b;
	input cin;
	output [63:0] s;
	output carry;
	wire c;
	FullAdder_32 f1 (.a(a[31:0]),.b(b[31:0]),.cin(cin),.s(s[31:0]),.carry(c));
	FullAdder_32 f2 (.a(a[63:32]),.b(b[63:32]),.cin(c),.s(s[63:32]),.carry(carry));

endmodule
