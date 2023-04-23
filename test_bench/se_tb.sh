rm -rf wave_s wave_s.vcd
iverilog -o wave_s serializer_tb.v ../self_test/serializer.v
vvp wave_s -lxt2
gtkwave wave_s.vcd
