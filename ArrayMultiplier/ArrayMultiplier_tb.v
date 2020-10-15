`include "ArrayMultiplier.v"
module top;

  wire [31:0] p;
  reg [15:0] a;
  reg [15:0] x;

  ArrayMultiplier #(.m(16), .n(16)) am (p, a, x);
  initial $monitor("a=%b,x=%b,p=%b", a, x, p);


  initial
  begin
    a = 16'b110111;
    x = 16'b11111;
  end
endmodule