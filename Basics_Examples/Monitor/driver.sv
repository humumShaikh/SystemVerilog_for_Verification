class Driver;
  
  function new();
    $display("Driver Class Object Created");
  endfunction
  
  task main(virtual intf vif);
    $display("Driving Signals through the driver now");
    vif.A <= 0; vif.B <= 0;
    #5;
    vif.A <= 0; vif.B <= 1;
    #5;
    vif.A <= 1; vif.B <= 0;
    #5;
    vif.A <= 1; vif.B <= 1;
    #5;
  endtask

endclass