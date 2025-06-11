module S1254040_final_q01 (clk, rst, SW, J4, J7, J11, SEG7_0);
	input clk, rst;
	input  [3:0] SW;
	output [8:1] J4, J7;
	output [8:1] J11;
	output [7:0] SEG7_0;

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

	wire clk2;
	freq_div #(16) 	m0(clk, ~rst, clk2);

	reg [3:0] num;
	always@ (SW) begin
		num = (4'd4 + SW) % 4'd9;
	end
	// rom_num

	row_sel 		m1(clk2, ~rst, row_bin);
	num_pattern 	m2(num, row_bin + 1, col);

	wire [6:0] seg7;
	wire dpt;
	num_to_seg7_0_9 m3(num, seg7, dpt);
	assign SEG7_0 = {dpt, seg7};
endmodule