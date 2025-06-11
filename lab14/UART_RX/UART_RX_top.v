module UART_RX_top (
    input i_clk,
    input i_rst_b,
    input i_RX_Bit,
    output [7:0] o_RX_Byte_b
);

    // 1. i_RX_Bit:接至FTDI232傳送端之輸入信號
    // 2. o_RX_Byte_b[7:0]:接至led的8-bit輸出信號

    wire rst = ~i_rst_b;
    wire clk_div;

    freq_div_n # (868, 10) m0 (i_clk, rst, clk_div);
    wire [7:0] r_RX_Byte;
    UART_RX m1 (clk_div, rst, i_RX_Bit, r_RX_Byte);
    assign o_RX_Byte_b = r_RX_Byte;
endmodule
// DE10實驗板之工作時脈為50MHz,
// 假設資料傳輸之 baud rate為57,600,
// 則實驗板時脈必須先經過除頻, 
// 50,000,000/57,600 = 868,
// 因此除頻電路需要10個bits