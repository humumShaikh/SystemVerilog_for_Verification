//Generator class to keep generating random transactions
//Generator will be called and then it's object will be created , used and destroyed

class Generator;

  mailbox gen2drv;  //mailbox to send the generated transaction data to the driver 
  
  
  function new(mailbox gen2drv);  //constructor
    this.gen2drv = gen2drv;
  endfunction
  
  //function new(mailbox mbx);  //alternate way to write the same constructor
  //  gen2drv = mbx;
  //endfunction
  
  
  task main();  //main task of the Generator class
    repeat(40)  //repeat this process 40 times
    begin
      Transaction trans;    //create a handle of class transaction
      trans = new();        //allocate memory to it
      trans.randomize();    //randomize the variables (bits A , B in our case)
      
      gen2drv.put(trans);   //Put the object trans on the mailbox, the mailbox will automatically handle the delivery of this object
      
      trans.display("Generator Class Signals");
    end
  endtask

endclass