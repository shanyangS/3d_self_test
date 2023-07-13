`timescale 1ns/1ps

module eight_bit_cnt_tb;

    reg clk;
    reg trig;
    wire [8:0] count;
    wire en;

    initial begin            
        $dumpfile("wave_eight_bit_cnt.vcd");
        $dumpvars(0, eight_bit_cnt_tb);
    end

    eight_bit_cnt dut (
        .clk(clk), 
        .trig(trig), 
        .count(count), 
        .en(en)
    );

    initial begin
        // Initialize the inputs
        clk = 0;
        trig = 0;

        #2000;
        trig = 1;

        #1000 trig = 0;

        #4000;
        trig = 1;

        #1000 trig = 0;

        #6000 $finish;
    end

    always #5 clk = ~clk;

endmodule
