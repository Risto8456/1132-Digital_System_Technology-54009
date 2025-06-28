module S1254040_final_q01 (SW9,	SEG7_5, SEG7_4, SEG7_3, SEG7_2, SEG7_1, SEG7_0);
	input SW9;
	output [7:0] SEG7_5, SEG7_4, SEG7_3, SEG7_2, SEG7_1, SEG7_0;

	// ABCD = 5472
	// SW9 = 1 => A + B
	// SW9 = 0 => C * D
	wire [6:0] seg7_5, seg7_4, seg7_3, seg7_2, seg7_1, seg7_0;
	wire dpt_5, dpt_4, dpt_3, dpt_2, dpt_1, dpt_0;

	num_to_seg7_0_9	m5(4'd5, seg7_5, dpt_5);
	num_to_seg7_0_9 m4(4'd4, seg7_4, dpt_4);
	num_to_seg7_0_9 m3(4'd7, seg7_3, dpt_3);
	num_to_seg7_0_9 m2(4'd2, seg7_2, dpt_2);
	num_to_seg7_0_9 m1((SW9 == 1'b1 ? 4'd0 : 4'd1), seg7_1, dpt_1);
	num_to_seg7_0_9 m0((SW9 == 1'b1 ? 4'd9 : 4'd4), seg7_0, dpt_0);
	
	assign SEG7_5 = {dpt_5, seg7_5};
	assign SEG7_4 = {dpt_4, seg7_4};
	assign SEG7_3 = {dpt_3, seg7_3};
	assign SEG7_2 = {dpt_2, seg7_2};
	assign SEG7_1 = {dpt_1, seg7_1};
	assign SEG7_0 = {dpt_0, seg7_0};
endmodule