class Monitor;

  mailbox mon2scb;
  virtual intf vif;
  
  function new(virtual intf vif , mailbox mon2scb);
    this.mon2scb = mon2scb;
    this.vif = vif;
  endfunction
  
  
  task main();
    repeat(40)
      //#1 optional to wait for 1ns and then sample
    begin
      Transaction trans;
      trans = new();
      trans.a = vif.a;
      trans.b = vif.b;
      trans.c = vif.c;
      trans.sum = vif.sum;
      trans.carry = vif.carry;
      mon2scb.put(trans);
      trans.display("Monitor Level Signals");
    end
  endtask

endclass
