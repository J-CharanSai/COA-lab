`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// assignment no.: 1
// problem no.: 1(c)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////
module FullAdder_32(a,b,cin,s,carry);
	input [31:0] a,b;
	input cin;
	output [31:0] s;
	output carry;
	wire c;
	FullAdder_16 f1 (.a(a[15:0]),.b(b[15:0]),.cin(cin),.s(s[15:0]),.carry(c));
	FullAdder_16 f2 (.a(a[31:16]),.b(b[31:16]),.cin(c),.s(s[31:16]),.carry(carry));

endmodule