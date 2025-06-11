module row_sel (clk, rst, row_bin);
	input clk, rst;
	output reg [3:0] row_bin;

	always@ (posedge clk or posedge rst) begin
		if (rst)
			row_bin = 4'd0;
			// top-most 初始值,選取最上方row
		else // shift down
			row_bin = row_bin + 4'd1;
			// row_bin之值遞增(0~15),依序選取下方row
	end
endmodule