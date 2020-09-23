`include "WallaceTreeMul.v"

module top;

reg [31:0] a,b;
wire [63:0] prod;

WallaceTreeMul wtm1(a,b,prod);

initial 
begin
    a = 32'b1010;
    b = 32'b0011;
    #10;
end
initial
begin
    $monitor("\na = %d, \nb = %d,\nresult = %d",a,b,prod);
    $dumpfile("wtm.vcd");
    $dumpvars;
end

endmodule