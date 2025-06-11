module red_green (clk_light_cnt, rst,
				  red_cnt, green_cnt, mode);
	// default time for each mode
	parameter GREEN_TIME = 4'd9; // 綠燈開始倒數秒數
	parameter RED_TIME   = 4'd5; // 紅燈開始倒數秒數
	
	// clk_light_cnt: 燈號倒數時脈,決定倒數的速度
	// red_cnt:   目前紅燈秒數
	// green_cnt: 目前綠燈秒數
	// mode=0: 綠燈模式, mode=1: 紅燈模式
	input clk_light_cnt, rst;
	output reg [3:0] red_cnt, green_cnt;
	output reg mode;
	
	always@ (posedge clk_light_cnt or posedge rst) begin
		if (rst) begin
			mode = 1'b0; // green mode
			green_cnt = GREEN_TIME; // initial time for green
			// 綠燈由GREEN_TIME開始倒數
			red_cnt = 4'd0; // initial time for red
		end
		else begin
			if (mode == 1'b0) begin // green mode
				// 1. 綠燈秒數遞減
				// 2. 判斷是否倒數結束
				// 3. 若是則切換至紅燈模式
				// 4. 設定紅燈秒數值為RED_TIME
				green_cnt = green_cnt - 4'd1;
				if (green_cnt == 4'd0) begin
					mode = 1'b1; // to red mode
					red_cnt = RED_TIME; // set time for red
				end
			end
			else if (mode == 1'b1) begin // red mode
				// 1. 紅燈秒數遞減
				// 2. 判斷是否倒數結束
				// 3. 若是則切換至綠燈模式
				// 4. 設定綠燈秒數值為GREEN_TIME
				red_cnt = red_cnt - 4'd1;
				if (red_cnt == 4'd0) begin
					mode = 1'b0; // to green mode
					green_cnt = GREEN_TIME; // set time for green
				end
			end
		end
	end
endmodule