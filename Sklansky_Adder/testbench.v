`include "Sklansky.v"

module top;

wire [15:0] Sum;
wire cout;
reg [15:0] A;
reg [15:0] B;
reg cin;

sklansky adder(cin,A,B,Sum,cout);

initial
begin
    cin = 1'b0;
//    A = 16'b0000101110111000; //3000
//    B = 16'b0000101110111000; //3000 
//          0001011101110000
//    A = 16'b100000000000;  // 2048
//    B = 16'b10000000000;   // 1024
    A = 16'b1110101001100000; //60000
    B = 16'b1001110001000;    //5000


end

initial
begin
    $monitor ($time, "  A = %d   B = %d    \n\t\t  A+B = %d ",A,B,Sum);
    $dumpfile("DA2.vcd");
    $dumpvars;
end

endmodule