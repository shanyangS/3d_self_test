module test_scheme_top (
    input wire direct_data_signal,
    input wire direct_power_signal,
    input wire random_manual_signal,
    input wire data_reverse_signal,

    input wire prsg_data,
    input wire manual_data,

    input wire[4:0] direct_power_value,

    input wire[4:0] self_test_power_value,
    input wire self_test_data,

    output wire[4:0] test_scheme_power_value,
    output wire test_scheme_data
);
    wire external_data;

    wire temp_data;

    assign external_data = random_manual_signal ? prsg_data : manual_data;

    assign temp_data = direct_data_signal ? external_data : self_test_data;

    assign test_scheme_power_value = direct_power_signal ? direct_power_value : self_test_power_value;
    
    assign test_scheme_data = data_reverse_signal ? (~temp_data) : temp_data;

endmodule
