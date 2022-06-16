`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:44:03 09/25/2021 
// Design Name: 
// Module Name:    DFF 
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
// problem no.: 1
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
//////////////////////////////////////////////////////////////////////////////////
module DFF(
    input I,
    input clk,
    input res,
    output reg O
    );
		always @(posedge clk)  // D-flip flop logic
		begin
		 if(res==1'b1) 		// reset signal
		  O <= 1'b0; 
		 else  				
		  O <= I;  		   // output's the input value for every clock edge
		end 



endmodule
