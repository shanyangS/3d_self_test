rm -rf wave_top wave_top.vcd
iverilog -y ../self_test -o wave_top top_tb.v ../top.v
vvp wave_top -lxt2
gtkwave wave_top.vcd
