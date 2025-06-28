module rom_led (num, led);
	input [3:0] num;
	output reg [9:0] led;

    always @(num) begin
        case (num)
            3'd0: led = 10'b0000000001;
            3'd1: led = 10'b0000000011;
            3'd2: led = 10'b0000000111;
            3'd3: led = 10'b0000001111;
            3'd4: led = 10'b0000011111;
            3'd5: led = 10'b0000111111;
            3'd6: led = 10'b0001111111;
            3'd7: led = 10'b0011111111;
            3'd8: led = 10'b0111111111;
            3'd9: led = 10'b1111111111;

            default: led = 10'b0000000000; // X
        endcase
    end // always
endmodule
