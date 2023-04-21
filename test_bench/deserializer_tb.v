`timescale 1ns/1ns

module deserializer_tb;

    reg clk;
    reg rst_n;
    reg data_in;
    wire [31:0] data_out;
    
    deserializer dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    initial begin
        clk = 0;
        rst_n = 0;
        data_in = 0;
        #100;
        rst_n = 1;
        #100;
        
        // Test with data starting with "11"
        $display("=== Testing data starting with '11' ===");
        data_in = 1;
        #10;
        data_in = 1;
        #10;
        data_in = 0;
        #10;
        data_in = 1;
        #10;
        data_in = 1;
        #10;
        data_in = 0;
        #10;
        data_in = 1;
        #10;
        data_in = 1;
        #10;
        #500;
        $display("Data out: %h", data_out);
        #100;
        
        // Test with data not starting with "11"
        $display("=== Testing data not starting with '11' ===");
        data_in = 0;
        #10;
        data_in = 1;
        #10;
        data_in = 0;
        #10;
        data_in = 1;
        #10;
        data_in = 1;
        #10;
        data_in = 0;
        #10;
        data_in = 1;
        #10;
        data_in = 0;
        #10;
        #500;
        $display("Data out: %h", data_out);
        #100;
        
        $finish;
    end
    
    always #5 clk = ~clk;
    
endmodule