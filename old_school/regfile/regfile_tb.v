`timescale 1ns / 1ns

module regfile_tb;

    // Parameters
    parameter DATA_WIDTH = 192;

    // Inputs
    reg clk;
    reg en;
    reg [DATA_WIDTH-1:0] data_in;

    // Outputs
    wire shift_out;

    initial begin            
        $dumpfile("wave_regfile.vcd");
        $dumpvars(0, regfile_tb);
    end

    // Instantiate the Unit Under Test (UUT)
    regfile uut (
        .clk(clk), 
        .en(en), 
        .data_in(data_in),
        .shift_out(shift_out)
    );

    initial begin
        // Initialize Inputs
        clk = 'b0;
        en = 'b0;
        data_in = 'b0;

        // Wait for 100 ns
        #50;

        // Test case 1: Load data into the register file
        en = 0;
        data_in = 192'h123456789123456789ABCDEF123456789123456789ABCDEF; // Any 192-bit data
        #10; // Wait for a clock cycle

        // Test case 2: Shift out data from the register file
        en = 1;
        #10000; // Wait for a clock cycle

        // Add more test cases as needed...
	
        // Finish simulation
        $finish;
    end

    // Clock generation
    always #5 clk = ~clk;

    // Monitor signals
    initial begin
        $monitor("At time %t, data_in = %h, shift_out = %b, en = %b",
                 $time, data_in, shift_out, en);
    end

endmodule

