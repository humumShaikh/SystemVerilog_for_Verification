module testbench();

  intf vif();

  test tst(vif);
  
  fullAdder FA(
    .a(vif.a),
    .b(vif.b),
    .c(vif.c),
    .sum(vif.sum),
    .carry(vif.carry)
  );
  
  initial
  begin
    #600;
    $finish;
  end

endmodule