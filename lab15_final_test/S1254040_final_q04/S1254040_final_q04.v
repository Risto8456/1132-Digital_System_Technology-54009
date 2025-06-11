module S1254040_final_q04 (A, B, SEG7_0, SEG7_1, SEG7_2);
	input  [4:0] A, B;
	output [7:0] SEG7_0, SEG7_1, SEG7_2;

	wire [9:0] num;
	assign num = A * B;

	wire [6:0] seg7_0, seg7_1, seg7_2;
	wire dpt_0, dpt_1, dpt_2;

	num_to_seg7_0_9 m0(num%10, seg7_0, dpt_0);
	num_to_seg7_0_9 m1(num/10%10, seg7_1, dpt_1);
	num_to_seg7_0_9 m2(num/100, seg7_2, dpt_2);

	assign SEG7_0 = {dpt_0, seg7_0};
	assign SEG7_1 = {dpt_1, seg7_1};
	assign SEG7_2 = {dpt_2, seg7_2};
endmodule