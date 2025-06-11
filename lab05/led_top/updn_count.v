module updn_count (clk, rst, updn, count);
    parameter CNT_LENGTH = 8;
    // default count length = 8, from 0 to 7

    //updn=1, count up: 0, 1, ..., 7, 0, ...
    //updn=0, count down: 0, 7, ..., 1, 0, ...
    input clk, rst, updn;
    output reg [0:5] count;
    // max count length = 32, from 0 to 31
    // Default # of bits = 5

    always @(posedge clk or posedge rst) begin
        if (rst)
            count = 5'd0;
        else begin
            if (updn == 1'b1) begin // count up
                if (count == CNT_LENGTH - 1) // 0, 1, 2, ..., 6, {7}, 0, 1, ...
                        count = 5'd0;
                else // {0, 1, 2, ..., 6}, 7, 0, 1, ...
                    count = count + 1;
            end // if
            else begin // count down
                if (count == 5'd0) // {0}, 7, 6, ..., 1, {0}, 7, 6, ...
                    count = CNT_LENGTH - 1;
                else // 0, {7, 6, ..., 1}, 0, 7, 6, ...
                    count = count - 1;
            end // else
        end // else
    end // always
endmodule