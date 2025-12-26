program test(spi_intf vif);
  
  import spi_ms::*;
  
  Environment env;
  
  initial
  begin
    env = new(vif);
    env.run_test();
  end
  
endprogram