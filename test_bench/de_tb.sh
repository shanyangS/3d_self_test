rm -rf wave_d wave_d.vcd
iverilog -o wave_d deserializer_tb.v ../self_test/deserializer.v
vvp wave_d -lxt2
gtkwave wave_d.vcd