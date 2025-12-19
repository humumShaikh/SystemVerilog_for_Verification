class Monitor;

  virtual intf.monitor vif;
  
  mailbox mon2scb;
  
  Frame f[$];
  
  integer n = 0;
  
  function new(mailbox mon2scb , virtual intf.monitor vif);
    this.mon2scb = mon2scb;
    this.vif = vif;
  endfunction
  
  
  task main();
    n = 0;
    while(vif.cpl != 1)
    begin
      @(posedge vif.clk)
      begin
      f[n].data = vif.data;
      f[n].strobe = vif.strobe;
      n = n + 1;
      end
    end
    
    Packet p;
    p = new();
    p.totalFrames = f;
    mon2scb.put(p);
    $display("Packet sent from monitor to scoreboard via mail");
  endtask

endclass