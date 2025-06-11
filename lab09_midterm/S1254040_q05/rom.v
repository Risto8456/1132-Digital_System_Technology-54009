module rom (addr, num2, num1, num0);
    input [1:0] addr;
    output reg [2:0] num2, num1, num0;

    always @(addr) begin    // num [2:0] 對應到 3 個 seg7
        case (addr)
			2'd0:{num2, num1, num0} = {3'd0, 3'd0, 3'd0};
			2'd1:{num2, num1, num0} = {3'd4, 3'd4, 3'd4};
			2'd2:{num2, num1, num0} = {3'd3, 3'd3, 3'd3};
			2'd3:{num2, num1, num0} = {3'd2, 3'd2, 3'd2};
			
			default:{num2, num1, num0} = {3'd0, 3'd0, 3'd0};
            // 共 4 種圖案循環
        endcase
    end // always
endmodule