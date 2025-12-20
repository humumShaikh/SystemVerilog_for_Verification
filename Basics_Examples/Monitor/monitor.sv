//Basic Monitor Class
//The whole aim is to not check the signals and display them in the main testbench
//This is because when there are big duts and a lot of signals and sequential signals then it gets tedious
//That is why this monitor class is needed that will take care of all the displaying and the monitoring part

class Monitor;

  function new();        //Monitor class constructor , necessary without which the memory for this object will not be allocated
    $display("Monitor class object created");
  endfunction
  
  
  task main(virtual intf vif);        //main monitoring task taking the interface as an arguement, the monitor will take the signals coming from the interface and monitor them
    repeat(4)
    begin
      #5;                             //This time period is necessary and this time matches with the time after which new stimulus is applied, as per the driver
      $display("A = %0b B = %0b Y = %0b" , vif.A , vif.B , vif.Y);
    end
  endtask

endclass
