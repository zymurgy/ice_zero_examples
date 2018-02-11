// Top module

module blink (
  input clk_100mhz,
  output ok_led
);

  reg [25:0] counter;
  always @(posedge clk_100mhz) counter <= counter + 1;

  assign ok_led = counter[25];

endmodule
