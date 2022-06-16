`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:52 09/29/2021 
// Design Name: 
// Module Name:    Bd_B_S 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// assignment no.: 6
// problem no.: 1
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
//
//////////////////////////////////////////////////////////////////////////////////
module Bd_B_S(
	input [7:0] in,
	input [2:0] shamt, // number of bits to shift
	input dir, 		// dir = 1 -> left shift, dir = 0 -> right shift.
	output [7:0] out
    );
	 
	 parameter a = 1'b0;
	 wire [7:0] W1,W2,Wi,Wo;
	 
	 MUX m0i(.a(in[0]),.b(in[7]),.s(dir),.O(Wi[0]));
	 MUX m1i(.a(in[1]),.b(in[6]),.s(dir),.O(Wi[1]));
	 MUX m2i(.a(in[2]),.b(in[5]),.s(dir),.O(Wi[2]));
	 MUX m3i(.a(in[3]),.b(in[4]),.s(dir),.O(Wi[3]));
	 MUX m4i(.a(in[4]),.b(in[3]),.s(dir),.O(Wi[4]));
	 MUX m5i(.a(in[5]),.b(in[2]),.s(dir),.O(Wi[5]));
	 MUX m6i(.a(in[6]),.b(in[1]),.s(dir),.O(Wi[6]));
	 MUX m7i(.a(in[7]),.b(in[0]),.s(dir),.O(Wi[7]));
	
	 MUX m02(.a(Wi[0]),.b(Wi[4]),.s(shamt[2]),.O(W1[0]));
	 MUX m12(.a(Wi[1]),.b(Wi[5]),.s(shamt[2]),.O(W1[1]));
	 MUX m22(.a(Wi[2]),.b(Wi[6]),.s(shamt[2]),.O(W1[2]));
	 MUX m32(.a(Wi[3]),.b(Wi[7]),.s(shamt[2]),.O(W1[3]));
	 MUX m42(.a(Wi[4]),.b(a),.s(shamt[2]),.O(W1[4]));
	 MUX m52(.a(Wi[5]),.b(a),.s(shamt[2]),.O(W1[5]));
	 MUX m62(.a(Wi[6]),.b(a),.s(shamt[2]),.O(W1[6]));
	 MUX m72(.a(Wi[7]),.b(a),.s(shamt[2]),.O(W1[7]));
	 
	 MUX m01(.a(W1[0]),.b(W1[2]),.s(shamt[1]),.O(W2[0]));
	 MUX m11(.a(W1[1]),.b(W1[3]),.s(shamt[1]),.O(W2[1]));
	 MUX m21(.a(W1[2]),.b(W1[4]),.s(shamt[1]),.O(W2[2]));
	 MUX m31(.a(W1[3]),.b(W1[5]),.s(shamt[1]),.O(W2[3]));
	 MUX m41(.a(W1[4]),.b(W1[6]),.s(shamt[1]),.O(W2[4]));
	 MUX m51(.a(W1[5]),.b(W1[7]),.s(shamt[1]),.O(W2[5]));
	 MUX m61(.a(W1[6]),.b(a),.s(shamt[1]),.O(W2[6]));
	 MUX m71(.a(W1[7]),.b(a),.s(shamt[1]),.O(W2[7]));
	 
	 MUX m00(.a(W2[0]),.b(W2[1]),.s(shamt[0]),.O(Wo[0]));
	 MUX m10(.a(W2[1]),.b(W2[2]),.s(shamt[0]),.O(Wo[1]));
	 MUX m20(.a(W2[2]),.b(W2[3]),.s(shamt[0]),.O(Wo[2]));
	 MUX m30(.a(W2[3]),.b(W2[4]),.s(shamt[0]),.O(Wo[3]));
	 MUX m40(.a(W2[4]),.b(W2[5]),.s(shamt[0]),.O(Wo[4]));
	 MUX m50(.a(W2[5]),.b(W2[6]),.s(shamt[0]),.O(Wo[5]));
	 MUX m60(.a(W2[6]),.b(W2[7]),.s(shamt[0]),.O(Wo[6]));
	 MUX m70(.a(W2[7]),.b(a),.s(shamt[0]),.O(Wo[7]));
	 
	 MUX m0o(.a(Wo[0]),.b(Wo[7]),.s(dir),.O(out[0]));
	 MUX m1o(.a(Wo[1]),.b(Wo[6]),.s(dir),.O(out[1]));
	 MUX m2o(.a(Wo[2]),.b(Wo[5]),.s(dir),.O(out[2]));
	 MUX m3o(.a(Wo[3]),.b(Wo[4]),.s(dir),.O(out[3]));
	 MUX m4o(.a(Wo[4]),.b(Wo[3]),.s(dir),.O(out[4]));
	 MUX m5o(.a(Wo[5]),.b(Wo[2]),.s(dir),.O(out[5]));
	 MUX m6o(.a(Wo[6]),.b(Wo[1]),.s(dir),.O(out[6]));
	 MUX m7o(.a(Wo[7]),.b(Wo[0]),.s(dir),.O(out[7]));


endmodule
