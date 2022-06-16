`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:32:45 10/03/2021 
// Design Name: 
// Module Name:    Booth 
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
// problem no.: 3
// semester : 5th semester
// group no.: 64
// names of group members: 1. Jatoth Charan Sai, 2. Tirupathi Suguna Bhaskar.
//
//////////////////////////////////////////////////////////////////////////////////
module Booth(
    input signed[7:0] X,
    input signed[7:0] Y,
	 input clk,
	 input load,
    output reg signed[15:0] Z
    );
	reg [1:0] temp;
	integer i;
	reg E1;
	reg [15:0] Y1;
	always @ (posedge clk) begin
		if(load==1)
				begin
				Z = 16'd0;
				E1 = 1'd0;
				Y1 = - Y;
				Z[15:0]=X;
				i <= 0;
				end
		else
			begin
				if(i<8)
				begin
					temp = {X[i], E1};
					case (temp)
						2'd2 : Z [14 : 0] = {Z [15 : 8] + Y1,Z[7:1]};
						2'd1 : Z [14 : 0] = {Z [15 : 8] + Y,Z[7:1]};
						2'd0 : Z [14 : 0] = {Z[15:1]};
						2'd3 : Z [14 : 0] = {Z[15:1]};
						default : begin end
					endcase
					Z[15] = Z[14];
					E1 = X[i];
					i <= i+1;
				end
			end

	end

endmodule
