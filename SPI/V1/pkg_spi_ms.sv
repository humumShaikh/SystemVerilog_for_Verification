package spi_ms;
  
  
  
  
  
  
  class Transaction; ////////
    
         bit reset;
         bit start;
         bit [7:0] din;
    rand bit [7:0] dout;
    
    function void setForStart();
      reset = 0;
      start = 1;
    endfunction
    
    function void display(string msg);
      $display("Transaction : DOUT = %0h" , dout);
      $display("%s" , msg);
    endfunction
    
  endclass          /////////
  
  
  
  
  
  
  
  
  
  class Generator;
    
    mailbox gen2drv;
    
    function new(mailbox gen2drv);
      this.gen2drv = gen2drv;
    endfunction
    
    task main();
      repeat(2)
      begin
        Transaction trans;
        trans = new();
        trans.randomize();
        trans.setForStart();
        gen2drv.put(trans);
        trans.display("Transcation Data - M to S");
      end
    endtask
    
  endclass
  
  
  
  
  
  
  
  class Driver;
    
    virtual spi_intf vif;
    
    mailbox gen2drv;
    
    
    function new(mailbox gen2drv , virtual spi_intf vif);
      this.gen2drv = gen2drv;
      this.vif = vif;
    endfunction
    
    
    
    task main();
      repeat(2)
      begin
        Transaction trans;
        trans = new();
        gen2drv.get(trans);
        
        @(posedge vif.clk)
        begin
          vif.start <= trans.start;     //signal driving
          vif.reset <= trans.reset;     //signal driving
          vif.dout = trans.dout;       //signal driving
        end
        
        @(posedge vif.clk)
        begin
            vif.start <= 1'b0;
        end
        
      end
    endtask
    
  endclass
  
  
  
  
  
  
  
  
  
  
  
  class Monitor;
    
    virtual spi_intf vif;
    
    mailbox mon2scb;
    
    
    function new(mailbox mon2scb , virtual spi_intf vif);
      this.mon2scb = mon2scb;
      this.vif = vif;
    endfunction
    
    
    task main();
      repeat(2)
      begin
        Transaction trans;
        trans = new();
        
        repeat(8)
        begin
          @(posedge vif.spiClk);
        end
        
        @(negedge vif.clk)
        begin
          trans.dout = vif.dout;    //sampling the data at the right time
          trans.din = vif.din;
        end
        
        mon2scb.put(trans);
      end
    endtask
    
  endclass
  
  
  
  
  
  
  
  
  
  
  
  class Scoreboard;
    
    mailbox mon2scb;
    virtual spi_intf vif;
    
    function new(mailbox mon2scb , virtual spi_intf vif);
      this.mon2scb = mon2scb;
      this.vif = vif;
    endfunction
    
    
    task main();
      repeat(2)
      begin
        Transaction trans;
        trans = new();
        
        repeat(8)
        begin
          @(posedge vif.spiClk);
        end
        
        @(negedge vif.clk)
        begin
          mon2scb.get(trans);
        end
        
        if(trans.dout != 8'h88)
          begin
            $display("Transaction 1 failed");
          end
        else if(trans.dout == 8'h88)
          begin
            $display("Transaction 1 was a success");
          end
        
      end
    endtask
    
  endclass
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  class Environment;
    
    virtual spi_intf vif;
    
    mailbox gen2drv;
    mailbox mon2scb;
    
    Generator gen;
    Driver drv;
    Monitor mon;
    Scoreboard scb;
    
    
    function new(virtual spi_intf vif);
      this.vif = vif;
      
      gen2drv = new();
      mon2scb = new();
      
      gen = new(gen2drv);
      drv = new(gen2drv , vif);
      mon = new(mon2scb , vif);
      scb = new(mon2scb , vif);
      
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
  
  
  
  
endpackage