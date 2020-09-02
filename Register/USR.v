`include "DFF.v"
`include "mux.v"

module USR8(out,pin,clk,reset,select,lin,rin);

wire[7:0] w; // connecting mux to DFF
input[7:0] pin;
input[1:0] select;
input clk;
input reset,lin,rin;
output[7:0] out; // outputs of

mux4x1 m1(w[0],out[0],out[1],lin,pin[0],select[1],select[0]);
mux4x1 m2(w[1],out[1],out[2],out[0],pin[1],select[1],select[0]);
mux4x1 m3(w[2],out[2],out[3],out[1],pin[2],select[1],select[0]);
mux4x1 m4(w[3],out[3],out[4],out[2],pin[3],select[1],select[0]);
mux4x1 m5(w[4],out[4],out[5],out[3],pin[4],select[1],select[0]);
mux4x1 m6(w[5],out[5],out[6],out[4],pin[5],select[1],select[0]);
mux4x1 m7(w[6],out[6],out[7],out[5],pin[6],select[1],select[0]);
mux4x1 m8(w[7],out[7],rin,out[6],pin[7],select[1],select[0]);

//module DFF(d,clk,reset,q);

DFF d1(w[0],clk,reset,out[0]);
DFF d2(w[1],clk,reset,out[1]);
DFF d3(w[2],clk,reset,out[2]);
DFF d4(w[3],clk,reset,out[3]);
DFF d5(w[4],clk,reset,out[4]);
DFF d6(w[5],clk,reset,out[5]);
DFF d7(w[6],clk,reset,out[6]);
DFF d8(w[7],clk,reset,out[7]);

endmodule

