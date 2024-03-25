`timescale 1ns/1ns

module des_with_ettt_tb;

reg t_clk;
reg rst_n;
reg data_in;
wire[31:0] data_out;

initial begin            
    $dumpfile("wave_dwet.vcd");        
    $dumpvars(0, des_with_ettt_tb);   
end

des_with_ettt dut(
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
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1;//power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //1011
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110

#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1;  //111

////////////////////////////////////////////////////////////////////

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
#10 data_in = 0; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; #10 data_in = 1; //power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //1011
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110

#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1;  //111

////////////////////////////////////////////////////////////////////

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //1011
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110

#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1;  //111

////////////////////////////////////////////////////////////////////

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //1011
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110

#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1;  //111

////////////////////////////////////////////////////////////////////

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 0; //test_pass
#10 data_in = 0; #10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //power_set

#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 0; //ID_above
#10 data_in = 0; #10 data_in = 0; #10 data_in = 0; #10 data_in = 1; //ID_layer

#10 data_in = 1; #10 data_in = 0; #10 data_in = 1; #10 data_in = 1; //1011
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110

#10 data_in = 1; #10 data_in = 1; #10 data_in = 1; #10 data_in = 0; //1110
#10 data_in = 1; #10 data_in = 1; #10 data_in = 1;  //111

#1000 $finish;
end

endmodule
