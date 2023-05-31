rm -rf wave_st wave_st.vcd
iverilog -o wave_st self_test_tb.v ../self_test/self_test.v
vvp wave_st -lxt2
gtkwave wave_st.vcd
