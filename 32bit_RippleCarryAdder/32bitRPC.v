// how to do in a modular way??
// explore by end of lab!!!

// 1 bit full adder 
module fulladdr_1_bit (sum, c_out, a, b, c_in);

input a,b,c_in;
output sum,c_out;

wire w1,w2,w3;

xor(w1,a,b);
xor(sum,w1,c_in);
and(w2,a,b);
and(w3,w1,c_in);
or(c_out,w2,w3);

endmodule

// 4 bit full adder
module fulladdr_4_bit (sum,c_out,a,b,c_in);

input[3:0] a,b;
input c_in;
output[3:0] sum;
output c_out;

wire w1,w2,w3;

fulladdr_1_bit fa0(sum[0],w1,a[0],b[0],c_in);
fulladdr_1_bit fa1(sum[1],w2,a[1],b[1],w1);
fulladdr_1_bit fa2(sum[2],w3,a[2],b[2],w2);
fulladdr_1_bit fa3(sum[3],c_out,a[3],b[3],w3);

endmodule

// 16 bit full adder
module fulladdr_16_bit (sum,c_out,a,b,c_in);

input[15:0] a,b;
input c_in;
output[15:0] sum;
output c_out;

wire w1,w2,w3;

fulladdr_4_bit fa4_0(sum[3:0],w1,a[3:0],b[3:0],c_in);
fulladdr_4_bit fa4_1(sum[7:4],w2,a[7:4],b[7:4],w1);
fulladdr_4_bit fa4_2(sum[11:8],w3,a[11:8],b[11:8],w2);
fulladdr_4_bit fa4_3(sum[15:12],c_out,a[15:12],b[15:12],w3);

endmodule

// 32 bit full adder
module fulladdr_32_bit (sum,c_out,a,b,c_in);

input[31:0] a,b;
input c_in;
output[31:0] sum;
output c_out;

wire w1;

fulladdr_16_bit fa16_0(sum[15:0],w1,a[15:0],b[15:0],c_in);
fulladdr_16_bit fa16_1(sum[31:16],c_out,a[31:16],b[31:16],w1);

endmodule

