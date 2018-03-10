all:	build comp run

build:
	verilator -Wall --trace --cc counter.v --exe tb_counter.cpp

comp:
	make -C obj_dir -j -f Vcounter.mk Vcounter

run:
	obj_dir/Vcounter

clean:
	rm -rf obj_dir *.vcd

.PHONY: all build clean comp run
