`include "test.sv"

module testbench();

  intf vif_drv();
  
  test testCase(vif_drv);
  
  initial
  begin
    #1000;
    $finish;
  end

endmodule