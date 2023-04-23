`timescale 1ns / 1ns

module deserializer_tb;

reg clk, rst_n, data_in;
wire [31:0] data_out;

initial
begin            
    $dumpfile("wave_d.vcd");        //生成的vcd文件名称
    $dumpvars(0, deserializer_tb);    //tb模块名称
end

deserializer dut (
.clk(clk),
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
#10 rst_n = 1;
end

initial begin
data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //1
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //2
#10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //3
#10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //4
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 0; //5
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; //6
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; //7
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; //8

///////////////////////////////////////////

#10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 0;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 0;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;

///////////////////////////////////////////

#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1;
#10 data_in = 1; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
#10 data_in = 0; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;
#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;
$finish;

end

endmodule
