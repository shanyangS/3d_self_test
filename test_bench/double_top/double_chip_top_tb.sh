rm -rf wave_double_top wave_double_top.vcd
iverilog -y ../../self_test -y ../../ -o wave_double_top double_top_tb.v double_top.v
vvp wave_double_top -lxt2
gtkwave wave_double_top.vcd
