`timescale 1ns / 1ps

module test_scheme_top_tb;

// Inputs
reg direct_data_signal;
reg direct_power_signal;
reg [3:0] direct_power_value;
reg direct_data;
reg [3:0] self_test_power_value;
reg self_test_data;

// Outputs
wire [3:0] test_scheme_power_value;
wire test_scheme_data;

initial begin            
    $dumpfile("test_scheme_top_tb.vcd");
    $dumpvars(0, test_scheme_top_tb); 
end

// Instantiate the Unit Under Test (UUT)
test_scheme_top uut (
    .direct_data_signal(direct_data_signal), 
    .direct_power_signal(direct_power_signal), 
    .direct_power_value(direct_power_value), 
    .direct_data(direct_data), 
    .self_test_power_value(self_test_power_value), 
    .self_test_data(self_test_data), 
    .test_scheme_power_value(test_scheme_power_value), 
    .test_scheme_data(test_scheme_data)
);

initial begin
    // Initialize Inputs
    direct_data_signal = 0;
    direct_power_signal = 0;
    direct_power_value = 0;
    direct_data = 0;
    self_test_power_value = 0;
    self_test_data = 0;

    // Wait 100 ns for global reset to finish
    #100;
    
    // Add stimulus here
    direct_power_signal = 1; direct_power_value = 4'b1010; #10;
    direct_data_signal = 1; direct_data = 1'b1; #10;
    
    direct_power_signal = 0; self_test_power_value = 4'b0101; #10;
    direct_data_signal = 0; self_test_data = 1'b0; #10;
    
    #600;
    $finish;
end
      
endmodule
