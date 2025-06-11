module alarm_clock(
    clk, rst, hr1, hr0, min1, min0, 
    cnt3, cnt2, cnt1, cnt0, led_on);

    input clk, rst;

    input [1:0] hr1;
    input [3:0] hr0;
    input [2:0] min1;
    input [3:0] min0;

    output [1:0] cnt3;
    output [3:0] cnt2;
    output [2:0] cnt1;
    output [3:0] cnt0;

    output reg led_on;

    reg [3:0] dur_cnt;
    // time for led on, 10 mins

    // 鬧鐘有動作, led_on = 1, led 亮
    // 鬧鐘無動作, led_on = 0, led 暗
    // dur_cnt: 記錄鬧鐘動作之時間,預設為 10 分鐘關閉鬧鐘

    clock m0(clk, rst, cnt3, cnt2, cnt1, cnt0);

    always @(posedge clk or posedge rst) begin
        if (rst)
            led_on = 1'b0; 
        else begin 
            // alarm on
            // {hr1, hr0, min1, min0} <-> {cnt3, cnt2, cnt1, cnt0}
            // {a, a, a, (1-9)} <-> {a, a, a, (0-8)}, ex. 10:28 <-> 10:27
            // {a, a, (1-5), 0} <-> {a, a, (0-4), 9}, ex. 12:30 <-> 12:29
            // {a, (1-9), 0, 0} <-> {a, (0-8), 5, 9}, ex. 15:00 <-> 14:59
            // {(1-2), 0, 0, 0} <-> {(0-1), 9, 5, 9}, ex. 20:00 <-> 19:59
            // {0, 0, 0, 0}     <-> {2, 3, 5, 9}    , ex. 00:00 <-> 23:59
            // 為使鬧鐘在設定之時間啟動 (led on)
            // 當目前時間為 (設定時間-1 min) 時, led_on 設定為 1
            

            if (((cnt3 == hr1)             && (cnt2 == hr0)             && (cnt1 == min1)             && (cnt0 == min0-1'b1)) || 
                ((cnt3 == hr1)             && (cnt2 == hr0)             && (cnt1 == min1-1'b1)        && (cnt0==4'd9)&&(min0==4'd0)) || 
                ((cnt3 == hr1)             && (cnt2 == hr0-1'b1)        && (cnt1==3'd5)&&(min1==3'd0) && (cnt0==4'd9)&&(min0==4'd0)) || 
                ((cnt3 == hr1-1'b1)        && (cnt2==4'd9)&&(hr0==4'd0) && (cnt1==3'd5)&&(min1==3'd0) && (cnt0==4'd9)&&(min0==4'd0)) || 
                ((cnt3==2'd2)&&(hr1==2'd0) && (cnt2==4'd3)&&(hr0==4'd0) && (cnt1==3'd5)&&(min1==3'd0) && (cnt0==4'd9)&&(min0==4'd0))
                ) begin 
                // 鬧鐘開始動作, led_on = 1, led 亮
                led_on = 1'b1;
                dur_cnt = 4'd0;
            end // if

            if (led_on == 1'b1) begin
                // 鬧鐘動作時間遞增 1 min
                dur_cnt = dur_cnt + 4'd1;

                // 鬧鐘動作時間是否已到10 mins,判斷10?
                if (dur_cnt == 4'd11)
                    led_on = 1'b0;
                    // 鬧鐘結束動作, led_on = 0, led 暗
            end // if
        end // else
    end // always
endmodule