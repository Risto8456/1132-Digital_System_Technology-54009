module rom (ptn_cnt, num2, num1, num0);
    input [4:0] ptn_cnt;
    output reg [2:0] num2, num1, num0;

	always @(ptn_cnt) begin
		case(ptn_cnt)
			5'd0:{num2, num1, num0} = {3'd0, 3'd0, 3'd0};
			5'd1:{num2, num1, num0} = {3'd1, 3'd0, 3'd0};
			5'd2:{num2, num1, num0} = {3'd2, 3'd0, 3'd0};
			5'd3:{num2, num1, num0} = {3'd3, 3'd0, 3'd0};
			5'd4:{num2, num1, num0} = {3'd3, 3'd1, 3'd0};
			5'd5:{num2, num1, num0} = {3'd3, 3'd2, 3'd0};
			5'd6:{num2, num1, num0} = {3'd3, 3'd3, 3'd0};
			5'd7:{num2, num1, num0} = {3'd3, 3'd4, 3'd0};
			5'd8:{num2, num1, num0} = {3'd3, 3'd4, 3'd1};
			5'd9:{num2, num1, num0} = {3'd3, 3'd4, 3'd2};
			5'd10:{num2, num1, num0} = {3'd3, 3'd4, 3'd3};
			5'd11:{num2, num1, num0} = {3'd3, 3'd4, 3'd4};
			5'd12:{num2, num1, num0} = {3'd3, 3'd4, 3'd5};
			5'd13:{num2, num1, num0} = {3'd2, 3'd4, 3'd5};
			5'd14:{num2, num1, num0} = {3'd1, 3'd4, 3'd5};
			5'd15:{num2, num1, num0} = {3'd0, 3'd4, 3'd5};
			5'd16:{num2, num1, num0} = {3'd0, 3'd3, 3'd5};
			5'd17:{num2, num1, num0} = {3'd0, 3'd2, 3'd5};
			5'd18:{num2, num1, num0} = {3'd0, 3'd1, 3'd5};
			5'd19:{num2, num1, num0} = {3'd0, 3'd0, 3'd5};
			5'd20:{num2, num1, num0} = {3'd0, 3'd0, 3'd4};
			5'd21:{num2, num1, num0} = {3'd0, 3'd0, 3'd3};
			5'd22:{num2, num1, num0} = {3'd0, 3'd0, 3'd2};
			5'd23:{num2, num1, num0} = {3'd0, 3'd0, 3'd1};

			default:{num2, num1, num0} = {3'd0, 3'd0, 3'd0};
		endcase
    end // always
endmodule