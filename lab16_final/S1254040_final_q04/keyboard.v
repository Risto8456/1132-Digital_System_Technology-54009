module keyboard (kr, kc, press, scan_code);
    input [3:0] kr;
    input [3:0] kc;
    output reg press;
    output reg [3:0] scan_code;
    // 1. kr[3:0]為keyboard的row掃描輸入
    // 2. kc[3:0]為keyboard的column偵測輸出
    // 3. 若keyboard偵測到有任何鍵按下去,press之值為1
    // 4. scan_code[3:0]為所按之鍵的二進位編碼
    always@(kr or kc) begin
        case (kr)
            4'b1110: // 1st row
                case (kc)
                    4'b1110: begin press =1'b1; scan_code = 4'h0; end // 0
                    4'b1101: begin press =1'b1; scan_code = 4'h1; end // 1
                    4'b1011: begin press =1'b1; scan_code = 4'h2; end // 2
                    4'b0111: begin press =1'b1; scan_code = 4'h3; end // 3
                    default: begin press =1'b0; scan_code = 4'h0; end // default
                endcase
            4'b1101: // 2nd row
                case (kc)
                    4'b1110: begin press =1'b1; scan_code = 4'h4; end // 4
                    4'b1101: begin press =1'b1; scan_code = 4'h5; end // 5
                    4'b1011: begin press =1'b1; scan_code = 4'h6; end // 6
                    4'b0111: begin press =1'b1; scan_code = 4'h7; end // 7
                    default: begin press =1'b0; scan_code = 4'h0; end // default
                endcase
            4'b1011: // 3rd row
                case (kc)
                    4'b1110: begin press =1'b1; scan_code = 4'h8; end // 8
                    4'b1101: begin press =1'b1; scan_code = 4'h9; end // 9
                    4'b1011: begin press =1'b1; scan_code = 4'hA; end // A
                    4'b0111: begin press =1'b1; scan_code = 4'hB; end // B
                    default: begin press =1'b0; scan_code = 4'h0; end // default
                endcase
            4'b0111: // 4th row
                case (kc)
                    4'b1110: begin press =1'b1; scan_code = 4'hC; end // C
                    4'b1101: begin press =1'b1; scan_code = 4'hD; end // D
                    4'b1011: begin press =1'b1; scan_code = 4'hE; end // E
                    4'b0111: begin press =1'b1; scan_code = 4'hF; end // F
                    default: begin press =1'b0; scan_code = 4'h0; end // default
                endcase
            default: begin press = 1'b0; scan_code = 4'h0; end
        endcase // case (kr)
    end // always
endmodule