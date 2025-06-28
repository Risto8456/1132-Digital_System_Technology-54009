
module updn_count(clk, rst, updn, count, clk_mod);
	parameter CNT_LENGTH = 8; 
	// default count length = 8, from 0 to 7

	input 				clk, rst, updn;
	output 	reg [4:0]	count;
	output 	reg 		clk_mod;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			count = 5'd0;
			clk_mod = 1'b0;
		end
		else begin
			if (updn == 1'b1) begin // count up
				if (count == (CNT_LENGTH[4:0]-5'd2))
					clk_mod = ~clk_mod;
				if (count == (CNT_LENGTH[4:0]-5'd1))
					count = 5'd0;
				else
					count = count + 5'd1;
			end // if
			else begin // count down
				if (count == 5'd0)
					count = (CNT_LENGTH[4:0]-5'd1);
				else
					count = count - 5'd1;	
			end // else
		end // else
	end // always
endmodule
