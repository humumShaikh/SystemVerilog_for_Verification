class Scoreboard;
  
  mailbox mon2scb;
  mailbox gen2drv;
  
  Frame f1[$];
  Frame f2[$];
  
  function new(mailbox mon2scb , mailbox gen2drv);
    this.mon2scb = mon2scb;
    this.gen2drv = gen2drv;
  endfunction
  
  
  task main();
    Packet p;
    p = new();
    Packet q;
    q = new();
    mon2scb.get(p);
    gen2drv.get(q);
    
    f1 = p.totalFrames;
    f2 = q.totalFrames;
    
    while(f1.size() > 0)
    begin
      if(f1[0].data != f2[0].data)
        $display("Incorrect Data Received");
      if(f1[0].strobe != f2[0].strobe)
        $display("Incorrect Strobe Received");
        
      f1.pop_front();   
    end
    
  endtask
  
endclass