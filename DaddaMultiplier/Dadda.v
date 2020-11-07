                                                            // CED18I039

// DADDA MULTIPLIER 16 Bit using 5:2 compressor as the major reduction compressor and 4:2 compressor and FullAdder and HalfAdder to simulate 3:2 and 2:2 compressors
// 16-->12-->5-->2-->CLA-->O/P

`include "Compressors/random.v"
`include "Compressors/ha.v"
`include "CarryLookAhead/adder32alt.v"
module Dadda(c,a,b);
input [16:1] a,b;

output[32:1] c;

reg pp [16:1][31:1];
 //array 
integer i,j,k;
always@(a or b)
 begin
    begin
        for(i=1;i<17;i=i+1)
            begin
                for(j=1;j<32;j=j+1)
                begin
                   pp[i][j]=1'b0;
                   
                end
            end
    end
    begin
        for(i=1;i<17;i=i+1)
            begin
                for(j=1;j<17;j=j+1)
                begin
                   
                pp[i][j+i-1]=a[j]&b[i];
                   
                end
            end
    end
    begin
        for(i=17;i<32;i=i+1)
            begin
                for(j=1;j<=32-i;j=j+1)
                begin
                   pp[j][i]=pp[j+(i-16)][i];
                   pp[j+(i-16)][i]=1'b0;
                   
                 end
            end
    end
end




                                                                //level 1

wire sum[10:1],ca[21:1];
reg  pp1 [12:1][31:1];

//column 13
ha ha_0(sum[1],ca[1],pp[1][13],pp[2][13]);
//column 14
fourc fc_0(sum[2],ca[2],ca[3],pp[1][14],pp[2][14],pp[3][14],1'b0,ca[1]);
//column 15
fivec fc_1(sum[3],ca[4],ca[5],ca[6],pp[1][15],pp[2][15],pp[3][15],pp[4][15],ca[2],ca[3],1'b0);
//column 16
fivec  fc_2(sum[4],ca[7],ca[8],ca[9],pp[1][16],pp[2][16],pp[3][16],pp[4][16],pp[5][16],ca[4],ca[5]);
ha ha_2(sum[5],ca[10],pp[6][16],ca[6]);
//column 17
fivec  fc_4(sum[6],ca[12],ca[13],ca[14],pp[1][17],pp[2][17],pp[3][17],pp[4][17],ca[7],ca[8],ca[9]);
ha ha_3(sum[10],ca[11],pp[5][17],ca[10]);
//column 18
fivec fc_5(sum[7],ca[15],ca[16],ca[17],pp[1][18],pp[2][18],pp[3][18],ca[11],ca[12],ca[13],ca[14]);
//column 19
fourc fc_6(sum[8],ca[18],ca[19],pp[1][19],pp[2][19],ca[15],ca[16],ca[17]);
//column 20
fa fa_0(sum[9],ca[20],pp[1][20],ca[18],ca[19]);

always@(a or b)
     #3 begin
        for(i=1;i<=12;i+=1)
            begin
                for(j=1;j<=12;j+=1)
                begin
                   pp1[i][j]=pp[i][j];
                   
                 end
            end

    begin
        for(i=3;i<=13;i+=1)
            begin
            pp1[i-1][13]=pp[i][13];
            end
    end

    begin
        for(i=4;i<=14;i+=1)
            begin
            pp1[i-2][14]=pp[i][14];
            end
    end
pp1[1][13]=sum[1];
pp1[1][14]=sum[2];

pp1[1][15]=sum[3];

    begin
        for(i=5;i<=15;i+=1)
            begin
            pp1[i-3][15]=pp[i][15];
            end
    end
//column 16
pp1[1][16]=sum[4];
pp1[2][16]=sum[5];

    begin
        for(i=7;i<=16;i+=1)
            begin
            pp1[i-4][16]=pp[i][16];
            end
    end

//column 17
pp1[1][17]=sum[6];
pp1[2][17]=sum[10];
    begin
        for(i=6;i<=15;i+=1)
            begin
            pp1[i-3][17]=pp[i][17];
            end
    end
//column 18
pp1[1][18]=sum[7];


    begin
        for(i=4;i<=14;i+=1)
            begin
            pp1[i-2][18]=pp[i][18];
            end
    end
//column 19
pp1[1][19]=sum[8];


    begin
        for(i=3;i<=13;i+=1)
            begin
            pp1[i-1][19]=pp[i][19];
            end
    end
//column 20
pp1[1][20]=sum[9];


    begin
        for(i=2;i<=12;i+=1)
            begin
            pp1[i][20]=pp[i][20];
            end
    end
//column21
pp1[1][21]=ca[20];

    begin
        for(i=1;i<=11;i+=1)
            begin
            pp1[i+1][21]=pp[i][21];
            end
    end


    begin
        for(i=22;i<=31;i+=1)
            begin
                for(j=1;j<=12;j+=1)
                    begin
                        pp1[j][i]=pp[j][i];
                    end
            end
    end


end



                                                                //level 2(5)

wire sum2[100:1],ca2[200:1];
reg  pp2 [5:1][31:1];


//column 6
ha ha_1(sum2[1],ca2[1],pp1[1][6],pp1[2][6]);
//column 7
fourc fc_7(sum2[2],ca2[2],ca2[3],pp1[1][7],pp1[2][7],pp1[3][7],ca2[1],1'b0);
//column 8
fivec fc_8(sum2[3],ca2[4],ca2[5],ca2[6],pp1[1][8],pp1[2][8],pp1[3][8],pp1[4][8],ca2[2],ca2[3],1'b0);
//column9
fivec fc_9(sum2[4],ca2[7],ca2[8],ca2[9],pp1[1][9],pp1[2][9],pp1[3][9],pp1[4][9],pp1[5][9],ca2[4],ca2[5]);
ha ha_4(sum2[5],ca2[10],pp1[6][9],ca2[6]);
//column10
fivec fc_11(sum2[6],ca2[12],ca2[13],ca2[14],pp1[1][10],pp1[2][10],pp1[3][10],pp1[4][10],pp1[5][10],ca2[7],ca2[8]);
fourc fc_12(sum2[7],ca2[15],ca2[16],pp1[6][10],pp1[7][10],ca2[9],ca2[10],1'b0);
//column 11
fivec fc_13(sum2[8],ca2[17],ca2[18],ca2[19],pp1[1][11],pp1[2][11],pp1[3][11],pp1[4][11],pp1[5][11],ca2[12],ca2[13]);
fivec fc_14(sum2[9],ca2[20],ca2[21],ca2[22],pp1[6][11],pp1[7][11],pp1[8][11],ca2[14],ca2[15],ca2[16],1'b0);
//column 12
fivec fc_15(sum2[10],ca2[23],ca2[24],ca2[25],pp1[1][12],pp1[2][12],pp1[3][12],pp1[4][12],ca2[17],ca2[18],ca2[19]);
fivec fc_16(sum2[11],ca2[26],ca2[27],ca2[28],pp1[5][12],pp1[6][12],pp1[7][12],pp1[8][12],ca2[20],ca2[21],ca2[22]);
ha ha_5(sum2[12],ca2[29],pp1[9][12],pp1[10][12]);
//column 13
randm fc_22(sum2[13],sum2[14],sum2[15],ca2[36],ca2[35],ca2[34],ca2[33],ca2[32],ca2[31],ca2[30],ca2[29],ca2[28],ca2[27],ca2[26],ca2[25],ca2[24],ca2[23],
                    pp1[1][13],pp1[2][13],pp1[3][13],pp1[4][13],pp1[5][13],pp1[6][13],pp1[7][13],pp1[8][13],pp1[9][13],pp1[10][13]);

//column 14
randm fc_23(sum2[16],sum2[17],sum2[18],ca2[43],ca2[42],ca2[41],ca2[40],ca2[39],ca2[38],ca2[37],ca2[36],ca2[35],ca2[34],ca2[33],ca2[32],ca2[31],ca2[30],
                    pp1[1][14],pp1[2][14],pp1[3][14],pp1[4][14],pp1[5][14],pp1[6][14],pp1[7][14],pp1[8][14],pp1[9][14],pp1[10][14]);

//column 15
randm fc_24(sum2[19],sum2[20],sum2[21],ca2[50],ca2[49],ca2[48],ca2[47],ca2[46],ca2[45],ca2[44],ca2[43],ca2[42],ca2[41],ca2[40],ca2[39],ca2[38],ca2[37],
                    pp1[1][15],pp1[2][15],pp1[3][15],pp1[4][15],pp1[5][15],pp1[6][15],pp1[7][15],pp1[8][15],pp1[9][15],pp1[10][15]);

//column 16
randm fc_25(sum2[22],sum2[23],sum2[24],ca2[57],ca2[56],ca2[55],ca2[54],ca2[53],ca2[52],ca2[51],ca2[50],ca2[49],ca2[48],ca2[47],ca2[46],ca2[45],ca2[44],
                    pp1[1][16],pp1[2][16],pp1[3][16],pp1[4][16],pp1[5][16],pp1[6][16],pp1[7][16],pp1[8][16],pp1[9][16],pp1[10][16]);

//column 17
randm fc_26(sum2[25],sum2[26],sum2[27],ca2[64],ca2[63],ca2[62],ca2[61],ca2[60],ca2[59],ca2[58],ca2[57],ca2[56],ca2[55],ca2[54],ca2[53],ca2[52],ca2[51],
                    pp1[1][17],pp1[2][17],pp1[3][17],pp1[4][17],pp1[5][17],pp1[6][17],pp1[7][17],pp1[8][17],pp1[9][17],pp1[10][17]);

//column 18
randm fc_27(sum2[28],sum2[29],sum2[30],ca2[71],ca2[70],ca2[69],ca2[68],ca2[67],ca2[66],ca2[65],ca2[64],ca2[63],ca2[62],ca2[61],ca2[60],ca2[59],ca2[58],
                    pp1[1][18],pp1[2][18],pp1[3][18],pp1[4][18],pp1[5][18],pp1[6][18],pp1[7][18],pp1[8][18],pp1[9][18],pp1[10][18]);
//column 19
randm fc_28(sum2[31],sum2[32],sum2[33],ca2[78],ca2[77],ca2[76],ca2[75],ca2[74],ca2[73],ca2[72],ca2[71],ca2[70],ca2[69],ca2[68],ca2[67],ca2[66],ca2[65],
                    pp1[1][19],pp1[2][19],pp1[3][19],pp1[4][19],pp1[5][19],pp1[6][19],pp1[7][19],pp1[8][19],pp1[9][19],pp1[10][19]);
//column 20
randm fc_29(sum2[34],sum2[35],sum2[36],ca2[85],ca2[84],ca2[83],ca2[82],ca2[81],ca2[80],ca2[79],ca2[78],ca2[77],ca2[76],ca2[75],ca2[74],ca2[73],ca2[72],
                    pp1[1][20],pp1[2][20],pp1[3][20],pp1[4][20],pp1[5][20],pp1[6][20],pp1[7][20],pp1[8][20],pp1[9][20],pp1[10][20]);
//column 21
randm fc_30(sum2[37],sum2[38],sum2[39],ca2[92],ca2[91],ca2[90],ca2[89],ca2[88],ca2[87],ca2[86],ca2[85],ca2[84],ca2[83],ca2[82],ca2[81],ca2[80],ca2[79],
                    pp1[1][21],pp1[2][21],pp1[3][21],pp1[4][21],pp1[5][21],pp1[6][21],pp1[7][21],pp1[8][21],pp1[9][21],pp1[10][21]);
//column 22
fivec fc_31(sum2[40],ca2[93],ca2[94],ca2[95],pp1[1][22],pp1[2][22],pp1[3][22],pp1[4][22],ca2[86],ca2[87],ca2[88]);
fivec fc_32(sum2[41],ca2[96],ca2[97],ca2[98],pp1[5][22],pp1[6][22],pp1[7][22],ca2[89],ca2[90],ca2[91],ca2[92]);
//column 23
fivec fc_33(sum2[42],ca2[99],ca2[100],ca2[101],pp1[1][23],pp1[2][23],pp1[3][23],pp1[4][23],ca2[93],ca2[94],ca2[95]);
fourc fc_34(sum2[43],ca2[102],ca2[103],pp1[5][23],pp1[6][23],ca2[96],ca2[97],ca2[98]);
//column 24
fourc fc_35(sum2[44],ca2[104],ca2[105],pp1[1][24],pp1[2][24],pp1[3][24],ca2[99],ca2[100]);
fourc fc_36(sum2[45],ca2[106],ca2[107],pp1[4][24],pp1[5][24],ca2[101],ca2[102],ca2[103]);
//column 25
fourc fc_37(sum2[46],ca2[108],ca2[109],pp1[1][25],pp1[2][25],ca2[104],ca2[105],ca2[106]);
fa fc_38(sum2[47],ca2[110],pp1[3][25],pp1[4][25],ca2[107]);
//column 26
fourc fc_39(sum2[48],ca2[111],ca2[112],pp1[1][26],pp1[2][26],ca2[108],ca2[109],ca2[110]);
//column 27
fa fc_40(sum2[49],ca2[113],pp1[1][27],ca2[111],ca2[112]);

always@(a or b)
    #6 begin

    begin
        for(i=1;i<=5;i+=1)
            begin
                for(j=1;j<=5;j+=1)
                    begin
                        pp2[i][j]=pp1[i][j];
                    end
            end
    end

//column 6
pp2[1][6]=sum2[1];


    begin
        for(i=3;i<=6;i+=1)
            begin
                pp2[i-1][6]=pp1[i][6];
            end
    end

//column 7
pp2[1][7]=sum2[2];


    begin
        for(i=4;i<=7;i+=1)
            begin
                pp2[i-2][7]=pp1[i][7];
            end
    end

//column 8
pp2[1][8]=sum2[3];


    begin
        for(i=5;i<=8;i+=1)
            begin
                pp2[i-3][8]=pp1[i][8];
            end
    end

//column 9
pp2[1][9]=sum2[4];
pp2[2][9]=sum2[5];


    begin
        for(i=7;i<=9;i+=1)
            begin
                pp2[i-4][9]=pp1[i][9];
            end
    end

//column10
begin
pp2[1][10]=sum2[6];
pp2[2][10]=sum2[7];
pp2[3][10]=pp1[8][10];
pp2[4][10]=pp1[9][10];
pp2[5][10]=pp1[10][10];
end

//column 11
begin
pp2[1][11]=sum2[8];
pp2[2][11]=sum2[9];
pp2[3][11]=pp1[9][11];
pp2[4][11]=pp1[10][11];
pp2[5][11]=pp1[11][11];
end

//column 12
begin
pp2[1][12]=sum2[10];
pp2[2][12]=sum2[11];
pp2[3][12]=sum2[12];
pp2[4][12]=pp1[11][12];
pp2[5][12]=pp1[12][12];
end

//column 13
begin
pp2[1][13]=sum2[13];
pp2[2][13]=sum2[14];
pp2[3][13]=sum2[15];
pp2[4][13]=pp1[11][13];
pp2[5][13]=pp1[12][13];
end

//column 14
begin
pp2[1][14]=sum2[16];
pp2[2][14]=sum2[17];
pp2[3][14]=sum2[18];
pp2[4][14]=pp1[11][14];
pp2[5][14]=pp1[12][14];
end

//column 15
begin
pp2[1][15]=sum2[19];
pp2[2][15]=sum2[20];
pp2[3][15]=sum2[21];
pp2[4][15]=pp1[11][15];
pp2[5][15]=pp1[12][15];
end

//column 16
begin
pp2[1][16]=sum2[22];
pp2[2][16]=sum2[23];
pp2[3][16]=sum2[24];
pp2[4][16]=pp1[11][16];
pp2[5][16]=pp1[12][16];
end

//column 17
begin
pp2[1][17]=sum2[25];
pp2[2][17]=sum2[26];
pp2[3][17]=sum2[27];
pp2[4][17]=pp1[11][17];
pp2[5][17]=pp1[12][17];
end

//column 18
begin
pp2[1][18]=sum2[28];
pp2[2][18]=sum2[29];
pp2[3][18]=sum2[30];
pp2[4][18]=pp1[11][18];
pp2[5][18]=pp1[12][18];
end

//column 19
begin
pp2[1][19]=sum2[31];
pp2[2][19]=sum2[32];
pp2[3][19]=sum2[33];
pp2[4][19]=pp1[11][19];
pp2[5][19]=pp1[12][19];
end

//column 20
begin
pp2[1][20]=sum2[34];
pp2[2][20]=sum2[35];
pp2[3][20]=sum2[36];
pp2[4][20]=pp1[11][20];
pp2[5][20]=pp1[12][20];
end

//column 21
begin
pp2[1][21]=sum2[37];
pp2[2][21]=sum2[38];
pp2[3][21]=sum2[39];
pp2[4][21]=pp1[11][21];
pp2[5][21]=pp1[12][21];
end

//column 22
begin
pp2[1][22]=sum2[40];
pp2[2][22]=sum2[41];
pp2[3][22]=pp1[8][22];
pp2[4][22]=pp1[9][22];
pp2[5][22]=pp1[10][22];
end

//column 23
begin
pp2[1][23]=sum2[42];
pp2[2][23]=sum2[43];
pp2[3][23]=pp1[7][23];
pp2[4][23]=pp1[8][23];
pp2[5][23]=pp1[9][23];
end

//column 24
begin
pp2[1][24]=sum2[44];
pp2[2][24]=sum2[45];
pp2[3][24]=pp1[6][24];
pp2[4][24]=pp1[7][24];
pp2[5][24]=pp1[8][24];
end

//column 25
begin
pp2[1][25]=sum2[46];
pp2[2][25]=sum2[47];
pp2[3][25]=pp1[5][25];
pp2[4][25]=pp1[6][25];
pp2[5][25]=pp1[7][25];
end

//column 26
begin
pp2[1][26]=sum2[48];
pp2[2][26]=pp1[3][26];
pp2[3][26]=pp1[4][26];
pp2[4][26]=pp1[5][26];
pp2[5][26]=pp1[6][26];
end

//column 27
begin
pp2[1][27]=sum2[49];
pp2[2][27]=pp1[2][27];
pp2[3][27]=pp1[3][27];
pp2[4][27]=pp1[4][27];
pp2[5][27]=pp1[5][27];
end

begin
pp2[1][28]=pp1[1][28];
pp2[2][28]=pp1[2][28];
pp2[3][28]=pp1[3][28];
pp2[4][28]=pp1[4][28];
pp2[5][28]=ca2[113];
end

    begin
        for(i=29;i<=31;i+=1)
            begin
                for(j=1;j<=5;j+=1)
                    begin
                        pp2[j][i]=pp1[j][i];
                    end
            end
    end

end


                                                                    // level 3(2)
wire sum3[100:1],ca3[200:1];
reg  pp3[2:1] [31:1];

ha fa_41(sum3[3],ca3[1],pp2[1][3],pp2[2][3]);
fourc fa_42(sum3[4],ca3[2],ca3[3],pp2[1][4],pp2[2][4],pp2[3][4],ca3[1],1'b0);

fivec fa_43(sum3[5],ca3[4],ca3[5],ca3[6],pp2[1][5],pp2[2][5],pp2[3][5],pp2[4][5],ca3[2],ca3[3],1'b0);
fivec fa_44(sum3[6],ca3[7],ca3[8],ca3[9],pp2[1][6],pp2[2][6],pp2[3][6],pp2[4][6],ca3[4],ca3[5],ca3[6]);
fivec fa_45(sum3[7],ca3[10],ca3[11],ca3[12],pp2[1][7],pp2[2][7],pp2[3][7],pp2[4][7],ca3[7],ca3[8],ca3[9]);
fivec fa_46(sum3[8],ca3[13],ca3[14],ca3[15],pp2[1][8],pp2[2][8],pp2[3][8],pp2[4][8],ca3[10],ca3[11],ca3[12]);
fivec fa_47(sum3[9],ca3[16],ca3[17],ca3[18],pp2[1][9],pp2[2][9],pp2[3][9],pp2[4][9],ca3[13],ca3[14],ca3[15]);
fivec fa_48(sum3[10],ca3[19],ca3[20],ca3[21],pp2[1][10],pp2[2][10],pp2[3][10],pp2[4][10],ca3[16],ca3[17],ca3[18]);

fivec fa_49(sum3[11],ca3[22],ca3[23],ca3[24],pp2[1][11],pp2[2][11],pp2[3][11],pp2[4][11],ca3[19],ca3[20],ca3[21]);
fivec fa_50(sum3[12],ca3[25],ca3[26],ca3[27],pp2[1][12],pp2[2][12],pp2[3][12],pp2[4][12],ca3[22],ca3[23],ca3[24]);
fivec fa_51(sum3[13],ca3[28],ca3[29],ca3[30],pp2[1][13],pp2[2][13],pp2[3][13],pp2[4][13],ca3[25],ca3[26],ca3[27]);
fivec fa_52(sum3[14],ca3[31],ca3[32],ca3[33],pp2[1][14],pp2[2][14],pp2[3][14],pp2[4][14],ca3[28],ca3[29],ca3[30]);
fivec fa_53(sum3[15],ca3[34],ca3[35],ca3[36],pp2[1][15],pp2[2][15],pp2[3][15],pp2[4][15],ca3[31],ca3[32],ca3[33]);
fivec fa_54(sum3[16],ca3[37],ca3[38],ca3[39],pp2[1][16],pp2[2][16],pp2[3][16],pp2[4][16],ca3[34],ca3[35],ca3[36]);

fivec fa_55(sum3[17],ca3[40],ca3[41],ca3[42],pp2[1][17],pp2[2][17],pp2[3][17],pp2[4][17],ca3[37],ca3[38],ca3[39]);
fivec fa_56(sum3[18],ca3[43],ca3[44],ca3[45],pp2[1][18],pp2[2][18],pp2[3][18],pp2[4][18],ca3[40],ca3[41],ca3[42]);
fivec fa_57(sum3[19],ca3[46],ca3[47],ca3[48],pp2[1][19],pp2[2][19],pp2[3][19],pp2[4][19],ca3[43],ca3[44],ca3[45]);
fivec fa_58(sum3[20],ca3[49],ca3[50],ca3[51],pp2[1][20],pp2[2][20],pp2[3][20],pp2[4][20],ca3[46],ca3[47],ca3[48]);
fivec fa_59(sum3[21],ca3[52],ca3[53],ca3[54],pp2[1][21],pp2[2][21],pp2[3][21],pp2[4][21],ca3[49],ca3[50],ca3[51]);
fivec fa_60(sum3[22],ca3[55],ca3[56],ca3[57],pp2[1][22],pp2[2][22],pp2[3][22],pp2[4][22],ca3[52],ca3[53],ca3[54]);

fivec fa_61(sum3[23],ca3[58],ca3[59],ca3[60],pp2[1][23],pp2[2][23],pp2[3][23],pp2[4][23],ca3[55],ca3[56],ca3[57]);
fivec fa_62(sum3[24],ca3[61],ca3[62],ca3[63],pp2[1][24],pp2[2][24],pp2[3][24],pp2[4][24],ca3[58],ca3[59],ca3[60]);
fivec fa_63(sum3[25],ca3[64],ca3[65],ca3[66],pp2[1][25],pp2[2][25],pp2[3][25],pp2[4][25],ca3[61],ca3[62],ca3[63]);
fivec fa_64(sum3[26],ca3[67],ca3[68],ca3[69],pp2[1][26],pp2[2][26],pp2[3][26],pp2[4][26],ca3[64],ca3[65],ca3[66]);
fivec fa_65(sum3[27],ca3[70],ca3[71],ca3[72],pp2[1][27],pp2[2][27],pp2[3][27],pp2[4][27],ca3[67],ca3[68],ca3[69]);
fivec fa_66(sum3[28],ca3[73],ca3[74],ca3[75],pp2[1][28],pp2[2][28],pp2[3][28],pp2[4][28],ca3[70],ca3[71],ca3[72]);

fourc fa_67(sum3[29],ca3[76],ca3[77],pp2[1][29],pp2[2][29],ca3[73],ca3[74],ca3[75]);

fa fa_68(sum3[30],ca3[78],pp2[1][30],ca3[76],ca3[77]);



always@(a or b)
 #9   begin
     begin
    pp3[1][1]=pp2[1][1];
    pp3[2][1]=pp2[2][1];
    pp3[1][2]=pp2[1][2];
    pp3[2][2]=pp2[2][2];
     end
    begin
        for(i=3;i<=30;i+=1)
            begin
                pp3[1][i]=sum3[i];
            end
        for(i=5;i<=28;i+=1)
            begin
                pp3[2][i]=pp2[5][i];
            end
        
    end


begin
pp3[2][3]=pp2[3][3];
pp3[2][4]=pp2[4][4];

pp3[2][29]=pp2[3][29];
pp3[2][30]=pp2[2][30];

pp3[1][31]=pp2[1][31];
pp3[2][31]=ca3[78];
end

end


reg [32:1] row1,row2;

always@(a or b)
    #12 begin
        row1[32]=1'b0;
        row2[32]=1'b0;
        for(i=1;i<32;i+=1)
            begin
                row1[i]=pp3[1][i];
                row2[i]=pp3[2][i];
            end
    end

wire ca_out;
wire [7:0] xout,xin;
assign xin="k";
adder add_0(c,xout,row1,row2,xin);

endmodule