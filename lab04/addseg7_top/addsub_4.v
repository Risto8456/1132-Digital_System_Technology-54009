module addsub_4(a, b, sel, cout, sum);
    input [3:0] a, b;
    input sel;
    output cout;
    output [3:0] sum;

    wire [3:0] w0;

    assign w0 = (sel == 1) ? ~b : b;

    add_4 m0(a, w0, sel, sum);

    assign cout = (~sel & ~a[3] & ~b[3] &  sum[3]) | 
                  ( sel & ~a[3] &  b[3] &  sum[3]) | 
                  (~sel &  a[3] &  b[3] & ~sum[3]) | 
                  ( sel &  a[3] & ~b[3] & ~sum[3]);
endmodule