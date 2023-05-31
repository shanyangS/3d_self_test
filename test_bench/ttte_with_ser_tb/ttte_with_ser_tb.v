`timescale 1ns/1ns
module ttte_with_ser_tb;

reg t_clk;
reg rst_n;
reg tx_out;
reg[31:0] data_in;

wire data_out;

initial begin            
	$dumpfile("wave_twst.vcd");   //生成的vcd文件名称
	$dumpvars(0, ttte_with_ser_tb); //tb模块名称
end

ttte_with_ser dut (
.t_clk(t_clk),
.rst_n(rst_n),
.tx_out(tx_out),
.data_in(data_in),

.data_out(data_out)
);

initial begin
    t_clk = 0;
    forever #5 t_clk = ~t_clk;
end

initial begin
    t_clk = 0; rst_n = 0; tx_out = 0; data_in = 'd0;

    #10 rst_n = 1;

    #400
    data_in = 32'b1010_0010_0000_0001_1011_1110_1010_1111;
    tx_out = 1'b1;

    #80 tx_out = 1'b0;

    #1600 rst_n = 0; #1600 rst_n = 1;

    #800 
    data_in = 32'b1010_0110_0001_0010_1011_1110_1010_1111;
    tx_out = 1'b1;

    #80 tx_out = 1'b0;

    #1600 rst_n = 0; #1600 rst_n = 1;

    #800 
    data_in = 32'b1010_0110_0010_0011_1011_1110_1010_1111;
    tx_out = 1'b1;

    #80 tx_out = 1'b0;

    #1600 rst_n = 0; #1600 rst_n = 1;

    #1600 $finish;
end

endmodule
