rm -rf wave_twst wave_twst.vcd
iverilog -y ../../self_test -o wave_twst ttte_with_ser_tb.v ttte_with_ser.v
vvp wave_twst -lxt2
gtkwave wave_twst.vcd
