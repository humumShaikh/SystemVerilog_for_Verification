class Scoreboard;

  mailbox mon2scb;
  
  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  
  task main();
    repeat(40)
    begin
      Transaction trans;
      trans = new();
      mon2scb.get(trans);
      trans.display("Scoreboard Class Signals");
      if(((trans.a ^ trans.b ^ trans.c) == trans.sum) && (((((trans.a & trans.b) | ((trans.a ^ trans.b) & trans.c)) == trans.carry)) == trans.carry))
        $display("----------TEST PASSED----------");
      else
        $display("!!!!!!!!!!TEST FAILED!!!!!!!!!!");
    end
  endtask

endclass