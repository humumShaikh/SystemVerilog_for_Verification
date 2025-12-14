//Design file for ALU
//Single Bit ALU 
//Supports 4 operations
module ALU
(
  input wire A,
  input wire B,
  input wire [1:0] S,
  output wire Y
);

  logic f;
  
  always_comb          //combinational logic from systemverilog
  begin
    case (S)
      2'b00 : f = A ^ B;
      2'b01 : f = A & B;
      2'b10 : f = A + B;
      2'b11 : f = A - B;
    endcase
  end
  
  assign Y = f;


endmodule
