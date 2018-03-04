// Top module

module spi_slave_tb (
);

  reg  clk;
  reg  sclk;
  reg  mosi;
  wire miso;
  reg  ssel;
  wire [7:0] dout;
  reg  [7:0] din;
  wire done;

  spi_slave spi_slave0 (
    .clk  ( clk ),
    .sclk ( sclk ),
    .mosi ( mosi ),
    .miso ( miso ),
    .ssel ( ssel ),
    .dout ( dout ),
    .din  ( din ),
    .done ( done)
  )

endmodule
