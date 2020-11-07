`include "Compressors/f52.v"

module randm(sum1,sum2,sum3,ca1,ca2,ca3,ca4,ca5,ca6,ca7,c1,c2,c3,c4,c5,c6,c7,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10);
input p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
output sum1,sum2,sum3,ca1,ca2,ca3,ca4,ca5,ca6,ca7;
input c1,c2,c3,c4,c5,c6,c7;

fivec fc_19(sum1,ca1,ca2,ca3,p1,p2,p3,p4,c1,c2,c3);
fivec fc_20(sum2,ca4,ca5,ca6,p5,p6,p7,p8,c4,c5,c6);
fa fc_21(sum3,ca7,p9,p10,c7);

endmodule
