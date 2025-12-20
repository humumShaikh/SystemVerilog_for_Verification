`include "driver.sv"

module testbench();
  
  intf vif();
  
  Driver drv;
  
  orGate OG (
    .A(vif.A),
    .B(vif.B),
    .Y(vif.Y)
  );
  
  initial
  begin
    $monitor("A = %0b B = %0b Y = %0b" , vif.A , vif.B , vif.Y);
    drv = new();
    drv.main(vif);
    $finish;
  end
  
endmodule