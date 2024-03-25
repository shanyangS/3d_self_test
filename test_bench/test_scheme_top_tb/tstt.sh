rm -rf test_scheme_top_tb test_scheme_top_tb.vcd
iverilog -y ../top -o test_scheme_top_tb test_scheme_top_tb.v ../../top/test_scheme_top.v
vvp test_scheme_top_tb -lxt2
gtkwave test_scheme_top_tb.vcd
