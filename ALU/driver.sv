class Driver;

  mailbox gen2drv;
  virtual intf vif;
  
  function new(virtual intf vif , mailbox gen2drv);
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction
  
  
  task main();
    repeat(40)
    begin
      Transaction trans;
      trans = new();
      gen2drv.get(trans);
      
      vif.A <= trans.A;
      vif.B <= trans.B;
      vif.S <= trans.S;
      #10;
      
      trans.display("Driver Class Signals");
      
    end
  endtask

endclass