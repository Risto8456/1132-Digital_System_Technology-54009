module UART_TX (
    input i_clk,
    input i_rst,
    input [7:0] i_TX_Byte,
    output o_TX_Bit
);
    parameter [1:0] TX_START_ST = 2'd0;
    parameter [1:0] TX_DATA_ST = 2'd1;
    parameter [1:0] TX_STOP_ST = 2'd2;
    // 信號傳輸時,電路之狀態
    // 1. TX_START_ST:傳送start信號
    // 2. TX_DATA_ST: 傳送資料信號
    // 3. TX_STOP_ST: 傳送stop信號

    reg [1:0] r_SM_Main = TX_START_ST;
    reg [2:0] r_Byte_Idx = 3'd0;
    reg r_TX_Bit = 1'b1;
    assign o_TX_Bit = r_TX_Bit;
    // 1. r_SM_Main:紀錄電路之狀態
    // 2. r_Byte_Idx: 資料信號之bit index
    // 3. r_TX_Bit:傳送至輸出o_TX_Bit之信號

    // TX state machine
    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst == 1'b1) begin
            r_Byte_Idx = 3'd0;
            r_TX_Bit = 1'b1;
            r_SM_Main = TX_START_ST;
        end
        else begin
            case (r_SM_Main)
                TX_START_ST: begin
                    r_Byte_Idx = 3'd0;
                    // 啟動資料傳輸, start信號設為0
                    r_TX_Bit = 1'b0; // start
                    // 跳至資料傳輸狀態
                    r_SM_Main = TX_DATA_ST;
                end // TX_START_ST
                TX_DATA_ST: begin
                    // 傳送資料信號之某個bit
                    r_TX_Bit = i_TX_Byte[r_Byte_Idx]; // send

                    // 若資料信號尚未傳完,則在下一週期繼續傳送下一個bit,電路狀態維持在TX_DATA_ST
                    if (r_Byte_Idx < 3'd7) begin
                        r_Byte_Idx = r_Byte_Idx + 3'd1;
                        r_SM_Main = TX_DATA_ST;
                    end
                    // 若資料信號已傳完(r_Byte_Idx==3'd7), 則在下一週期進入TX_STOP_ST狀態
                    else
                        r_SM_Main = TX_STOP_ST;
                end // TX_DATA_ST
                TX_STOP_ST: begin
                    // 1. 結束資料傳輸,stop信號設為1
                    // 2.重新回到TX_START_ST狀態,開啟下一次資料傳輸
                    r_TX_Bit = 1'b1; // stop
                    r_SM_Main = TX_START_ST;
                end // TX_STOP_ST
                default:
                    r_SM_Main = TX_START_ST;
            endcase
        end
    end
endmodule