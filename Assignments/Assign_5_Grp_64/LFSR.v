`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:34:17 09/24/2021 
// Design Name: 
// Module Name:    LFSR 
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
//
//////////////////////////////////////////////////////////////////////////////////
module LFSR(
	input [3:0] seed,
	input res,
	input clk,
	input sel,
	output wire [3:0] w
    );
	 wire wx;
	 wire [3:0] wi;
	 //initial w = 4'b0000; 			// initially w = 0
		
		
		// 4 mux's and 4 D-flipflops are connected in serial as in circuit diagram
		DFF d3(.I(wi[3]),.clk(clk),.res(res),.O(w[2])); 	
		DFF d2(.I(wi[2]),.clk(clk),.res(res),.O(w[1]));
		DFF d1(.I(wi[1]),.clk(clk),.res(res),.O(w[0]));
		DFF d0(.I(wi[0]),.clk(clk),.res(res),.O(wx));
		assign w[3] = wx^w[0]; 		// xor as in circuit diagram
		MUX m3(.a(seed[3]),.b(w[3]), .s(sel), .O(wi[3]));
		MUX m2(.a(seed[2]),.b(w[2]), .s(sel), .O(wi[2]));
		MUX m1(.a(seed[1]),.b(w[1]), .s(sel), .O(wi[1]));
		MUX m0(.a(seed[0]),.b(w[0]), .s(sel), .O(wi[0]));
		
	


endmodule
