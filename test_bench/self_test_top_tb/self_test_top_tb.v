`timescale 1ns/1ns

module self_test_top_tb;
    reg t_clk, rst_n, f_layer, data_in;
    wire sort_finish, data_out;

initial begin            
    $dumpfile("self_test_top_tb.vcd");
    $dumpvars(0, self_test_top_tb);
end

self_test_top dut
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

    rst_n = 0; f_layer = 0;
    #10 rst_n = 1;

    ////////////////  MESSY CODE TEST  ////////////////
    data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; 

    ////////////////  FIRST TIME TEST NO F_LAYER  ////////////////
    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;  #10 data_in = 0;//power_set

    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; // chip_ID
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; // NEXT_CHIP_ID

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; // 1011
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; // 111

    #480000 rst_n = 0; f_layer = 1;
    #60 rst_n = 1;

    #500;
    ////////////////  SECOND TIME TEST F_LAYER  ////////////////
    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;  #10 data_in = 0;//power_set

    #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; // chip_ID
    #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; // NEXT_CHIP_ID

    #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; // 1011
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
    #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; // 111

    #480000 $finish;
    
end

endmodule