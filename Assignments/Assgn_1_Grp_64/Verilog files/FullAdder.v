`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// assignment no.: 1
// problem no.: 1(b)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////
module FullAdder(a,b,cin,s,carry);
	input a,b,cin;
	output s,carry;
	wire c1,c2,s1;
	 // truth table 
	 // a b ci: s co
	 // 0 0 0   0 0
	 // 0 0 1   1 0
	 // 1 0 0   1 0
	 // 0 1 0   1 0
	 // 1 0 1   0 1
	 // 0 1 1   0 1
	 // 1 1 0   0 1
	 // 1 1 1   1 1
	HalfAdder h1(.a(a),.b(b),.s(s1),.c(c1));
	HalfAdder h2(.a(s1),.b(cin),.s(s),.c(c2));
	assign carry = c1|c2;
endmodule

