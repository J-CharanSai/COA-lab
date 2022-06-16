`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// assignment no.: 1
// problem no.: 2(b)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////
module FullAdder_4(a,b,cin,s,carry);
	input [3:0] a,b;
	input cin;
	output [3:0] s;
	output carry;
	wire [2:0] c;
	FullAdder fa1(.a(a[0]),.b(b[0]),.cin(cin),.s(s[0]),.carry(c[0]));
	FullAdder fa2(.a(a[1]),.b(b[1]),.cin(c[0]),.s(s[1]),.carry(c[1]));
	FullAdder fa3(.a(a[2]),.b(b[2]),.cin(c[1]),.s(s[2]),.carry(c[2]));
	FullAdder fa4(.a(a[3]),.b(b[3]),.cin(c[2]),.s(s[3]),.carry(carry));
endmodule
