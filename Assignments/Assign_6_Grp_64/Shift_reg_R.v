`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:24:07 10/01/2021 
// Design Name: 
// Module Name:    Shift_reg_R 
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
// problem no.: 2
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
//
//////////////////////////////////////////////////////////////////////////////////
module Shift_reg_R(
   input [7:0] a,
	input clk,
	input load,
	output reg out
    );
	 reg [7:0] W; 	// to store the input value to right shift for every clock edge 
	 initial out = 1'b0;
	 always@(posedge clk)
	 begin
			if(load) 		// to load initially value of a in W.
				W <= a;
			else
				begin
					out <= W[0];				// output = LSB of W
					W <= {1'b0,W[7:1]}; 	// right shiting the register
				end
	 end
	 


endmodule