`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:29:17 09/29/2021 
// Design Name: 
// Module Name:    B_SA 
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
module B_SA(
	input [7:0] a,
	input [7:0] b,
	input load,
	input clk,
	input res,
	output reg [7:0] Sum
    );
	 wire al, bl, Co, S;
	 reg Ci;
	 
	 initial Ci = 1'b0;
	 initial Sum = 8'b00000000;
	 
	 Shift_reg_R ar(.a(a),.load(load), .clk(clk), .out(al));
	 Shift_reg_R br(.a(b),.load(load), .clk(clk), .out(bl));
	 
	 assign S = (al ^ bl) ^ Ci;
	 assign Co = (al & bl) | (Ci & (al ^ bl));
	 
	 always @(posedge clk)
	 begin
		if(res)
			begin
				Ci <= 1'b0;
				Sum <= 8'b00000000;
			end
		else
			begin
				if(Co == 1'b0 || Co == 1'b1) Ci <= Co;
				else Ci <= 1'b0;
				Sum <= {1'b0,Sum[7:1]};
				if(S == 1'b0 || S == 1'b1) Sum[7] <= S;
				else Sum[7] <= 1'b0;
			end
	 end

endmodule

