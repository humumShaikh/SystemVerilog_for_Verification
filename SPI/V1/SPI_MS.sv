module SPI_MS
(
  input wire clk,
  input wire reset,
  input wire start,
  input wire [7:0] din,
  output wire [7:0] dout,
  output wire spiClk
);

  wire spim_miso;
  wire spim_mosi;
  wire spim_sclk;
  wire spim_ss;

  SPI_M SPIM
  (
    .din(din),
    .start(start),
    .clk(clk),
    .reset(reset),
    .miso(spim_miso),
    .mosi(spim_mosi),
    .sclk(spim_sclk),
    .ss(spim_ss),
    .dout(dout)
  );
  
  
  SPI_S SPIS
  (
    .sclk(spim_sclk),
    .mosi(spim_mosi),
    .ss(spim_ss),
    .miso(spim_miso)
  );
  
  assign spiClk = spim_sclk;;
  
endmodule