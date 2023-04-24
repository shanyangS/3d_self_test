`timescale 1ns/1ns

module top_tb;
    reg t_clk, rst_n, f_layer, data_in;
    wire sort_finish, data_out;

initial
begin            
    $dumpfile("wave_top.vcd");        //生成的vcd文件名称
    $dumpvars(0, top_tb);    //tb模块名称
end

top t0
(
.t_clk(t_clk),
.rst_n(rst_n),
.f_layer(f_layer),
.data_in(data_in),

.sort_finish(sort_finish),
.data_out(data_out)
);



initial begin
t_clk = 0;
forever #5 t_clk = ~t_clk;
end

initial begin

end

initial begin

rst_n = 0;
#10 rst_n = 1;

f_layer = 1;

#3000;
rst_n = 0;
#10 rst_n = 1;

f_layer = 0; //unable to occur, just for test
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

#3000
$finish;

end

endmodule