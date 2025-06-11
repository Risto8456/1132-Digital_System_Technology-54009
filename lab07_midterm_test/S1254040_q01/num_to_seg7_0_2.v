
module num_to_seg7_0_2(num, seg7, dpt);
	input		[1:0] num;
	output  	[6:0] seg7;
	output  	dpt;
	reg  		[6:0] seg7;
	reg     	dpt;

	always @(num)
		case(num)			      //  gfedcba, dpt
			4'b0000:{seg7, dpt} = {7'b1000000, 1'b1}; // 0
			4'b0001:{seg7, dpt} = {7'b1111001, 1'b1}; // 1
			4'b0010:{seg7, dpt} = {7'b0100100, 1'b1}; // 2
			
			default:{seg7, dpt} = {7'b1111111, 1'b1};
		endcase
endmodule
