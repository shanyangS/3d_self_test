module double_top (
    input wire t_clk,
    input wire rst_n,

    input wire f_layer_0, f_layer_1,

    output wire sort_finish_0, sort_finish_1,
    
    output wire[3:0] chip_id_0, chip_id_1,

    output wire[4:0] power_value_upper_0, power_value_upper_1,
    output wire[4:0] power_value_lower_0, power_value_lower_1,
    output wire[4:0] power_value_0, power_value_1,

    output wire data_i_o_0, data_i_o_1,
    output wire data_out_dut0 ,data_out_dut1,

    /* test_scheme_top */
    input wire direct_data_signal_0, direct_data_signal_1,
    input wire direct_power_signal_0, direct_power_signal_1,
    input wire random_manual_signal_0, random_manual_signal_1,

    input wire prsg_data_0, prsg_data_1,
    input wire manual_data_0, manual_data_1,

    input wire[4:0] direct_power_value_0, direct_power_value_1,

    input wire[4:0] self_test_power_value_0, self_test_power_value_1,
    input wire self_test_data_0, self_test_data_1,

    output wire[4:0] test_scheme_power_value_0, test_scheme_power_value_1,
    output wire test_scheme_data_0, test_scheme_data_1
);

    top dut0 (
    .t_clk(t_clk),
    .rst_n(rst_n),

    .f_layer(f_layer_0),

    .data_in(test_scheme_data_1),

    .sort_finish(sort_finish_0),

    .chip_id(chip_id_0),

    .power_value_upper(power_value_upper_0),
    .power_value_lower(power_value_lower_0),
    .power_value(power_value_0),

    .data_out(data_out_dut0),
    .data_i_o(data_i_o_0),

    /* test_scheme_top */
    .direct_data_signal(direct_data_signal_0),
    .direct_power_signal(direct_power_signal_0),
    .random_manual_signal(random_manual_signal_0),

    .prsg_data(prsg_data_0),
    .manual_data(manual_data_0),

    .direct_power_value(direct_power_value_0),

    .self_test_power_value(self_test_power_value_0),
    .self_test_data(self_test_data_0),

    .test_scheme_power_value(test_scheme_power_value_0),
    .test_scheme_data(test_scheme_data_0)
    );

    top dut1 (
    .t_clk(t_clk),
    .rst_n(rst_n),

    .f_layer(f_layer_1),

    .data_in(test_scheme_data_0),

    .sort_finish(sort_finish_1),

    .chip_id(chip_id_1),

    .power_value_upper(power_value_upper_1),
    .power_value_lower(power_value_lower_1),
    .power_value(power_value_1),

    .data_out(data_out_dut1),
    .data_i_o(data_i_o_1),

    /* test_scheme_top */
    .direct_data_signal(direct_data_signal_1),
    .direct_power_signal(direct_power_signal_1),
    .random_manual_signal(random_manual_signal_1),

    .prsg_data(prsg_data_1),
    .manual_data(manual_data_1),

    .direct_power_value(direct_power_value_1),

    .self_test_power_value(self_test_power_value_1),
    .self_test_data(self_test_data_1),

    .test_scheme_power_value(test_scheme_power_value_1),
    .test_scheme_data(test_scheme_data_1)
    );

endmodule
