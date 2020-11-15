// feedthrough
module Grey(G4_3,P4_3,G2_2,G4_2);
  input G4_3,P4_3,G2_2;
  output G4_2;
  wire s1 ;
  assign s1 = P4_3 & G2_2;
  assign G4_2=s1 | G4_3;
endmodule