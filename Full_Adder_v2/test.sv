`include "environment.sv"

program test(intf vif);
  
  Environment env;
  
  initial
  begin
    env = new(vif);
    env.test_run();
  end
  
endprogram