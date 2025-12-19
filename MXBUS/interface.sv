interface intf
(
  input logic clk,
  input logic start,
  input logic ready,
  input logic ack,
  input logic dvalid,
  input logic complete
);

  logic [ 5 :  0] address;
  logic [ 5 :  0] length;
  logic [31 :  0] data;
  logic [ 3 :  0] strobe;

  modport driver(
    output start,
    output ready,
    output address,
    output length,
    input  ack,
    output dvalid,
    output data,
    output strobe,
    output complete
  );

endinterface