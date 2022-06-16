`timescale 1ns / 1ps

module CLA_4(a,b, cin, sum,cout,P,G);
input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;
 
wire [3:0] p,g,c;
output P,G;
 
assign p=a^b;//propagate
// pi = ai ^ bi
assign g=a&b; //generate
// gi = ai & bi
assign G = g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
assign P = p[3]&p[2]&p[1]&p[0];

//carry=gi + Pi.ci

assign c[0]=cin;
assign c[1]= g[0]|(p[0]&c[0]);
assign c[2]= g[1] | (p[1]&g[0]) | p[1]&p[0]&c[0];
assign c[3]= g[2] | (p[2]&g[1]) | p[2]&p[1]&g[0] | p[2]&p[1]&p[0]&c[0];
assign cout= G | P&c[0];

// output sum

assign sum=p^c;
 
endmodule
