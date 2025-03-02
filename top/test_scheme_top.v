module test_scheme_top (
    /* clk */
    input wire t_clk,
    input wire div_8_clk,
    /* rst_n */
    input wire rst_n,

    input wire direct_data_signal,
    input wire direct_power_signal,
    input wire random_manual_signal,
    input wire data_reverse_signal,

    input wire prsg_data,
    input wire manual_data,

    input wire[4:0] direct_power_value,

    input wire[4:0] self_test_power_value,
    input wire self_test_data,

    output reg[4:0] test_scheme_power_value,
    output reg test_scheme_data
);
    wire external_data;

    wire temp_data;

    assign external_data = random_manual_signal ? prsg_data : manual_data;

    assign temp_data = direct_data_signal ? external_data : self_test_data;

    // assign test_scheme_power_value = direct_power_signal ? direct_power_value : self_test_power_value;
    
    // assign test_scheme_data = data_reverse_signal ? (~temp_data) : temp_data;

    // always@(posedge t_clk or negedge rst_n) begin
    //     if(!rst_n)
    //         external_data <= 'b0;
    //     else if(random_manual_signal)
    //         external_data <= prsg_data;
    //     else
    //         external_data <= manual_data;
    // end

    // always@(posedge t_clk or negedge rst_n) begin
    //     if(!rst_n)
    //         temp_data <= 'b0;
    //     else if(direct_data_signal)
    //         temp_data <= external_data;
    //     else
    //         temp_data <= self_test_data;
    // end

    always@(posedge div_8_clk or negedge rst_n) begin
        if(!rst_n)
            test_scheme_power_value <= 'b0;
        else if(direct_power_signal)
            test_scheme_power_value <= direct_power_value;
        else
            test_scheme_power_value <= self_test_power_value;
    end

    always@(posedge t_clk or negedge rst_n) begin
        if(!rst_n)
            test_scheme_data <= 'b0;
        else if(data_reverse_signal)
            test_scheme_data <= (~temp_data);
        else
            test_scheme_data <= temp_data;
    end



endmodule
