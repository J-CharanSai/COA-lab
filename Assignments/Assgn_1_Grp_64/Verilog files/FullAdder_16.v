`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// assignment no.: 1
// problem no.: 1(c)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////
module FullAdder_16(a,b,cin,s,carry);
	input [15:0] a,b;
	input cin;
	output [15:0] s;
	output carry;
	wire c;
	FullAdder_8 f1 (.a(a[7:0]),.b(b[7:0]),.cin(cin),.s(s[7:0]),.carry(c));
	FullAdder_8 f2 (.a(a[15:8]),.b(b[15:8]),.cin(c),.s(s[15:8]),.carry(carry));

endmodule
