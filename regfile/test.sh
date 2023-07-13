rm -rf wave_regfile wave_regfile.vcd
iverilog -o wave_regfile regfile_tb.v regfile.v
vvp wave_regfile -lxt2
gtkwave wave_regfile.vcd

