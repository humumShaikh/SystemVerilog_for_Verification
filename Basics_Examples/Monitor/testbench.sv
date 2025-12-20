`include "driver.sv"
`include "monitor.sv"

module testbench();
  
  intf vif();
  
  Driver drv;
  Monitor mon;
  
  orGate OG (
    .A(vif.A),
    .B(vif.B),
    .Y(vif.Y)
  );
  
  initial
  begin
    //$monitor("A = %0b B = %0b Y = %0b" , vif.A , vif.B , vif.Y);
    drv = new();
    mon = new();
    fork
    drv.main(vif);
    mon.main(vif);
    join
    $finish;
  end
  
endmodule