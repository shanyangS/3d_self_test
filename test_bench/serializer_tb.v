module serializer_tb;

reg clk, rst_n, en;
reg [31:0] data_in;
wire data_out;

initial
begin            
    $dumpfile("wave_s.vcd");        //生成的vcd文件名称
    $dumpvars(0, serializer_tb);    //tb模块名称
end

serializer dut(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst_n = 0;
    en = 0;
    data_in = 32'h00000000;

    #10 rst_n = 1;
    #10 en = 1; data_in = 32'b1111_1110_0001_0010_0110_1001_1111_1111;
    #10 en = 0;
        
    #600 $finish;
end

endmodule
