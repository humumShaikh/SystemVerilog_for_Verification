class Monitor;

  mailbox mon2scb;
  virtual intf vif;
  
  function new(virtual intf vif , mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  
  task main();
    repeat(40)
    begin
      Transaction trans;
      trans = new();
      
      trans.A = vif.A;
      trans.B = vif.B;
      trans.S = vif.S;
      trans.Y = vif.Y;
      
      mon2scb.put(trans);
      
      trans.display("Monitor Class Signal");
    end
  endtask

endclass