`include "test.sv"
`include "interface.sv"

module testbench();
  
  intf vif();
  
  test tst(vif);
  
  ALU A(
    .A(vif.A),
    .B(vif.B),
    .S(vif.S),
    .Y(vif.Y)
  );
  
  
  initial
  begin
    #500;
    $finish;
  end
  
endmodule