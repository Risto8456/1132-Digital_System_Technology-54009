module UART_RX (
    input i_clk,
    input i_rst,
    input i_RX_Bit, 
    output [7:0] o_RX_Byte
);
    parameter [1:0] RX_START_ST = 2'd0;
    parameter [1:0] RX_DATA_ST = 2'd1;
    parameter [1:0] RX_STOP_ST = 2'd2;
    // 信號傳輸時,電路之狀態
    // 1. RX_START_ST:接收start信號
    // 2. RX_DATA_ST: 接收資料信號
    // 3. RX_STOP_ST: 接收stop信號

    reg [1:0] r_SM_Main = RX_START_ST;
    reg [2:0] r_Byte_Idx = 3'd0;
    reg [7:0] r_RX_Byte = 8'd0;
    assign o_RX_Byte = r_RX_Byte;
    // 1. r_SM_Main:紀錄電路之狀態
    // 2. r_Byte_Idx: 資料信號之bit index
    // 3. r_RX_Byte:傳送至輸出o_RX_Byte之信號

    // RX state machine
    always @(posedge i_clk or posedge i_rst) begin
        if (i_rst == 1'b1) begin
            r_Byte_Idx = 3'd0;
            r_RX_Byte = 8'd0;
            r_SM_Main = RX_START_ST;
        end
        else begin
            case (r_SM_Main)
                RX_START_ST: begin
                    r_Byte_Idx = 3'd0;

                    // 若接收到start信號為0, 資料傳輸啟動
                    if (i_RX_Bit == 1'b0) // start
                        // 跳至資料傳輸狀態
                        r_SM_Main = RX_DATA_ST;
                    else
                        // 否則維持在等待start的狀態
                        r_SM_Main = RX_START_ST;
                end // RX_START_ST
                RX_DATA_ST: begin
                    // 接收資料信號之某個bit
                    r_RX_Byte [r_Byte_Idx] = i_RX_Bit; // receive

                    if (r_Byte_Idx < 3'd7) begin
                        // 若資料信號尚未傳完,則在下一週期繼續接收下一個bit,電路狀態維持在RX_DATA_ST
                        r_Byte_Idx = r_Byte_Idx + 3'd1;
                        r_SM_Main = RX_DATA_ST;
                    end
                    else
                        r_SM_Main = RX_STOP_ST;
                        // 若資料信號已傳完(r_Byte_Idx==3′d7), 則在下一週期進入RX_STOP_ST狀態
                end // RX_DATA_ST
                // 結束資料傳輸,重新回到RX_START_ST狀態,等待下一次傳輸
                RX_STOP_ST: // stop
                    r_SM_Main = RX_START_ST;
                default :
                    r_SM_Main = RX_START_ST;
            endcase
        end
    end
endmodule