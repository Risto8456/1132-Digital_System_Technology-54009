module num_to_seg7_0_9(num, seg7, dpt);
	input		[3:0] num;
	output  	[6:0] seg7;
	output  	dpt;
	reg  		[6:0] seg7;
	reg     	dpt; 

	always @(num)
		case(num)			      //  gfedcba, dpt
			4'b0000:{seg7, dpt} = {7'b1000000, 1'b1}; // 0
			4'b0001:{seg7, dpt} = {7'b1111001, 1'b1}; // 1
			4'b0010:{seg7, dpt} = {7'b0100100, 1'b1}; // 2
			4'b0011:{seg7, dpt} = {7'b0110000, 1'b1}; // 3
			4'b0100:{seg7, dpt} = {7'b0011001, 1'b1}; // 4
			4'b0101:{seg7, dpt} = {7'b0010010, 1'b1}; // 5
			4'b0110:{seg7, dpt} = {7'b0000010, 1'b1}; // 6
			4'b0111:{seg7, dpt} = {7'b1111000, 1'b1}; // 7
			4'b1000:{seg7, dpt} = {7'b0000000, 1'b1}; // 8
			4'b1001:{seg7, dpt} = {7'b0011000, 1'b1}; // 9
			
			default:{seg7, dpt} = {7'b1111111, 1'b1};
		endcase
endmodule
