//Driver Class will take the transaction object from the generator via the mailbox and then drive those signals to the interface whicl in turn will drive the DUT

class Driver;
  
  virtual intf vif;   //creating a virutal instance of the interface
  
  mailbox gen2drv;    //creating a mailbox to receive data from the generator
  
  function new(virtual intf vif , mailbox gen2drv);   //constructor for class Driver
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction
  
  
  task main();    //main task or responsibility of the Driver Class Object
    repeat(40)    //repeating this process 40 times
    begin
      Transaction trans;    //creating a handle of the transaction class
      trans = new();        //alloting memory to it
      
      gen2drv.get(trans);   //fetch the data from the mailbox and assign it to the trans object created
      
      vif.A <= trans.A;     //drive the signals received in the trans obj via the mailbox to the interface
      vif.B <= trans.B;     //drive the signals received in the trans obj via the mailbox to the interface
      #10;                  //wait for some time
      
      trans.display("Driver Class Signals");     //optional
      
    end
  endtask
  
endclass