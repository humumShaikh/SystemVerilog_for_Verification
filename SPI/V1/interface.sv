interface spi_intf(input logic clk);

  logic spiClk;
  logic reset;
  logic start;
  logic [7:0] din;
  logic [7:0] dout;

endinterface