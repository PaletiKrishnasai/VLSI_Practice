`include "32bitRPC.v"

module top;
reg [31:0] a,b;
reg c_in;
wire[31:0] sum;
wire c_out;
//wire w1;

fulladdr_32_bit f32(sum,c_out,a,b,c_in);

initial 
begin
   a=1'b1; b=1'b0; c_in=1'b0;
	#10 a=32'b10101111101011111010101011111111;
	#10 b=32'b10101110101110101110101111111111; 
	#10 a=32'b11111011111111111010101011101010;
	#10 b=32'b11101110111111110111011111111111; 
end

initial
begin
    $monitor ($time,"  a = %h; b = %h; c_in = %h; sum = %h; c_out = %b", a, b, c_in, sum, c_out);
    $dumpfile("RCA32.vcd");
    $dumpvars;
end

endmodule
