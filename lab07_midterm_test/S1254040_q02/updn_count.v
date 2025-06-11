
module updn_count(clk, rst, updn, count);
	parameter CNT_LENGTH = 8; 
	// default count length = 8, from 0 to 7

	input 	clk, rst, updn;
	output 	reg [4:0] count;
	// max count length = 32, from 0 to 31

	always @(posedge clk or posedge rst) begin
		if (rst)
			count = 5'd0;
		else begin
			if (updn == 1'b1) begin // count up
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
