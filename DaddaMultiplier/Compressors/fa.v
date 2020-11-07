module fa(s,c,a,b,ca);
input a,b,ca;
output s,c;

assign s=a^b^ca;
assign c=(a&b)|(a&ca)|(ca&b);


endmodule