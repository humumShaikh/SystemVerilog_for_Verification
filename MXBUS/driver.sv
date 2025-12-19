


class Driver;
  
  mailbox gen2drv;
  
  virtual intf.driver vif;
  
  
  function new(mailbox gen2drv , virtual intf.driver vif);
    this.gen2drv = gen2drv;
    this.vif = vif;
  endfunction
  
  
  task main();
    repeat(1)
    begin
      Packet p;
      p = new();
      gen2drv.get(p);
      
      @(posedge vif.clk)
        startWriteOperation();
      
      do begin                //basically wait until the acknowledgement comes
        @(posedge vif.clk);
      end while(!vif.ack);
      
      assertReady();
      
      @(posedge vif.clk)      //start sending
      
        assertDValid();
        
        while(p.totalFrames.size() > 1)   //send the first to secondlast fram
        begin
          @(posedge vif.clk)
          begin
            deassertComplete();
            writeData();
          end
        end
        
        while(p.totalFrames.size() == 1)  //send the last frame
        begin
          @(posedge vif.clk)
            begin
              assertComplete();
              writeData();
            end
        end
        
        @(posedge vif.clk)
          endWriteOperation();
      
      
    end
  endtask
  
  
  
  task startWriteOperation();
    vif.start   <= 1;
    vif.address <= p.address;
    vif.length  <= p.length;
    vif.cpl     <= 1'b0;
    vif.dvalid  <= 1'b0;
    vif.ready   <= 1'b0;
  endtask
  
  task assertReady();
    vif.ready <= 1'b1;
  endtask
  
  task deassertReady();
    vif.ready <= 1'b0;
  endtask
  
  task assertDValid();
    vif.dvalid <= 1'b1;
  endtask
  
  task deassertDValid();
    vif.dvalid <= 1'b0;
  endtask
  
  task assertComplete();
    vif.cpl <= 1'b1;
  endtask
  
  task deassertComplete();
    vif.cpl <= 1'b0;
  endtask
  
  task writeData();
    Frame f;
    f = new();
    f = p.totalFrames.pop_front();
    vif.data <= f.data;
    vif.strobe <= f.strobe;
  endtask
  
  task endWriteOperation();
    deassertDValid();
    deassertComplete();
  endtask
  
endclass