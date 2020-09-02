module DFF(d,clk,reset,q);
input clk, reset;
input wire d;
output reg q;

always@(posedge clk)
begin
	if(reset)
 		q <= 1'b0;
	else
		q <= d;
end

endmodule