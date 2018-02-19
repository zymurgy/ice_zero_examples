PROJ = uart_tx_char
PART = hx
DEV  = 8k
PKG  = tq144:4k
PCF  = pins.pcf

FILES = $(PROJ).v uart_tx_8n1.v

all:
	yosys -p "synth_ice40 -top $(PROJ) -blif $(PROJ).blif" $(FILES)
	arachne-pnr -d $(DEV) -P $(PKG) -o $(PROJ).asc -p $(PCF) $(PROJ).blif
	icepack $(PROJ).asc $(PROJ).bin
	icetime -d $(PART)$(DEV) -P $(PKG) -r $(PROJ).rpt -mt $(PROJ).asc

prog: $(PROJ).bin
	icezprog $<

clean:
	rm -f $(PROJ).asc $(PROJ).bin $(PROJ).blif $(PROJ).rpt

.PHONY: all clean prog
