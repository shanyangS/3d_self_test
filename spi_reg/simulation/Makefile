all: compile sim


DEFINE_ARGS := +define+DUMP_VPD

COMPILE_ARGS := -cpp g++ \
				-cc gcc \
				-sverilog\
				+v2k\
				-LDFLAGS -Wl,--no-as-needed\
				-debug_access+r\
				-timescale=1ns/1ps \


compile:
	vcs $(COMPILE_ARGS) $(DEFINE_ARGS) -f rtl.f

sim: compile
	./simv 

verdi: 
	verdi -sv -f rtl.f -ssf spi_sim.fsdb  -nologo 
	
clean:
	rm -rf *csrc ./*.daidir $(simv_name) *simv* DVE* ucli* *.vpd *.vdb *.log *.fsdb *novas* *.dat *Log *rc *conf
