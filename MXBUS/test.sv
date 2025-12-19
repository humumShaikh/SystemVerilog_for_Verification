`include "environment.sv"

program test(intf vif_drv);

  Environment env;
  
  initial
  begin
    env = new(vif_drv);
    env.run_test();
  end

endprogram