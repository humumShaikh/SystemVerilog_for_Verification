class Generator;

  mailbox gen2drv;
  
  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  
  task main();
    repeat(40)
    begin
      Transaction trans;
      trans = new();
      trans.randomize();
      
      gen2drv.put(trans);
      trans.display("Generator Class Signal");
    end
  endtask

endclass