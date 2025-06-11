module key_buffer(
    clk, rst, press, scan_code, 
    buf_flag, key_buf_code);
    input clk, rst, press;
    input [3:0] scan_code;
    output reg [6:0] buf_flag;
    output reg [27:0] key_buf_code;
    
    // 1. press為1時表示keyboard有按鍵被按下
    // 2. scan_code[3:0]為所按下之鍵的二進位編碼
    // 3. buf_flag [6:0]為記錄buffer電路中每個位置是否有數字存入
    // 4. key_buf_code[27:0]為存放7個數字之24位元buffer電路, 每個數字4個位元。

    always@ (posedge clk or posedge rst) begin
        if (rst) begin
            buf_flag = 7'b0000000; // 初始時,buffer電路是空的
            key_buf_code = 28'h0000000;
        end
        else
        // 若有按鍵按下,數字將存入buffer
        // buf_flag[0]設為1,原 buf_flag [5:0]之值左移
            if (press == 1'b1) begin
                buf_flag = {buf_flag[5:0], 1'b1};
                key_buf_code[27:0] = {key_buf_code[23:0], scan_code};
            end
    end
endmodule
// 所按之鍵的二進位編碼scan_code[3:0]存入
// key_buf_code[3:0],原本的[27:24]左移出
// buffer,[23:0]左移1個數字(4個位元)