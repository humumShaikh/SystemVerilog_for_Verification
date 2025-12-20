//Absolutely Simple Testbench Module
//Unlike traditional verilog testbenches, the testbench here will not have it's own pins for driving the stimulus
//The DUT that we call here is only supposed to be driven through the interface
//This example will familiarize and give you an idea of how to give stimulus through the interface

module testbench();
  
  intf vif();    //making a static object of interface and calling it as 'vif' ....the round brackets are mandatory here 
  
  orGate OG (    //making a DUT and connecting it's ports to the interface's ports
    .A(vif.A),
    .B(vif.B),
    .Y(vif.Y)
  );
  
  initial
  begin                                                            //simple block to give stimulus, note the interface signals are being manipulated here
    $display("OR-GATE Testbench with a simple interface");
    $monitor("A = %0b B = %0b Y = %0b" , vif.A , vif.B , vif.Y);
    vif.A <= 0; vif.B <= 0;
    #5;
    vif.A <= 0; vif.B <= 1;
    #5;
    vif.A <= 1; vif.B <= 0;
    #5;
    vif.A <= 1; vif.B <= 1;
    #5;
    $finish;
  end
  
endmodule
