module spi_slave (
  input clk,
  input sclk,
  input mosi,
  output miso,
  input ssel,
  output led
);

  reg [2:0] sclk_reg;
  always @(posedge clk)
  begin
    sclk_reg <= {sclk_reg[1:0], sclk};
  end
  wire sclk_rise = (sclk_reg[2:1] == 2'b01);
  wire sclk_fall = (sclk_reg[2:1] == 2'b10);

  reg [2:0] ssel_reg;
  always @(posedge clk)
  begin
    ssel_reg <= {ssel_reg[1:0], ssel};
  end
  wire ssel_active = ~ssel_reg[1];
  wire ssel_start_msg  = (ssel_reg[2:1] == 2'b10);
  wire ssel_end_msg  = (ssel_reg[2:1] == 2'b01);

  reg [1:0] mosi_reg;
  always @(posedge clk)
  begin
    mosi_reg <= {mosi_reg[0], mosi};
  end
  wire mosi_data = mosi_reg[1];

  reg [2:0] bit_cnt;
  reg byte_rcvd;
  reg [7:0] byte_data_rcvd;
  always @(posedge clk)
  begin
    if (~ssel_active)
      bit_cnt <= 3'b000;
    else
      if (sclk_rise)
      begin
        bit_cnt <= bit_cnt + 3'b001;
        byte_data_rcvd <= {byte_data_rcvd[6:0], mosi_data};
      end
  end

  always @(posedge clk)
  begin
    byte_rcvd <= ssel_active && sclk_rise && (bit_cnt == 3'b111);
  end

  always @(posedge clk)
  begin
    if (byte_rcvd)
    begin
      led <= byte_data_rcvd[0];
    end
  end

endmodule
