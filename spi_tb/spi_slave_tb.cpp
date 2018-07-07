#include "Vspi_slave.h"
#include "verilated.h"
#include "verilated_vcd_c.h"


int main(int argc, char **argv, char **env) {
  int i;
  int clk;
  int sclk = 0;
  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  Vspi_slave* top = new Vspi_slave;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("spi_slave.vcd");
  // initialize simulation inputs
  top->clk = 0;
  top->sclk = 1;
  top->mosi = 0;
  top->ssel = 0;
  top->din = 0x55;
  // run simulation for 100 clock periods
  for (i=0; i<20; i++) {
    top->ssel = (i < 2);
    // dump variables into VCD file and toggle clock
    for (clk=0; clk<2; clk++) {
      if (sclk<4) {
         sclk=sclk+clk;
      } else {
         top->sclk = ~top->sclk;
         sclk = 0;
      }
      tfp->dump (2*i+clk);
      top->clk = !top->clk;
      top->eval ();
    }
    top->ssel = ~(i == 10);
    if (Verilated::gotFinish())  exit(0);
  }
  tfp->close();
  exit(0);
}
