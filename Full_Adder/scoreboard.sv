//scoreboard class

class scoreboard;
  mailbox mon2scb; // mailbox declaration mon to scoreboard
  
  function new (mailbox mon2scb);
    //this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task main();
    
    transaction trans;
    repeat (40)
     
     begin
     mon2scb.get(trans);
     trans.display("scoreboard signals");

        //reference module / golden dut
     if( ( ( trans.a ^ trans.b ^ trans.c) == trans.sum) && ((( trans.a & trans.b ) | ( trans.b & trans.c ) | ( trans.c & trans.a )) == trans.carry)) //reference model logic
      $display("******* PASS *******");
        
      else
      $display("!!!!!!!! FAIL !!!!!!!!!!");     
      $display("//////////////////////////Trasaction Done////////////////////////////////");
      $display("                                                                          ");


      end
  endtask
  
endclass
