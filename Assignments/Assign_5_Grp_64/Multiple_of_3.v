`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:45:57 09/24/2021 
// Design Name: 
// Module Name:    Multiple_of_3 
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
// problem no.: 3
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
//
//////////////////////////////////////////////////////////////////////////////////
module Multiple_of_3(
	input I, 
	input clk,
	input res, 
	output reg out
    );
	 
	 parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10; // 3 states S0->if number % 3 = 0, S1 -> num%3 = 1, S2 -> num%3 = 2
	 
	 reg[1:0] PS; // present state
	 initial PS = S0;
	 
	always @(posedge clk) begin 
		if(res==1) begin 			// reset signal
			PS = S0; 				// reset present state to start state
			out = 1;	 				// reset output to 1
		end
		else 
			begin
			case(PS)
			S0:  						// if present state is S0
				begin
					if(I==0) 		// if input signal is 0 then 3m -> 6m which is div by 3
						out = 1;
					else 
					begin
						out = 0; 	// 3m -> 6m+1 which is not div by 3, state goes to S1
						PS = S1;
					end
				end
			S1:						// if PS is S1
				begin
					if(I==0)  		// if input is 0 then 3m+1 -> 6m+2
					begin
						PS = S2; 	// as remainder is 2 then goto state S2 
						out = 0;
					end
					else 
					begin
						out = 1; 	// 3m+1 -> 6m+2+1, remainder is 0
						PS = S0;		// goto S0 state
					end
				end
			S2: 						// if PS is S2
				begin
					out = 0;	 		
					if(I==0)			// if input is 0, 3m+2 -> 6m+4=3m'+1 
						PS = S1; 	// goto state S1
				end 					// if input is 1, 3m+2 -> 6m+4+1=3m'+2 (same state)
		endcase
		end
	end


endmodule
