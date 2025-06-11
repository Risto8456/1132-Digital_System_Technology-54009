module cnt_00_59_bcd(clk, rst, carry_out, cnt1, cnt0);
    input clk, rst;
    output carry_out;
    output reg [2:0] cnt1;
    output reg [3:0] cnt0;

    // {cnt1, cnt0} = 59 時產生進位 (carry_out=1) 至小時部分
    assign carry_out = ({cnt1, cnt0} == {3'd5, 4'd9}) ? 1'b1 : 1'b0;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            {cnt1, cnt0} = {3'd0, 4'd0}; // 00
        else
            if ({cnt1, cnt0} == {3'd5, 4'd9}) // 59->00
                {cnt1, cnt0} = {3'd0, 4'd0};
            else if (cnt0 == 4'd9)
                // 09->10, 19->20, 29->30, 39->40, 49->50
                {cnt1, cnt0} = {cnt1 + 3'd1, 4'd0};
            else
                cnt0 = cnt0 + 4'd1; // +1
    end // always
endmodule
// {cnt1, cnt0} = 00, 01, 02, 03, ..., 58, 59, 00, 01, 02, ...