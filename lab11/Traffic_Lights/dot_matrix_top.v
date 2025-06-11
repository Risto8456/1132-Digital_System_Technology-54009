module dot_matrix_top (clk, rst, J4, J7, J11, SEG7_5, SEG7_0);
	input clk, rst;
	output [8:1] J4, J7;
	output [8:1] J11;
	output [7:0] SEG7_5, SEG7_0;

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
	wire [15:0] col_ptn, col_ptn2, col_ptn3;
	wire [3:0] red_cnt, green_cnt;
	wire mode;

	freq_div #(16) 	m0(clk, ~rst, clk2);
	row_sel 		m1(clk2, ~rst, row_bin);
	pattern 		m2(row_bin + 1, col_ptn);
	pattern2 		m3(row_bin + 1, col_ptn2);
	pattern3 		m4(row_bin + 1, col_ptn3);
	ptn_sel 		m5(clk2, ~rst, mode, col_ptn, col_ptn2, col_ptn3, col);
	
	freq_div #(25) 	m6(clk, ~rst, clk3);
	red_green		m7(clk3, ~rst, red_cnt, green_cnt, mode);

	wire [6:0] seg7_red;
	wire dpt_red;
	wire [6:0] seg7_green;
	wire dpt_green;
	
	num_to_seg7_0_9 m8(red_cnt, seg7_red, dpt_red);
	num_to_seg7_0_9	m9(green_cnt, seg7_green, dpt_green);

	assign SEG7_0 = {dpt_red, seg7_red};
	assign SEG7_5 = {dpt_green, seg7_green};
endmodule