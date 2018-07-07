PROJ = spi_slave_top
PART = hx
DEV  = 8k
PKG  = tq144:4k
PCF  = pins.pcf

FILES = $(PROJ).v spi_slave.v

all:
	yosys -p "synth_ice40 -top $(PROJ) -blif $(PROJ).blif" $(FILES)
	arachne-pnr -d $(DEV) -P $(PKG) -o $(PROJ).asc -p $(PCF) $(PROJ).blif
	icepack $(PROJ).asc $(PROJ).bin
	icetime -d $(PART)$(DEV) -P $(PKG) -r $(PROJ).rpt -mt $(PROJ).asc

prog: $(PROJ).bin
	icezprog $<

spi-test: spi-test.c
	gcc -o spi-test spi-test.c

clean:
	rm -f $(PROJ).asc $(PROJ).bin $(PROJ).blif $(PROJ).rpt spi-test

.PHONY: all clean prog
