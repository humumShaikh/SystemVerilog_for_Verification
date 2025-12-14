//AND GATE Design File

module AND_GATE
(
  input wire A,
  input wire B,
  output wire Y
);

  assign Y = A & B;
  
endmodule