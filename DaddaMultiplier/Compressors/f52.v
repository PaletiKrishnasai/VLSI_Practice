`include "Compressors/f42.v"

module fivec(sum,ca,ca_out1,ca_out2,a,b,c,d,e,ca_in1,ca_in2);

input a,b,c,d,e,ca_in1,ca_in2;
output sum,ca,ca_out1,ca_out2;

wire w1,w2;

fa fa_0(w1,ca_out1,a,b,c);
fa fa_1(w2,ca_out2,w1,d,ca_in1);
fa fa_2(sum,ca,w2,e,ca_in2);


endmodule

