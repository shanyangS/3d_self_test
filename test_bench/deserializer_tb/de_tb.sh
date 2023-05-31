rm -rf wave_de wave_de.vcd
iverilog -o wave_de deserializer_tb.v ../self_test/deserializer.v
vvp wave_de -lxt2
gtkwave wave_de.vcd
