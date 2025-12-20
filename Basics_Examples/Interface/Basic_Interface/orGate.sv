//Absolutely Simple OR-Gate Design file

module orGate
(
  input wire A,
  input wire B,
  output wire Y
);

  assign Y = A | B;

endmodule
