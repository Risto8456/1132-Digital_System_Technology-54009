module mod(clk, rst, cnt, num1, num0);
	input 	clk, rst;
    input [4:0] cnt;
	output 	reg [3:0] num1, num0;
    reg switch;
    
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			num1 = 4'd0;
			num0 = 4'd0;
            switch = 1'b0;
        end
		else begin
            num1 = cnt <= 5'd5 ? cnt : 
                   cnt <= 5'd10 ? 5'd5 : 
                   cnt <= 5'd14 ? cnt - 5'd5 : 5'd0;
            num0 = cnt <= 5'd5 ? 5'd0 : 
                   cnt <= 5'd10 ? cnt - 5'd5 : 
                   cnt <= 5'd14 ? 5'd5 : cnt - 5'd10;
		end // else
	end // always
endmodule
