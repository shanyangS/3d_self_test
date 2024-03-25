module top (
    /* self_test_top */
    input wire t_clk,
    input wire rst_n,

    input wire f_layer,

    input wire data_in,

    output wire sort_finish,
    output wire[3:0] chip_id,
    output wire[4:0] power_value_upper,
    output wire[4:0] power_value_lower,
    output wire[4:0] power_value,
    output wire data_out,
    output wire data_i_o,

    /* test_scheme_top */
    input wire direct_data_signal,
    input wire direct_power_signal,
    input wire random_manual_signal,

    input wire prsg_data,
    input wire manual_data,

    input wire[4:0] direct_power_value,

    input wire[4:0] self_test_power_value,
    input wire self_test_data,

    output wire[4:0] test_scheme_power_value,
    output wire test_scheme_data
);

    self_test_top self_test_top(
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
        .data_i_o(data_i_o)   
    );

    test_scheme_top test_scheme_top(
        .direct_data_signal(direct_data_signal),
        .direct_power_signal(direct_power_signal),
        .random_manual_signal(random_manual_signal),

        .prsg_data(prsg_data),
        .manual_data(manual_data),

        .direct_power_value(direct_power_value),

        .self_test_power_value(power_value),
        .self_test_data(data_out),

        .test_scheme_power_value(test_scheme_power_value),
        .test_scheme_data(test_scheme_data)
    );

endmodule
