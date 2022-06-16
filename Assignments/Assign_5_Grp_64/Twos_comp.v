`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:44:42 09/24/2021 
// Design Name: 
// Module Name:    Twos_comp 
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
// problem no.: 2
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
//
//////////////////////////////////////////////////////////////////////////////////
module Twos_comp(
	input I,
	input clk,
	input res,
	output reg out
    );
	 
	 reg State;
	 initial State = 0;
									// FSM consists of 2 states
	 always@(posedge clk)
	 begin
	 if(res)
		State <= 0; 		// reset to initial conditions
	 else
		begin
			case(State) 		
				0: begin	 						 // if State is 0 -> then 
					out <= I ? 1 : 0; 		// ouput is same until it encounters a 1 bit and changes its state
					State <= I ? 1 : 0;	  // state changes until it encouters an input 1.
					end
					
				1:begin							 // if state is 1 it remains in same state 
					out <= I ? 0 : 1; 		// all input bits gets flipped 
					end
			endcase
		end
	 end


endmodule
