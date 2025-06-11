module ptn_sel (clk, rst, mode, col_ptn, col_ptn2, col_ptn3, col);
	input clk, rst;
	input mode;	// mode=0:綠燈模式, mode=1:紅燈模式
	input [15:0] col_ptn, col_ptn2, col_ptn3;
	// col_ptn: 綠燈行走圖形
	// col_ptn2:綠燈行走圖形2
	// col_ptn3:紅燈停止圖形

	output reg [15:0] col;
	reg [7:0] ptn_cnt;
	// ptn_cnt: 紀錄綠燈時,每一圖形之停留
	// 時間(0~255),以row掃描週期為計數單位
	reg ptn_flag;

	always@ (posedge clk or posedge rst) begin
		if (rst) begin
			ptn_cnt = 8'b0; // ptn_flag: 紀錄綠燈時,目前所輸出之圖形
			ptn_flag = 1'b0;// ptn_flag=0: 送出col_ptn
			col = col_ptn; 	// ptn_flag=1: 送出col_ptn2
		end
		else begin
			if (mode == 1'b0) begin // green mode
				ptn_cnt = ptn_cnt + 8'd1; // from 0 to 255
				// 圖形之停留時間(0~255)遞增1
				if (ptn_cnt == 8'b0)
					ptn_flag = ~ptn_flag;
					// 當圖形之顯示時間到達255,切換圖形
				
				// 依據目前ptn_flag之值, 產生對應圖形之col值,
				col = (ptn_flag==1'b0) ? col_ptn : col_ptn2;
			end
			else if (mode == 1'b1) // red mode
				col = col_ptn3;
				// 紅燈時,僅顯示一種圖形col_ptn3
		end
	end
endmodule