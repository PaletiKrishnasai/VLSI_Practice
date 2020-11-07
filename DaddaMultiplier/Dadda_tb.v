`include "Dadda.v"

module test;

reg  [16:1]a,b;
wire  [32:1] c;
wire  [32:1] d;
wire  [32:1] e;

Dadda w_0(c,a,b);

initial
begin
#0  a=1024; b=128;
#13  a=2048; b=2;
#13  a=512; b=4;

end

initial
 begin
 	$monitor($time,"Delay  Input :Multiplier=%d    Multiplicand =%d;\n\t\t\t\tOutput:\t=%d\n",a,b,c);
 	$dumpfile("Dadda.vcd");
 	$dumpvars; 
 
end
endmodule