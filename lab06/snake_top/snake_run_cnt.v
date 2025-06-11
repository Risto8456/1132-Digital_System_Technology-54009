module snake_run_cnt (clk, rst, updn, ptn_cnt, run_cnt, run_stop);
    parameter CNT_LENGTH = 8;
    // default count length = 8, from 0 to 7
    // 使用此 module 時, 透過 #(20) 參數傳遞, 將 CNT_LENGTH 設定為 20

    input clk, rst, updn;
    input [4:0] ptn_cnt;
    // number of pattern counts from 0-to-19 or 19-to-0
    
    output reg [3:0] run_cnt;
    // number of run counts from 0-to-9
    output reg run_stop;

    reg [3:0] run_cnt_tmp;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            run_cnt = 4'd0;
            run_stop = 1'b0;
            run_cnt_tmp = 4'd1;
        end
        else begin
                // count up
            if ((updn == 1'b1 && ptn_cnt == (CNT_LENGTH[4:0]-5'd1)) ||
                // count down
                (updn == 1'b0 && ptn_cnt == 5'd0)) begin
                run_cnt_tmp = run_cnt_tmp + 4'd1;
            end

            if (run_cnt_tmp <= 4'd9) begin
                run_cnt = run_cnt_tmp;
            end
            else begin
                run_stop = 1'b1;
            end
        end
    end
endmodule