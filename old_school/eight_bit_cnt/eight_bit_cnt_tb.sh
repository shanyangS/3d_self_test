rm -rf wave_eight_bit_cnt wave_eight_bit_cnt.vcd
iverilog -o wave_eight_bit_cnt eight_bit_cnt_tb.v eight_bit_cnt.v
vvp wave_eight_bit_cnt -lxt2
gtkwave wave_eight_bit_cnt.vcd

