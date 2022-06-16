`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:44:24 09/28/2021 
// Design Name: 
// Module Name:    Comparator 
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
// assignment no.: 5
// problem no.: 4
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
//
//////////////////////////////////////////////////////////////////////////////////
module Comparator(
	input [31:0] a,
	input [31:0] b,
	input clk,
	input res,
	input load,
	input op,
	output wire L,
	output wire E,
	output wire G
    );
	 wire ma; 	 // MSB of a 
	 wire mb;	// MSB of b
	 Shift_reg Sa(.a(a),.clk(clk),.load(load),.out(ma));	 // left shift register for a
	 Shift_reg Sb(.a(b),.clk(clk),.load(load),.out(mb));	// left shift register for b
	 Seq_Unsign_comparator SUC(.a(ma),.b(mb),.clk(clk),.res(res),.op(op),.L(L),.E(E),.G(G));	// FSM to find a<b or a=b or a>b

endmodule
