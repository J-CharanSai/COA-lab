`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:11 09/29/2021 
// Design Name: 
// Module Name:    MUX 
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
module MUX(
    input a,
    input b,
    input s,
    output reg O
    );
	 
	always@(*) 			// 2 - 1 mux logic  s.b + ~s.a
	begin 
		if(s) 			// accorting to value of s the input value will be loaded to output or previous shifted value will be outputed
			O <= b;  
		else
			O <= a;
	end 

endmodule
