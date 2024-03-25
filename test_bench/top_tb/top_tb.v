`timescale 1ns/1ns

module top_tb;
    reg t_clk;
    reg rst_n;

    reg f_layer;

    reg data_in;

    wire sort_finish;
    wire[3:0] chip_id;
    wire[4:0] power_value_upper;
    wire[4:0] power_value_lower;
    wire[4:0] power_value;
    wire data_out;
    wire data_i_o;

    /* test_scheme_top */
    reg direct_data_signal;
    reg direct_power_signal;
    reg random_manual_signal;

    reg prsg_data;
    reg manual_data;

    reg[4:0] direct_power_value;

    reg[4:0] self_test_power_value;
    reg self_test_data;

    wire[4:0] test_scheme_power_value;
    wire test_scheme_data;


    initial begin            
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
    end

    top dut
    (
        .t_clk(t_clk),
        .rst_n(rst_n),

        .f_layer(f_layer),

        .data_in(data_in),

        .sort_finish(sort_finish),
        .chip_id(chip_id),
        .power_value_upper(power_value_upper),
        .power_value_lower(power_value_lower),
        .power_value(power_value),
        .data_out(data_out),
        .data_i_o(data_i_o),

        /* test_scheme_top */
        .direct_data_signal(direct_data_signal),
        .direct_power_signal(direct_power_signal),
        .random_manual_signal(random_manual_signal),

        .prsg_data(prsg_data),
        .manual_data(manual_data),

        .direct_power_value(direct_power_value),

        .self_test_power_value(self_test_power_value),
        .self_test_data(self_test_data),

        .test_scheme_power_value(test_scheme_power_value),
        .test_scheme_data(test_scheme_data)
    );

    initial begin
        t_clk = 0;
        forever #5 t_clk = ~t_clk;
    end

    initial begin

        ////////////////  I. POWER AUTO   ////////////////
        rst_n = 0; f_layer = 0; direct_data_signal = 1'b0; direct_power_signal = 1'b0; random_manual_signal = 1'b0;
        #10 rst_n = 1;

        ////////////////  1.1 MESSY CODE TEST  ////////////////
        data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;
        #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; 

        ////////////////  1.2 FIRST TIME TEST NO F_LAYER AND MANUAL_DATA  ////////////////
        #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;  #10 data_in = 0;//power_set

        #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; // chip_ID
        #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; // NEXT_CHIP_ID

        #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; // 1011
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; // 111

        #300000 direct_data_signal = 1'b1;
        #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 0; #10 manual_data = 0; prsg_data = 1; #10 manual_data = 1; prsg_data = 0;
        #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 0;
        #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 1; 

        ////////////////  1.3 SECOND TIME TEST F_LAYER AND PRSG_DATA ////////////////
        #500 rst_n = 0; f_layer = 1;
        #60 rst_n = 1;

        #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;  #10 data_in = 0;//power_set

        #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; // chip_ID
        #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; // NEXT_CHIP_ID

        #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; // 1011
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; // 111

        #400000 direct_data_signal = 1'b1; random_manual_signal = 1'b1;
        #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 0; #10 manual_data = 0; prsg_data = 1; #10 manual_data = 1; prsg_data = 0;
        #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 0;
        #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 1;

        ////////////////  II. POWER MANUAL   ////////////////
        rst_n = 0; f_layer = 0; direct_data_signal = 1'b0; direct_power_signal = 1'b1; random_manual_signal = 1'b0; direct_power_value = 5'b11111;
        #10 rst_n = 1;

        ////////////////  2.1 MESSY CODE TEST  ////////////////
        data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;
        #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; 

        ////////////////  2.2 FIRST TIME TEST NO F_LAYER AND MANUAL_DATA  ////////////////
        #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;  #10 data_in = 0;//power_set

        #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; // chip_ID
        #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; // NEXT_CHIP_ID

        #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; // 1011
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; // 111

        #400000 direct_data_signal = 1'b1;
        #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 0; #10 manual_data = 0; prsg_data = 1; #10 manual_data = 1; prsg_data = 0;
        #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 0;
        #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 1; 

        rst_n = 0; f_layer = 1;
        #60 rst_n = 1;

        #500;

        ////////////////  2.3 SECOND TIME TEST F_LAYER AND PRSG_DATA ////////////////
        #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0;  #10 data_in = 0;//power_set

        #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; // chip_ID
        #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; // NEXT_CHIP_ID

        #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; // 1011
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; // 1110
        #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; // 111

        #400000 direct_data_signal = 1'b1; random_manual_signal = 1'b1;
        #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 0; #10 manual_data = 0; prsg_data = 1; #10 manual_data = 1; prsg_data = 0;
        #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 1; #10 manual_data = 1; prsg_data = 0;
        #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 0; #10 manual_data = 0; prsg_data = 1; 

        #800 $finish;
        
    end

endmodule