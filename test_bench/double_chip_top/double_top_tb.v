`timescale 1ns/1ns

module double_top_tb;

    reg t_clk, rst_n, f_layer_0, f_layer_1;
    wire sort_finish_0, sort_finish_1;
    
    wire[3:0] chip_id_0, chip_id_1;
    wire[4:0] power_value_upper_0, power_value_upper_1;
    wire[4:0] power_value_lower_0, power_value_lower_1;
    wire[4:0] power_value_0, power_value_1;

    wire data_i_o_0, data_i_o_1;
    wire data_out_dut0, data_out_dut1;
    wire t_clk_out_0, t_clk_out_1;

    reg direct_data_signal_0, direct_data_signal_1;
    reg direct_power_signal_0, direct_power_signal_1;
    reg random_manual_signal_0, random_manual_signal_1;
    reg data_reverse_signal_0, data_reverse_signal_1;

    reg prsg_data_0, prsg_data_1;
    reg manual_data_0, manual_data_1;

    reg[4:0] direct_power_value_0, direct_power_value_1;

    wire[4:0] self_test_power_value_0, self_test_power_value_1;
    wire self_test_data_0, self_test_data_1;

    wire[4:0] test_scheme_power_value_0, test_scheme_power_value_1;
    wire test_scheme_data_0, test_scheme_data_1;

    initial begin            
        $dumpfile("wave_double_top.vcd");
        $dumpvars(0, double_top_tb);
    end

    double_top dut (
    .t_clk(t_clk),
    .rst_n(rst_n),

    .f_layer_0(f_layer_0), 
    .f_layer_1(f_layer_1),

    .sort_finish_0(sort_finish_0), 
    .sort_finish_1(sort_finish_1),
    
    .chip_id_0(chip_id_0),
    .chip_id_1(chip_id_1),

    .power_value_upper_0(power_value_upper_0), 
    .power_value_upper_1(power_value_upper_1),
    .power_value_lower_0(power_value_lower_0),
    .power_value_lower_1(power_value_lower_1),
    .power_value_0(power_value_0),
    .power_value_1(power_value_1),

    .data_i_o_0(data_i_o_0),
    .data_i_o_1(data_i_o_1),
    .data_out_dut0(data_out_dut0),
    .data_out_dut1(data_out_dut1),

    /* test_scheme_top */
    .direct_data_signal_0(direct_data_signal_0),
    .direct_data_signal_1(direct_data_signal_1),
    .direct_power_signal_0(direct_power_signal_0),
    .direct_power_signal_1(direct_power_signal_1),
    .random_manual_signal_0(random_manual_signal_0),
    .random_manual_signal_1(random_manual_signal_1),
    .data_reverse_signal_0(data_reverse_signal_0),
    .data_reverse_signal_1(data_reverse_signal_1),

    .prsg_data_0(prsg_data_0),
    .prsg_data_1(prsg_data_1),
    .manual_data_0(manual_data_0),
    .manual_data_1(manual_data_1),

    .direct_power_value_0(direct_power_value_0),
    .direct_power_value_1(direct_power_value_1),

    .self_test_power_value_0(self_test_power_value_0),
    .self_test_power_value_1(self_test_power_value_1),
    .self_test_data_0(self_test_data_0),
    .self_test_data_1(self_test_data_1),

    .test_scheme_power_value_0(test_scheme_power_value_0),
    .test_scheme_power_value_1(test_scheme_power_value_1),
    .test_scheme_data_0(test_scheme_data_0),
    .test_scheme_data_1(test_scheme_data_1)
    );

    initial begin
        t_clk = 0;
        forever #5 t_clk = ~t_clk;
    end

    ///////////////// STANDARD /////////////////
    initial begin
        rst_n = 0; direct_data_signal_0 = 0; direct_data_signal_1 = 0; 
        direct_power_signal_0 = 0; direct_power_signal_1 = 0;
        random_manual_signal_0 = 1; random_manual_signal_1 = 0;
        direct_power_value_0 = 5'b11111; direct_power_value_1 = 5'b11111;
        data_reverse_signal_0 = 0; data_reverse_signal_1 = 0;
        prsg_data_0 = 0; prsg_data_1 = 0; manual_data_0 = 0; manual_data_1 = 0;

        #10 rst_n = 1; 
        f_layer_0 = 1;
        f_layer_1 = 0;

        #350000;
    ///////////////// POWER AUTO DATA MANUAL TEST MODE /////////////////
        direct_data_signal_0 = 1; direct_data_signal_1 = 1;
        direct_power_signal_0 = 0; direct_power_signal_1 = 0;
        random_manual_signal_0 = 0; random_manual_signal_1 = 1;

        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 1; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 0; prsg_data_1 = 1; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 0;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 1; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 0; prsg_data_1 = 1; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 0;

        #3500;
    ///////////////// FULL MANUAL TEST MODE /////////////////
        direct_data_signal_0 = 1; direct_data_signal_1 = 1;
        direct_power_signal_0 = 1; direct_power_signal_1 = 1;
        random_manual_signal_0 = 0; random_manual_signal_1 = 1;
        data_reverse_signal_0 = 1; data_reverse_signal_1 = 1;
        
        direct_power_value_0 = 5'b11111;
        direct_power_value_1 = 5'b11111;

        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 1; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 0; prsg_data_1 = 1; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 0;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 1; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 0; prsg_data_1 = 1; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 0;
        
        #3500 $finish;

    ///////////////// DATA_REVERSE_SIGNAL TEST /////////////////
        direct_data_signal_0 = 1; direct_data_signal_1 = 1;
        direct_power_signal_0 = 1; direct_power_signal_1 = 1;
        random_manual_signal_0 = 0; random_manual_signal_1 = 1;
        data_reverse_signal_0 = 1; data_reverse_signal_1 = 1;

        direct_power_value_0 = 5'b11111;
        direct_power_value_1 = 5'b11111;

        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 1; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 0; prsg_data_1 = 1; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 0;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 1; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 1; manual_data_1 = 0; prsg_data_0 = 1; prsg_data_1 = 0; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 1;
        #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 0; prsg_data_1 = 1; #10 manual_data_0 = 0; manual_data_1 = 1; prsg_data_0 = 1; prsg_data_1 = 0;
        
        #3500 $finish;
    end

endmodule
