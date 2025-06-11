module S1254040_final_q02 (clk, rst, J4, J7, J11, led, SEG7_0, SEG7_1, SEG7_2, SEG7_3);
	input clk, rst;
	output [8:1] J4, J7;
	output [8:1] J11;
	output [9:0] led;
	output [7:0] SEG7_0, SEG7_1, SEG7_2, SEG7_3;

	wire [15:0] col;
	wire [3:0] row_bin;

	// col: J4
	assign J4[1] = ~col[15];
	assign J4[3] = ~col[14];
	assign J4[5] = ~col[13];
	assign J4[7] = ~col[12];
	assign J4[2] = ~col[11];
	assign J4[4] = ~col[10];
	assign J4[6] = ~col[9];
	assign J4[8] = ~col[8];
	// col: J7
	assign J7[1] = ~col[7];
	assign J7[3] = ~col[6];
	assign J7[5] = ~col[5];
	assign J7[7] = ~col[4];
	assign J7[2] = ~col[3];
	assign J7[4] = ~col[2];
	assign J7[6] = ~col[1];
	assign J7[8] = ~col[0];
	// row: J11
	assign J11[1] = row_bin[0];
	assign J11[3] = row_bin[1];
	assign J11[5] = row_bin[2];
	assign J11[7] = row_bin[3];

	wire clk2, clk3;
	freq_div #(16) 	m0(clk, ~rst, clk2);
	freq_div #(25) 	m1(clk, ~rst, clk3); // 1s

	wire [2:0] cnt;
	wire [3:0] num;
	updn_count #(8) m2(clk3, ~rst, 1'b1, cnt);
	rom_num			m3(cnt, num);
	
	row_sel 		m4(clk2, ~rst, row_bin);
	num_pattern 	m5(num, row_bin, col);

	rom_led			m6(num, led);

	wire [6:0] seg7_0, seg7_1, seg7_2, seg7_3;
	wire dpt_0, dpt_1, dpt_2, dpt_3;
	num_to_seg7_0_9 m7((cnt == 3'd6 ? num : 4'd10), seg7_0, dpt_0);
	num_to_seg7_0_9 m8((cnt == 3'd4 ? num : 4'd10), seg7_1, dpt_1);
	num_to_seg7_0_9 m9((cnt == 3'd2 ? num : 4'd10), seg7_2, dpt_2);
	num_to_seg7_0_9 m10((cnt == 3'd0 ? num : 4'd10), seg7_3, dpt_3);
	assign SEG7_0 = {dpt_0, seg7_0};
	assign SEG7_1 = {dpt_1, seg7_1};
	assign SEG7_2 = {dpt_2, seg7_2};
	assign SEG7_3 = {dpt_3, seg7_3};
endmodule