module S1254040_final_q02 (clk, rst, SW, J4, J7, J11, SEG7_5, SEG7_4, SEG7_3, SEG7_2);
	input clk, rst;
	input  [3:0] SW;
	output [8:1] J4, J7;
	output [8:1] J11;
	output [7:0] SEG7_5, SEG7_4, SEG7_3, SEG7_2;

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

	// ABCD = 5472
	reg [3:0] num;
	always@ (SW) begin
		if(SW[3] == 1'b1) num = 4'd5;		// A
		else if(SW[2] == 1'b1) num = 4'd4;	// B
		else if(SW[1] == 1'b1) num = 4'd7;	// C
		else if(SW[0] == 1'b1) num = 4'd2;	// D
		else num = 4'd10;					// X
	end

	wire clk2;
	freq_div #(16)	m0(clk, ~rst, clk2);
	row_sel			m1(clk2, ~rst, row_bin);
	num_pattern 	m2(num, row_bin + 1, col);

	wire [6:0] seg7_5, seg7_4, seg7_3, seg7_2;
	wire dpt_5, dpt_4, dpt_3, dpt_2;

	num_to_seg7_0_9	m3((num == 4'd5 ? num : 4'd10), seg7_5, dpt_5);
	num_to_seg7_0_9	m4((num == 4'd4 ? num : 4'd10), seg7_4, dpt_4);
	num_to_seg7_0_9	m5((num == 4'd7 ? num : 4'd10), seg7_3, dpt_3);
	num_to_seg7_0_9	m6((num == 4'd2 ? num : 4'd10), seg7_2, dpt_2);
	
	assign SEG7_5 = {dpt_5, seg7_5};
	assign SEG7_4 = {dpt_4, seg7_4};
	assign SEG7_3 = {dpt_3, seg7_3};
	assign SEG7_2 = {dpt_2, seg7_2};
endmodule