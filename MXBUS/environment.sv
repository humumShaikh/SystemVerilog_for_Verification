

class Environment;
  
  import mxPackage::*;
  
  virtual intf.driver vif_drv;
  
  Generator gen;
  Driver drv;
  Monitor mon;
  Scoreboard scb;

  mailbox gen2drv;
  
  
  function new(virtual intf.driver vif_drv);
    this.vif_drv = vif_drv;
    
    gen2drv = new();
    
    gen = new(gen2drv);
    drv = new(gen2drv , vif_drv);
  endfunction
  
  
  task run_test();
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join
  endtask
    
endclass