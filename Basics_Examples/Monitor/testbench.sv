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
    drv = new();          //allocate space for the driver object
    mon = new();          //allocate space for the monitor object
    fork                  //the fork join is necessary so as to start both the tasks at the same time or else it will execute one after the other
      drv.main(vif);      //calling the function main of driver class and passing virtual interface as an argument
    mon.main(vif);
    join
    $finish;
  end
  
endmodule
