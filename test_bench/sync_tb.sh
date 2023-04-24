rm -rf wave_sync wave_sync.vcd
iverilog -o wave_sync sync_async_reset_tb.v ../self_test/sync_async_reset.v
vvp wave_sync -lxt2
gtkwave wave_sync.vcd
