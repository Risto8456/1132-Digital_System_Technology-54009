module num_to_seg7_0_F(buf_flag, num, seg7, dpt);
	input		buf_flag;
	input		[3:0] num;
	output  	[6:0] seg7;
	output  	dpt;
	
	reg  		[6:0] seg7;
	reg     	dpt; 


	always @(buf_flag or num)
	
	if (buf_flag == 1'b1)
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
			4'b1001:{seg7, dpt} = {7'b0010000, 1'b1}; // 9			
			4'b1010:{seg7, dpt} = {7'b0001000, 1'b1}; // A	
			4'b1011:{seg7, dpt} = {7'b0000011, 1'b1}; // b	
			4'b1100:{seg7, dpt} = {7'b1000110, 1'b1}; // C	
			4'b1101:{seg7, dpt} = {7'b0100001, 1'b1}; // d	
			4'b1110:{seg7, dpt} = {7'b0000110, 1'b1}; // E	
			4'b1111:{seg7, dpt} = {7'b0001110, 1'b1}; // F	
			default:{seg7, dpt} = {7'b1111111, 1'b1};
		endcase
	else
		{seg7, dpt} = {7'b1111111, 1'b1};
endmodule
