module tb_top();
  
  logic clk = 0;
  always #5 clk <= ~clk;
  
  

  spi_intf vif(clk);
  
  test tst(vif);
  
  SPI_MS SPIMS
  (
    .clk(clk),
    .reset(vif.reset),
    .start(vif.start),
    .din(vif.din),
    .dout(vif.dout),
    .spiClk(vif.spiClk)
  );
  
  
  initial
  begin
    #250;
    $finish;
  end

endmodule