module circle_run_cnt (clk, rst, ptn_cnt, run_cnt, run_stop);
    parameter CNT_LENGTH = 8;
    
    input clk, rst;
    input [3:0] ptn_cnt;
    
    output reg [2:0] run_cnt;
    output reg run_stop;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            run_cnt = 3'd0;
            run_stop = 1'b0;
        end
        else begin
            if(ptn_cnt == (CNT_LENGTH[3:0] - 4'd1))
                run_cnt = run_cnt + 3'd1;
            if (run_cnt == 3'd7) 
                run_stop = 1'b1;
        end
    end
endmodule