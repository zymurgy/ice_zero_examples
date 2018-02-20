// Top module

module spi_slave_top (
  input clk_100mhz,
  input pi_spi_sck,
  input pi_spi_mosi,
  output pi_spi_miso,
  input pi_spi_ce0,
  output ok_led
);

  spi_slave slave (
    .clk (clk_100mhz),
    .sclk (pi_spi_sck),
    .mosi (pi_spi_mosi),
    .miso (pi_spi_miso),
    .ssel (pi_spi_ce0),
    .led (ok_led)
  );

endmodule
