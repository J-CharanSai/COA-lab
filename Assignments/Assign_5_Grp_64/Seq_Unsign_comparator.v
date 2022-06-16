`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:46:34 09/24/2021 
// Design Name: 
// Module Name:    Seq_Unsign_comparator 
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
module Seq_Unsign_comparator(
	input a, 
	input b,
	input clk,
	input res,
	input op,
	output reg L,
	output reg E,
	output reg G
    );
	 
	 parameter S0 = 3'b000, Sl = 3'b100, Se = 3'b010, Sg = 3'b001; // 4 states for this start state S0 = 000
	 reg [2:0] State;
	 initial State = S0; 	 //start state
	 initial L = 0; 			// initial conditions
	 initial E = 0;
	 initial G = 0;
	 
	 always@(*) 			
	 begin
		if(res) 				// reset signal
		begin
			L = 0; 			// resetting to initial conditions
			E = 0;
			G = 0;
		end
		else
		begin
		if(op==1) 			// op = 1 if 32 bits are read 
			begin
				case(State) // L, G, E are flipped according to the final states
					Sl:
						begin
							L = 1; 	// if final state is Sl -> less than state
						end
					Se:
						begin
							E = 1;	// if final state is Se -> equal numbers state
						end
					Sg:
						begin
							G = 1; 	// if final state is Sg -> greater than state
						end
					default: 		// default case 
						begin
							L = 0;
							E = 0;
							G = 0;
						end
				endcase
			end
	 end
	 end
	 
	 
	 always@(posedge clk) 			// positive synchronus logic
	 begin
		if(res) 			        // reset condition
			begin
				State <= S0;	// reset to start initial state 
			end
		else
			begin 				           // as Sg and Sl states are absoulute states(no out going states), they are not included
					if(State == S0) 		 // if State is S0(start state)
						begin
							if(a==b) State <= Se; 				 // if a == b goto equal state
							else if(a > b) State <= Sg; 		// if a > b goto greaterthan state
							else State <= Sl;				     // if a < b goto less than state
						end
					if(State == Se) 		// if state is Se(a ==b, as far as we read)
						begin
							if(a==b) State <= Se; 	          // if a == b same state
							else if(a > b) State <= Sg; 		// if a > b goto greaterthan state
							else State <= Sl;				     // if a < b goto less than state
						end
			end
	 end
	 
	 


endmodule
