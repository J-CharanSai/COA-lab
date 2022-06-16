`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// assignment no.: 1
// problem no.: 1(a)
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai
//									2. Tirupathi Suguna Bhaskar
//////////////////////////////////////////////////////////////////////////////////
module HalfAdder(
    input a,
    input b,
    output s,
    output c
    );
	 // truth table 
	 // a b : c s
	 // 0 0   0 0
	 // 0 1   0 1
	 // 1 0   0 1
	 // 1 1   1 0
	 xor(s,a,b);
	 and(c,a,b);
endmodule








