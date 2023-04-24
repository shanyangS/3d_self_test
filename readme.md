# 3D_IC_SELF_SORTED
This is a project about 3D chip self-testing. 
The main modules include the .v files written in Verilog HDL for the circuit, the testbench, and the generated waveforms
* self_test
  * eight_div.v
  * deserializer.v
  * self_test.v
  * serializer.v
* test_bench
  * deserializer_tb.v
  * self_test_tb.v
  * serializer_tb.v
* vcd
  * wave_d.vcd //deserializer_vcd
  * wave_s.vcd //serializer_vcd
  * wave_st.vcd //self_test_vcd

To conclusion, this circuit use fsm to achieve the function that circuit self-ordering based on inductive coupling.
</br></br>

# 3D芯片自测试
这是一个关于3D芯片自测试的项目
主要的模块包括：电路通过verilog HDL编写的.v文件，testbench，及其生成的波形。
* self_test
  * eight_div.v
  * deserializer.v
  * self_test.v
  * serializer.v
* test_bench
  * deserializer_tb.v
  * self_test_tb.v
  * serializer_tb.v
* vcd
  * wave_d.vcd //deserializer_vcd
  * wave_s.vcd //serializer_vcd
  * wave_st.vcd //self_test_vcd

该电路使用有限状态机来实现基于电感耦合的电路自排序功能。