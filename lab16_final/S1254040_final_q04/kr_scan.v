module kr_scan (clk, rst, kr_out);
    input clk, rst;
    output reg [3:0] kr_out;
    
    always@ (posedge clk or posedge rst) begin
        if (rst)
            kr_out = 4'b1110; // top row
        else // left circular shift
            kr_out={kr_out[2:0],kr_out[3]};
            // 1110 -> 1101 -> 1011 -> 0111
            // select row from up to down
    end
endmodule