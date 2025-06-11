// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"
// CREATED		"Wed Feb 26 10:33:07 2025"

module add_full(
	cin,
	a,
	b,
	sum,
	cout
);


input wire	cin;
input wire	a;
input wire	b;
output wire	sum;
output wire	cout;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





add_half	b2v_inst(
	.a(cin),
	.b(SYNTHESIZED_WIRE_0),
	.sum(sum),
	.cout(SYNTHESIZED_WIRE_2));


add_half	b2v_inst1(
	.a(a),
	.b(b),
	.sum(SYNTHESIZED_WIRE_0),
	.cout(SYNTHESIZED_WIRE_1));

assign	cout = SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2;


endmodule
