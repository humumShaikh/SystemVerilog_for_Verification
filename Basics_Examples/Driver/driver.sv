//Basic Driver Class
//The main aim is to not drive the signals in the testbench file, rather than that we will create a drive class
//Then make an object of this class and define some funcitons of this class i.e. driving the signals 
//Here it is referred to as 'main'

class Driver;
  
  function new();                                    //This is a constructor that is necessary to be called with each class object in SV or else the memory is not allocated
    $display("Driver Class Object Created");
  endfunction
                                                        //note that the interface will always be passed as virtual in the task 
  task main(virtual intf vif);                          //takes an interface as arguement, we'll pass the interface that is connecting the dut to the testbench
    $display("Driving Signals through the driver now");  //that interface will then be used 
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
