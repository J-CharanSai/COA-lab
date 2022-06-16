`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:22:11 09/28/2021 
// Design Name: 
// Module Name:    Shift_reg 
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
module Shift_reg(
	input [31:0] a,
	input clk,
	input load,
	output reg out
    );
	 reg [31:0] W; 	// to store the input value to left shift for every clock edge 
	 always@(posedge clk)
	 begin
			if(load) 		// to load initially value of a in W.
				W <= a;
			else
				begin
					out <= W[31];				// output = MSB of W
					W <= {W[30:0],1'b0}; 	// left shiting the register
				end
	 end
	 


endmodule
