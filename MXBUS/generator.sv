
class Generator;
  
  mailbox gen2drv;
  
  
  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  
  task main();
    Packet p;
    p = new();
    p.randomize();
    
    gen2drv.put(p);
    
    p.display("Packet Created and put on the mailbox for driver");
  endtask
  
  
endclass