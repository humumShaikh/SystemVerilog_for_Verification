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
      vif.a <= trans.a;
      vif.b <= trans.b;
      vif.c <= trans.c;
      #10;
      trans.display("Driver Class Signals");
    end
  endtask

endclass