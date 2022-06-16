`timescale 1ns / 1ps

module CLA_16(a,b,cin,sum,cout,P,G);
	 input[15:0] a,b;
	input cin;
	output [15:0] sum;
	output cout;
	output [3:0] P,G;
	wire [2:0] c;
	wire [3:0] tc;
	
	//lookahead carry unit
	assign c[0] = G[0] | (P[0]&cin);
	assign c[1] = G[1] | (P[1]&c[0]);
	assign c[2] = G[2] | (P[2]&c[1]);
	assign cout = G[3] | (P[3]&c[2]);
	
	CLA_4 c1(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(sum[3:0]),.cout(tc[0]),.P(P[0]),.G(G[0]));
	CLA_4 c2(.a(a[7:4]),.b(b[7:4]),.cin(c[0]),.sum(sum[7:4]),.cout(tc[1]),.P(P[1]),.G(G[1]));
	CLA_4 c3(.a(a[11:8]),.b(b[11:8]),.cin(c[1]),.sum(sum[11:8]),.cout(tc[2]),.P(P[2]),.G(G[2]));
	CLA_4 c4(.a(a[15:12]),.b(b[15:12]),.cin(c[2]),.sum(sum[15:12]),.cout(tc[3]),.P(P[3]),.G(G[3]));

endmodule
