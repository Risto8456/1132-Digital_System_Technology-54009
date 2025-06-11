module circle_run_cnt (clk, rst, updn, ptn_cnt, run_cnt, counter);
    parameter CNT_LENGTH = 8;
    
    input clk, rst, updn;
    input [3:0] ptn_cnt;
    
    output reg [2:0] run_cnt;
    output reg counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            run_cnt = 3'd0;
            counter = 1'b0;
        end
        else begin
            if (updn == 1'b1) begin // count up
                if(ptn_cnt == (CNT_LENGTH[3:0] - 4'd1))
                    run_cnt = run_cnt + 3'd1;
                if (run_cnt == 3'd5) 
                    counter = 1'b1;
            end
            else begin // count down
                if(ptn_cnt == 4'd0) 
                    run_cnt = run_cnt - 3'd1;
                if (run_cnt == 3'd0) 
                    counter = 1'b0;
            end
        end
    end
endmodule