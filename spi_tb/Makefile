all:	build comp run

build:
	verilator -Wall --trace --cc spi_slave.v --exe spi_slave_tb.cpp

comp:
	make -C obj_dir -j -f Vspi_slave.mk Vspi_slave

run:
	obj_dir/Vspi_slave

clean:
	rm -rf obj_dir *.vcd

.PHONY: all build comp run clean
