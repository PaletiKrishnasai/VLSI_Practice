`include "USR.v"

module top;
reg[7:0] pin;
reg[1:0] select;
reg clk;
reg reset,lin,rin;
wire[7:0] out; //output of DFFs

USR8 pika
(
    .out(out),
    .pin(pin),
    .clk(clk),
    .reset(reset),
    .select(select),
    .lin(lin),
    .rin(rin)
);

initial
begin
    pin = 8'b00000000;
    clk = 1'b1;
    reset = 1'b0;
    lin = 1'b0;
    rin = 1'b0;
    select = 2'b00;

    #10 reset = 1'b1;
    #10 
    reset = 1'b0;
    rin = 1'b1;
    select = 2'b01;
    //select = 2'b00;
    #10
    rin = 1'b1;
    select = 2'b01;
    #10
    select = 2'b10;
    #10
    pin = 8'b11110000;
    rin = 1'b0;
    select = 2'b11;
    #10
    select = 2'b01;



    
end
always #5 clk = ~clk;

initial
begin
    $monitor($time,"lin = %b; rin = %b; pin = %b; out = %b; reset = %b, clk = %b ; select = %b",lin,rin,pin,out,reset,clk,select);

		$dumpfile("USR_tb.vcd");
		$dumpvars(0,top);
	
end
initial 
#150 $finish;

endmodule