module serializer_tb;

reg t_clk, rst_n;
reg [7:0] data_in;
wire data_out;

initial
begin            
    $dumpfile("wave_s.vcd");
    $dumpvars(0, serializer_tb); 
end

serializer dut(
    .t_clk(t_clk),
    .rst_n(rst_n),
    .data_in(data_in),

    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 0;
    data_in = 'b0;

    #10 rst_n = 1;
    #10 data_in = 8'b1111_1110_0001_0010_0110_1001_1111_1111;

    #600 $finish;
end

endmodule
