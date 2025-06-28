module S1254040_final_q03 (clk, rst, J4, J7, J11, led, SEG7_5, SEG7_4);
	input clk, rst;
	output [8:1] J4, J7;
	output [8:1] J11;
	output [9:0] led;
	output [7:0] SEG7_5, SEG7_4;

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

	wire clk2, clk_slow, clk_fast, clk3, clk_mod;
	freq_div #(16) 	m0(clk, ~rst, clk2);
	freq_div #(25) 	m1(clk, ~rst, clk_slow); // 1s
	freq_div #(24) 	m2(clk, ~rst, clk_fast); // 0.5s
	assign clk3 = clk_mod == 1'b0 ? clk_slow : clk_fast;

	wire [3:0] cnt;
	wire [3:0] num;
	updn_count #(10)m3(clk3, ~rst, 1'b1, cnt, clk_mod);
	rom_num			m4(cnt, num);
	
	row_sel 		m5(clk2, ~rst, row_bin);
	num_pattern 	m6(num, row_bin, col);

	rom_led			m7(num, led);

	wire [6:0] seg7_5, seg7_4;
	wire dpt_5, dpt_4;
	num_to_seg7_0_9 m8(((cnt == 4'd0 || cnt == 4'd4) ? num : 4'd10), seg7_5, dpt_5);
	num_to_seg7_0_9 m9(((cnt == 4'd2 || cnt == 4'd6 || cnt == 4'd8) ? num : 4'd10), seg7_4, dpt_4);
	assign SEG7_5 = {dpt_5, seg7_5};
	assign SEG7_4 = {dpt_4, seg7_4};
endmodule