rm -rf wave_dwet wave_dwet.vcd
iverilog -o wave_dwet des_with_ettt.v ../self_test/deserializer.v ../self_test/eight_to_thirty_two.v ../self_test/clk_eight_div.v ../self_test/sync_async_reset.v des_with_ettt_tb.v
vvp wave_dwet -lxt2
gtkwave wave_dwet.vcd
