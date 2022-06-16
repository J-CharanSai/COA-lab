`timescale 1ns / 1ps


module CLA_4test;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg cin;

	// Outputs
	wire [3:0] sum;
	wire cout;
	wire P;
	wire G;

	// Instantiate the Unit Under Test (UUT)
	CLA_4 uut (
		.a(a), 
		.b(b), 
		.cin(cin), 
		.sum(sum), 
		.cout(cout), 
		.P(P), 
		.G(G)
	);

	initial begin
		a = 4'b0000;
		b = 4'b0000;
		cin = 0;
		#2 
		a = 4'b0001;
		b = 4'b0001;
		cin = 1;
		#2 
		a = 4'b0010;
		b = 4'b1000;
		cin = 1;
		#2 
		a = 4'b0110;
		b = 4'b0001;
		cin = 1;
		#2 
		a = 4'b1110;
		b = 4'b0001;
		cin = 1;
		#2 
		a = 4'b1111;
		b = 4'b1111;
		cin = 1;
		#2 
$finish;

	end
      
endmodule

