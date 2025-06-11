module cnt_00_23_bcd(clk, rst, en, cnt1, cnt0);
    input clk, rst, en;
    output reg [1:0] cnt1;
    output reg [3:0] cnt0;

    always @(posedge clk or posedge rst) begin
        if (rst)
            {cnt1, cnt0} = {2'd0, 4'd0}; // 00
        else if(en == 1'b1) begin
            if ({cnt1, cnt0} == {2'd2, 4'd3}) // 23->00
                {cnt1, cnt0} = {2'd0, 4'd0};
            else if (cnt0 == 4'd9)
                // 09->10, 19->20
                {cnt1, cnt0} = {cnt1 + 2'd1, 4'd0};
            else
                cnt0 = cnt0 + 4'd1; // +1
        end // else if
    end // always
endmodule
// {cnt1, cnt0} = 00, 01, 02, 03, ..., 58, 59, 00, 01, 02, ...