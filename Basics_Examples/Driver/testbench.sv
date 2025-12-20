`include "driver.sv"      //To include the driver class

module testbench();
  
  intf vif();            //creating an interface object called as 'vif'
  
  Driver drv;            //creating a driver class object called as 'drv'. Note - memory won't be allocated since the new function isn't called and hence rn it is uselss
  
  orGate OG (            //creating an instance of the or-gate DUT
    .A(vif.A),
    .B(vif.B),
    .Y(vif.Y)
  );
  
  initial
  begin
    $monitor("A = %0b B = %0b Y = %0b" , vif.A , vif.B , vif.Y);  //monitoring the signals
    drv = new();                  //allocating memory in the heap for the driver class object making it actually usable
    drv.main(vif);                //calling the driver class task 'main' to actuall do the driving part and passing the interface created
    $finish;
  end

  //note - it was necessary to pass the interface as an arguement in the driver here rather than just creating an interface inside the driver class because
  //we need the interface to be connected to the dut as well and we would'nt have been able to do that if we just created an interface in the driver class and drove that
endmodule
