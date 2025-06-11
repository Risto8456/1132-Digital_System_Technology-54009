// divided by N
// parameter (N, WIDTH)
module freq_div_n(clk, rst, clk_out);
	input clk, rst;
	output clk_out;
	
	parameter N = 9;	
	parameter WIDTH = 4;
	// divided by default 9, 4-bit width
	
	reg [WIDTH-1:0] cnt_pos, cnt_neg; // 0~(N-1)
	reg clk_pos, clk_neg;
	
	assign clk_out = 
			(N == 1) ? clk : // same freq
			(N[0] == 0) ? (clk_pos) : (clk_pos | clk_neg);
		                // N is even    // N is odd 
        
	always@(posedge clk or posedge rst) begin
		if (rst)
			cnt_pos = 0;
		else if (cnt_pos == (N-1))
			cnt_pos = 0;
		else
			cnt_pos = cnt_pos+1'b1;
	end // always
	
	always@(posedge clk or posedge rst) begin
		if (rst)
			clk_pos = 0;
		else if (cnt_pos < (N>>1)) // (N-1)/2 
			clk_pos = 1;
		else 
			clk_pos = 0;
	end // always

	always@(negedge clk or posedge rst) begin
		if (rst)
			cnt_neg = 0;
		else if (cnt_neg == (N-1))
			cnt_neg = 0;
		else
			cnt_neg = cnt_neg+1'b1;
	end // always

	always@(negedge clk or posedge rst) begin
		if (rst)
			clk_neg = 0;
		else if (cnt_neg < (N>>1)) // (N-1)/2 
			clk_neg = 1;
		else 
			clk_neg = 0;
	end // always
endmodule
