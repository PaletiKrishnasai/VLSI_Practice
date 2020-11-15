// merge
module Black(G6_8,P6_8,G7_10,P7_10,G6_10,P6_10);
  input G6_8,P6_8,G7_10,P7_10;
  output G6_10,P6_10;
  wire s1 ;
  assign s1 = P6_8 & G7_10;
  assign G6_10=s1 | G6_8;
  assign P6_10=P6_8 & P7_10;
endmodule