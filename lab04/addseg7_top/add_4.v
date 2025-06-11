module add_4(a, b, cin, sum);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;

    wire w0, w1, w2;

    add_full m0(a[0], b[0], cin, w0, sum[0]);
    add_full m1(a[1], b[1], w0, w1, sum[1]);
    add_full m2(a[2], b[2], w1, w2, sum[2]);

    assign sum[3] = (a[3] ^ b[3]) ^ w2;
endmodule