// Top module

module spi_slave_tb (
);

  reg        clk;
  reg        sclk;
  reg        mosi;
  wire       miso;
  reg        ssel;
  wire [7:0] dout;
  reg  [7:0] din;
  wire       done;

  integer i;
  integer j;

  parameter CLK_PERIOD = 10;  // 10ns = 100Mhz
  parameter SCLK_PERIOD = 2000; // 2000ns = 500khz

  spi_slave spi_slave0 (
    .clk  ( clk ),
    .sclk ( sclk ),
    .mosi ( mosi ),
    .miso ( miso ),
    .ssel ( ssel ),
    .dout ( dout ),
    .din  ( din ),
    .done ( done )
  );

  initial clk  = 1'b0;
  initial sclk = 1'b0;

  always #( CLK_PERIOD / 2.0 )
    clk = ~clk;

endmodule
