//Scoreboard class to compare the received transaction values with how the actual values should be
//Here the scoreboard is doing the math based on the inputs and output received via the mailbox and validating it

class Scoreboard;
  
  mailbox mon2scb;    //mailbox to receive transaction object from monitor
  
  function new(mailbox mon2scb);    //constructor
    this.mon2scb = mon2scb;
  endfunction
  
  
  task main();    //main responsibility or task of the class Scoreboard
    repeat(40)    //repeat the task 40 times
    begin
      Transaction trans;    //creating a handle of the class transaction
      trans = new();        //allotting memory to it
      mon2scb.get(trans);   //fetch the transaction object via the mail and assign the values in it to the transaction object created locally
      
      trans.display("Scoreboard Class Signals");    //(optional)
      
      if((trans.A & trans.B)   ==    (trans.Y))    //reference model or the calculation to verify the received object
        $display("---------TEST PASSED---------");
      else
        $display("!!!!!!!!!TEST FAILED!!!!!!!!!");
      
    end    
  endtask
  
endclass