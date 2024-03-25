rm -rf self_test_top_tb self_test_top_tb.vcd
iverilog -y ../../self_test -o self_test_top_tb self_test_top_tb.v ../../top/self_test_top.v
vvp self_test_top_tb -lxt2
gtkwave self_test_top_tb.vcd
