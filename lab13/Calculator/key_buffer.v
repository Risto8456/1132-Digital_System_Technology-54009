module key_buffer(clk, rst, press, scan_code, sum);

    input clk, rst, press;
    input [3:0] scan_code;

    reg [5:0] buf_flag_1; // 6 numbers
    reg [23:0] key_buf_code_1;
    reg [5:0] buf_flag_2; // 6 numbers
    reg [23:0] key_buf_code_2;
    
    reg [19:0] add_1, add_2;
    output reg [20:0] sum;
    
    // 1. press為1時表示keyboard有按鍵被按下
    // 2. scan_code[3:0]為所按下之鍵的二進位編碼
    // 3. buf_flag_1[5:0]&buf_flag_2[5:0]為記錄buffer電路中每個位置是否有數字存入
    // 4. key_buf_code_1[23:0]&key_buf_code_2[23:0]為存放6個數字之24位元buffer電路, 每個數字4個位元。
    // 5. add_1[19:0] & add_2[19:0] 為欲相加之兩個數字,sum [20:0]為相加後之結果。
    
    reg cal_state;
    // cal_state=0, add_1 
    // cal_state=1, add_2 
    // sum = add_1 + add_2

    reg [3:0] decimal_num;
    integer i, j;
    // 1. cal_state記錄目前所輸入之值為add_1 (cal_state=0)或是add_2 (cal_state=1)。
    // 2. decimal_num紀錄key_buf_code_1[23:0] & key_buf_code_2[23:0]中所存放的某一個4-bit數字之值。

    always@ (posedge clk or posedge rst) begin
        if (rst) begin
            buf_flag_1 = 6'b000000; // 初始時,buffer電路是空的
            key_buf_code_1 = 24'h000000;
            buf_flag_2 = 6'b000000; // 初始時,buffer電路是空的
            key_buf_code_2 = 24'h000000;

            add_1 = 20'd0;
            add_2 = 20'd0;
            sum = 21'd0;

            cal_state = 1'b0; // add_1
        end
        else begin
            if (press == 1'b1) begin
                // 若有0-9鍵按下,數字將存入buffer
                if (scan_code >= 4'h0 && scan_code <= 4'h9) begin // key 0-9
                    // 由 cal_state 決定資料是要存入
                    // key_buf_code_1 或是 key_buf_code_2
                    if (cal_state == 1'b0) begin // add_1
                        // buf_flag_1[0]設為1,原 buf_flag_1 [4:0]之值左移
                        buf_flag_1 = {buf_flag_1[4:0], 1'b1};
                        key_buf_code_1[23:0] = {key_buf_code_1[19:0], scan_code};
                    end
                    else begin // add_2
                        buf_flag_2 = {buf_flag_2[4:0], 1'b1};
                        key_buf_code_2[23:0] = {key_buf_code_2[19:0], scan_code};
                    end
                end
                // 若有”+”鍵按下,將add_1 (cal_state=0) 切換至add_2 (cal_state=1)
                else if (scan_code == 4'hc) begin // key C, "+"
                    cal_state = 1'b1; // to add 2
                end
                // 若有”=”鍵按下,
                // 先將被加數BCD編碼轉換為add_1之二進位編碼,
                // 再將加數BCD編碼轉換為add_2之二進位編碼,
                // 最後將add_1 與 add_2相加,存至sum
                else if (scan_code == 4'hd) begin // key D, "=", sum = add_1 + add_2
                    // 產生add_1
                    for (i = 0; i < 6; i = i + 1) begin
                        decimal_num = 4'd0;
                        if (buf_flag_1[i] == 1'b1) begin
                            for (j = 0; j < 4; j = j + 1)
                                decimal_num[j] = key_buf_code_1[i * 4 + j];
                                // 擷取key_buf_code_1中4-bit之資料
                            add_1 = add_1 + decimal_num * (10**i);
                        end
                    end
                    // 產生add_2
                    for (i = 0; i < 6; i = i + 1) begin
                        decimal_num = 4'd0;
                        if (buf_flag_2[i] == 1'b1) begin
                            for (j = 0 ;j < 4; j = j + 1)
                                decimal_num[j] = key_buf_code_2[i * 4 + j];
                                // 擷取key_buf_code_2中4-bit之資料
                            add_2 = add_2 + decimal_num * (10**i);
                        end
                    end
                    sum = add_1 + add_2;
                end
                // 若有”Clr”鍵按下,清除所有資料,類似reset的動作
                else if (scan_code == 4'he) begin // key E, clear
                    buf_flag_1 = 6'b000000;
                    key_buf_code_1 = 24'h000000;
                    buf_flag_2 = 6'b000000;
                    key_buf_code_2 = 24'h000000;
                    add_1 = 20'd0;
                    add_2 = 20'd0;
                    sum = 21'd0;
                end
            end
        end
    end
endmodule