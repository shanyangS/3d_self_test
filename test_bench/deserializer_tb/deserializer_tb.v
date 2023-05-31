`timescale 1ns / 1ns

module deserializer_tb;

reg t_clk, rst_n, data_in;
wire [7:0] data_out;

initial
begin            
    $dumpfile("wave_de.vcd");        
    $dumpvars(0, deserializer_tb);   
end

deserializer dut (
.t_clk(t_clk),
.rst_n(rst_n),
.data_in(data_in),
.data_out(data_out)
);

initial begin
t_clk = 0;
forever #5 t_clk = ~t_clk;
end

initial begin
rst_n = 0;
#10 rst_n = 1;
end

initial begin
data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1;
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1;
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; 

////////////////////////////////////////////////////////////////////

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
#10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //B
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //E

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //A
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //F

////////////////////////////////////////////////////////////////////

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
#10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //B
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //E

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //A
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //F

////////////////////////////////////////////////////////////////////

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 0; //power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //B
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //E
#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //A
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //F

////////////////////////////////////////////////////////////////////

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; //power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //B
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //E
#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //A
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //F

#200 $finish;
end

endmodule
