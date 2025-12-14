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
    repeat(40)
    begin
      Transaction trans;      //handle of object Transaction
      trans = new();          //allotting memory to it
      gen2drv.get(trans);      //inbuilt mailbox method to fetch
      
      vif.A <= trans.A;        //Driving 
      vif.B <= trans.B;
      vif.S <= trans.S;
      #10;
      
      trans.display("Driver Class Signals");
      
    end
  endtask

endclass
