module bin2bcd(bin, bcd);
    input [7:0] bin;
    output reg [11:0] bcd;
    integer i;   
     
    always @(bin) begin
		bcd = 0;
        for (i = 0; i < 8; i = i+1) begin
                bcd = {bcd[10:0],bin[7-i]};
                    
            // if a hex digit of bcd is more than 4, add 3 to it  
            if (i<7 && bcd[3:0]>4) 
				bcd[3:0] = bcd[3:0] + 4'd3;
            if (i<7 && bcd[7:4]>4)
				bcd[7:4] = bcd[7:4] + 4'd3;
            if (i<7 && bcd[11:8]>4)
				bcd[11:8] = bcd[11:8] + 4'd3;  
		end
	end                 
endmodule
