
module updn_count(clk, rst, updn, count);
	parameter CNT_LENGTH = 8; 
	// default count length = 8, from 0 to 7

	input 	clk, rst, updn;
	output 	reg [2:0] count;

	always @(posedge clk or posedge rst) begin
		if (rst)
			count = 3'd0;
		else begin
			if (updn == 1'b1) begin // count up
				if (count == (CNT_LENGTH[2:0]-3'd1))
					count = 3'd0;
				else
					count = count + 3'd1;
			end // if
			else begin // count down
				if (count == 3'd0)
					count = (CNT_LENGTH[2:0]-3'd1);
				else
					count = count - 3'd1;	
			end // else
		end // else
	end // always
endmodule
