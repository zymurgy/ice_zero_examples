module spi_slave (
  input  clk,
  input  sclk,
  input  mosi,
  output miso,
  input  ssel,
  output [7:0] dout,
  input  [7:0] din,
  output done
);

  reg [2:0] sclk_reg;
  always @(posedge clk)
    sclk_reg <= {sclk_reg[1:0], sclk};
  wire sclk_rise = (sclk_reg[2:1] == 2'b01);
  wire sclk_fall = (sclk_reg[2:1] == 2'b10);

  reg [2:0] ssel_reg;
  always @(posedge clk)
    ssel_reg <= {ssel_reg[1:0], ssel};
  wire ssel_active = ~ssel_reg[1];
  wire ssel_start_msg  = (ssel_reg[2:1] == 2'b10);
  wire ssel_end_msg  = (ssel_reg[2:1] == 2'b01);

  reg [1:0] mosi_reg;
  always @(posedge clk)
    mosi_reg <= {mosi_reg[0], mosi};
  wire mosi_data = mosi_reg[1];

  reg [2:0] bit_cnt;
  reg [7:0] byte_rcvd;
  reg [7:0] byte_send;
  always @(posedge clk)
    if (~ssel_active)
      sclk_reg <= 3'b000;
      ssel_reg <= 3'b000;
      mosi_reg <= 2'b00;
      bit_cnt <= 3'b000;
      done <= 1'b0;
      dout <= 8'h00;
    else
      if (sclk_rise)
        begin
          bit_cnt <= bit_cnt + 3'b001;
          byte_rcvd <= {byte_rcvd[6:0], mosi_data};
        end
        else if (sclk_fall)
          byte_send <= {byte_send[6:0], 1'b0};
      end

  always @(posedge clk)
    if (ssel_active)
      if (ssel_start_msg)
        byte_send <= din;

  always @(posedge clk)
    done <= ssel_active && sclk_rise && (bit_cnt == 3'b111);

  always @(posedge clk)
    if (done)
      dout <= byte_rcvd;

  assign miso = byte_send[7];
endmodule
