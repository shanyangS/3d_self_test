`timescale 1ns/1ns

module top_tb;
    reg t_clk, rst_n, f_layer, data_in;
    wire sort_finish, data_out;

initial
begin            
    $dumpfile("wave_top.vcd");        //生成的vcd文件名称
    $dumpvars(0, top_tb);    //tb模块名称
end

top dut
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

    rst_n = 0;
    #10 rst_n = 1;

    f_layer = 1;

    #8000;
    rst_n = 0;
    #10 rst_n = 1; f_layer = 0;
    #10 rst_n = 0;
    #10 rst_n = 1;

    data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; 

    ////////////////////////////////////////////////////////////////////

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //power_set

    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //B
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //E

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //A
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //F

    ////////////////////////////////////////////////////////////////////

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //power_set

    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //B
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //E

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //A
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //F

    ////////////////////////////////////////////////////////////////////

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
    #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 0; //power_set

    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //B
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //E
    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //A
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //F

    ////////////////////////////////////////////////////////////////////

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
    #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; //power_set

    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //B
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //E
    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //A
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //F

    #4000 $finish;
    
end

endmodule