`include "Compressors/fa.v"

module fourc(sum,ca,ca_out,a,b,c,d,ca_in);

input a,b,c,d,ca_in;
output sum,ca,ca_out;

wire w1;

fa fa_0(w1,ca_out,a,b,c);
fa fa_1(sum,ca,w1,d,ca_in);


endmodule
