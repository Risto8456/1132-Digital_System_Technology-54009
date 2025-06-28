module rom_led (num, led);
	input [3:0] num;
	output reg [9:0] led;

    always @(num) begin
        case (num)
            3'd0: led = 10'b0000000001;
            3'd1: led = 10'b0000000010;
            3'd2: led = 10'b0000000100;
            3'd3: led = 10'b0000001000;
            3'd4: led = 10'b0000010000;
            3'd5: led = 10'b0000100000;
            3'd6: led = 10'b0001000000;
            3'd7: led = 10'b0010000000;
            3'd8: led = 10'b0100000000;
            3'd9: led = 10'b1000000000;

            default: led = 10'b0000000000; // X
        endcase
    end // always
endmodule