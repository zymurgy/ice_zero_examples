PROJ = uart_tx_char
DEVICE = hx8k

FILES = $(PROJ).v baudgen_tx.v uart_tx.v

all:
	yosys -p "synth_ice40 -top $(PROJ) -blif $(PROJ).blif" $(FILES)
	arachne-pnr -d 8k -P tq144:4k -o $(PROJ).asc -p pins.pcf $(PROJ).blif
	icepack $(PROJ).asc $(PROJ).bin

icezprog: icezprog.c
	gcc -o icezprog -Wall -Os icezprog.c -lwiringPi -lrt -lstdc++

prog: $(PROJ).bin icezprog
	./icezprog $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin
	rm -f icezprog

.SECONDARY:
.PHONY: all prog clean
