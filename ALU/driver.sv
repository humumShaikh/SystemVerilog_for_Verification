//  Driver Class
//  Drives the transaction object signals to the interface to pass on to the DUT

class Driver;

  mailbox gen2drv;      //mailbox for receiving the transaction object from generator
  virtual intf vif;    //virtual interface instance
  
  function new(virtual intf vif , mailbox gen2drv);    //constructor
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction
  
  
  task main();    //main task / responsibility
    repeat(40)    //repeat task 40 times
    begin
      Transaction trans;      //handle of object Transaction
      trans = new();          //allotting memory to it
      gen2drv.get(trans);      //inbuilt mailbox method to fetch
      
      vif.A <= trans.A;        //Driving the signals to the interface
      vif.B <= trans.B;        //Driving the signals to the interface
      vif.S <= trans.S;        //Driving the signals to the interface
      #10;
      
      trans.display("Driver Class Signals");      //transaction class method (optional)
      
    end
  endtask

endclass
