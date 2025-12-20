module testbench();
  
  reg A;
  reg B;
  wire Y;
  
  intf vif();
  
  orGate OG (
    .A(vif.A),
    .B(vif.B),
    .Y(vif.Y)
  );
  
  initial
  begin
    $display("OR-GATE Testbench with a simple interface");
    $monitor("A = %0b B = %0b Y = %0b" , vif.A , vif.B , vif.Y);
    vif.A <= 0; vif.B <= 0;
    #5;
    vif.A <= 0; vif.B <= 1;
    #5;
    vif.A <= 1; vif.B <= 0;
    #5;
    vif.A <= 1; vif.B <= 1;
    #5;
    $finish;
  end
  
endmodule