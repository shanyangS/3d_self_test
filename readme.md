# 3D_IC_SELF_SORTED
This is a project about 3D chip self-testing.  
The main modules include the .v files written in Verilog HDL for the circuit,  
the testbench, and the generated waveforms
* self_test
  * clk_eight_div.v
  * sync_async_reset.v
  * deserializer.v
  * eight_to_thirty_two.v
  * self_test.v
  * thirty_two_to_eight.v
  * serializer.v
* test_bench
  * des_with_ettt_tb
  * deserializer_tb
  * double_top
  * self_test_tb
  * serializer_tb
  * sync_async_reset_tb
  * ttte_with_ser_tb
  * top_tb.v
* vcd
* top.v
* design_demonstrate

To conclusion, this circuit use fsm to achieve the function  
that circuit self-ordering based on inductive coupling.
This project is suitable for wireless interconnection between multiple chips
</br></br>

# 3D芯片自测试
这是一个关于3D芯片自测试的项目
主要的模块包括：  
电路通过verilog HDL编写的.v文件，testbench，及其生成的波形。
* self_test
  * clk_eight_div.v
  * sync_async_reset.v
  * deserializer.v
  * eight_to_thirty_two.v
  * self_test.v
  * thirty_two_to_eight.v
  * serializer.v
* test_bench
  * des_with_ettt_tb
  * deserializer_tb
  * double_top
  * self_test_tb
  * serializer_tb
  * sync_async_reset_tb
  * ttte_with_ser_tb
  * top_tb.v
* vcd
* top.v
* design_demonstrate

该电路使用有限状态机来实现基于电感耦合的电路自排序功能。适用于多个芯片间无线互联
