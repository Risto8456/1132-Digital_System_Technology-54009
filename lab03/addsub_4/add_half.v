module add_half(a, b, cout, sum);
    input a, b;
    output cout, sum;

    assign cout = a&b;
    assign sum  = a^b;
endmodule