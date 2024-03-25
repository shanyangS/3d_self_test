rm -rf top_tb top_tb.vcd
iverilog -y ../../top -y ../../self_test -o top_tb top_tb.v ../../top/top.v
vvp top_tb -lxt2
gtkwave top_tb.vcd
