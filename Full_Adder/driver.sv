//driver class : take the mailbox info and put into DUT through interface

class driver;
  virtual intf vif; //virtual interface : intferface is static, Class is dynamic, so virtual
  //vif pointing to actual interface
  
  mailbox gen2drv;
  
  function new (virtual intf vif, mailbox gen2drv);// constructor
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction
  
  task main();
   
    repeat(40)
       
      begin
        transaction trans;
        
        gen2drv.get(trans);// driver get the transactions from mailbox to driver
        
        vif.a <= trans.a;
        vif.b <= trans.b;
        vif.c <= trans.c;
        #10;
        
        trans.display("driver class signals");
      
      end
  endtask
endclass
