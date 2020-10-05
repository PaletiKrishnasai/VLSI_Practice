`include "pg8bit.v"

module top;

reg[8:1] a;
wire parity;

parityeven final(parity,a);

initial
begin
    a=8'b10011001;
    #20 a=8'b11100000;
end
initial
begin
    $monitor($time,"input = %b  ;  output = %b ",a,parity);

end


endmodule