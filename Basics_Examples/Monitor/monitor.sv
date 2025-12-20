class Monitor;

  function new();
    $display("Monitor class object created");
  endfunction
  
  
  task main(virtual intf vif);
    repeat(4)
    begin
      #5;
      $display("A = %0b B = %0b Y = %0b" , vif.A , vif.B , vif.Y);
    end
  endtask

endclass