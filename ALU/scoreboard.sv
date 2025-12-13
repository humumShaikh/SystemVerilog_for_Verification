class Scoreboard;

  mailbox mon2scb;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  
  task main();
    repeat(40)
    begin
      Transaction trans;
      
      mon2scb.get(trans);
      
      trans.display("Scoreboard Class Signals");
      
      case(trans.S)
        0 : begin
              if(trans.A ^ trans.B  == trans.Y)
                $display("-----TEST PASSED-----");
              else
                $display("!!!!!TEST FAILED!!!!!");
            end 
        1 : begin
              if(trans.A & trans.B  ==  trans.Y)
                $display("-----TEST PASSED-----");
              else
                $display("!!!!!TEST FAILED!!!!!");
            end     
        2 : begin
              if(trans.A + trans.B  ==  trans.Y)
                $display("-----TEST PASSED-----");
              else
                $display("!!!!!TEST FAILED!!!!!");  
            end     
        3 : begin
              if(trans.A - trans.B  ==  trans.Y)
                $display("-----TEST PASSED-----");
              else
                $display("!!!!!TEST FAILED!!!!!");  
            end            
      endcase
      
    end
  endtask

endclass