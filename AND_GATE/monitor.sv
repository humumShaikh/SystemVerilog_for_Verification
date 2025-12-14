//Monitor Class to sample the data received from the DUT via the interface
//Will sample the inputs to the interface as well as the outputs 

class Monitor;
  
  virtual intf vif;   //creating a virutal instance of the interface
  
  mailbox mon2scb;    //creating a mailbox monitor-to-scoreboard to mail the data to the scoreboard
  
  function new(virtual intf vif , mailbox mon2scb);   //cosntructor
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  
  task main();    //main task or responsibility of the Monitor Class
    repeat(40)    //repeat the task 40 times
    begin
      Transaction trans;    //create a handle of the class transaction
      trans = new();        //allot memory to it
      
      trans.A = vif.A;      //assign the value received from the interface to the value in the transaction object
      trans.B = vif.B;      //assign the value received from the interface to the value in the transaction object
      trans.Y = vif.Y;      //assign the value received from the interface to the value in the transaction object
      
      mon2scb.put(trans);   //put the ready transaction object in the monitor-to-scoreboard mailbox to be sent
      
      trans.display("Monitor Class Signals");       //(optional)
      
    end 
  endtask
  
endclass