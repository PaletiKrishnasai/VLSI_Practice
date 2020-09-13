`include "rdcla.v"

module top;

reg [32:1] a,b;
reg cin;
wire [32:1] sum;
wire cout;

RecursiveDoubling rd(a,b,cin,sum,cout);

initial
begin
    #0 a=32'b0; b=32'b0; cin = 1'b0;
   #10 a=32'b11111000111000111000111000111000;
   #20    b=32'b11111000111000111000000111011011;
      
end
initial
begin
    $monitor($time,"\ta = %b , b = %b , cin = %b , cout = %b , sum = %b",a,b,cin,cout,sum);
    $dumpfile("rd.vcd");
    $dumpvars;
end

endmodule