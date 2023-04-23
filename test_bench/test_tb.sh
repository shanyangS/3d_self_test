rm -rf wave_self_test wave_self_test.vcd
iverilog -o wave_self_test self_test_tb.v ../self_test/self_test.v
vvp wave_self_test -lxt2
gtkwave wave_self_test.vcd