// Copyright (C) 1991-2007 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

module add_full(
	cin,
	a,
	b,
	sum,
	cout
);

input	cin;
input	a;
input	b;
output	sum;
output	cout;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





add_half	b2v_inst(.a(a),
.b(b),.sum(SYNTHESIZED_WIRE_0),.cout(SYNTHESIZED_WIRE_1));

add_half	b2v_inst1(.a(cin),
.b(SYNTHESIZED_WIRE_0),.sum(sum),.cout(SYNTHESIZED_WIRE_2));
assign	cout = SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2;


endmodule
