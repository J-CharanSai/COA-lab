`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// assignment no.: 1
// problem no.: 1(c)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////
module FullAdder_8(a,b,cin,s,carry);
	input [7:0] a,b;
	input cin;
	output [7:0] s;
	output carry;
	wire [6:0] c;
	FullAdder fa1(.a(a[0]),.b(b[0]),.cin(cin),.s(s[0]),.carry(c[0]));
	FullAdder fa2(.a(a[1]),.b(b[1]),.cin(c[0]),.s(s[1]),.carry(c[1]));
	FullAdder fa3(.a(a[2]),.b(b[2]),.cin(c[1]),.s(s[2]),.carry(c[2]));
	FullAdder fa4(.a(a[3]),.b(b[3]),.cin(c[2]),.s(s[3]),.carry(c[3]));
	FullAdder fa5(.a(a[4]),.b(b[4]),.cin(c[3]),.s(s[4]),.carry(c[4]));
	FullAdder fa6(.a(a[5]),.b(b[5]),.cin(c[4]),.s(s[5]),.carry(c[5]));
	FullAdder fa7(.a(a[6]),.b(b[6]),.cin(c[5]),.s(s[6]),.carry(c[6]));
	FullAdder fa8(.a(a[7]),.b(b[7]),.cin(c[6]),.s(s[7]),.carry(carry));
endmodule
