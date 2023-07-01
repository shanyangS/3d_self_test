rm -rf wave_eight_chip_top wave_eight_chip_top.vcd
iverilog -y ../../self_test -y ../../ -o wave_eight_chip_top eight_chip_top_tb.v eight_chip_top.v
vvp wave_eight_chip_top -lxt2
gtkwave wave_eight_chip_top.vcd
