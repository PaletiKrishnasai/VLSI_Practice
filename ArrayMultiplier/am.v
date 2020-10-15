`include "FullAdder.v"

module array(a,b,p);

parameter N = 16;
parameter M = 16;

input [N-1:0] a;
input [M-1:0] b;
output [M+N-1:0] p;

genvar i,j;
generate
    wire [M*N-1:0] w;
    for(i=0;i<M;i=i+1)
    begin :loop1
    
    for(j=0;j<N;j=j+1)
    begin :loop2
        and(w[i*N+j],a[j],b[i]);
    end
    
    end
 
endgenerate


//assign p[0] = w[0]; // first bit of 1st partial product


// 0-15 : b0
// 16-31 :b1
// 32-47 :b2
// 47-63 :b3
// 64-79 :b4
// 80-95 :b5
// 96-111 :b6
// 112-127 :b7
// 128-143 :b8
// 144-159 :b9
// 160-175 :b10
// 176-191 :b11
// 192-207 :b12
// 208-223 :b13
// 224-239 :b14
// 240-255 :b15

genvar k;



generate
   
    
    for(k=1;k<N;k=k+1)
    begin: S
    wire [31:0] sum1,sum2,sout,temp;
    wire cout,cin;
    if(k==1)
        begin
            assign sum1=w[N-1:0];
            assign sum2={w[(2*N)-1:N],1'b0};
            FullAdder32bit FA(sum1,sum2,1'b0,sout,cout);
            assign cin=cout;
        end
    else
        begin
            assign sum1=S[k-1].sout;
            assign temp=w[((k+1)*N)-1:(k)*N];
            assign sum2=temp<<k;
            FullAdder32bit FA(sum1,sum2,S[k-1].cin,sout,cout);
            assign cin=cout;

            if(k==N-1)
                begin
                    assign p=sout;
                end
        end
    end

    
endgenerate

endmodule


module FullAdder4bit(A,B,Cin,Sum,Cout);

 	input [3:0]A,B;
    input Cin;
    output [3:0]Sum;
    output Cout;

	wire carry0;
	wire carry1;
	wire carry2;

FullAdder FA0(A[0],B[0],Cin,Sum[0],carry0);
FullAdder FA1(A[1],B[1],carry0,Sum[1],carry1);
FullAdder FA2(A[2],B[2],carry1,Sum[2],carry2);
FullAdder FA3(A[3],B[3],carry2,Sum[3],Cout);


endmodule



module FullAdder16bit(A,B,Cin,Sum,Cout);

    input [15:0]A,B;
    input Cin;
    output[15:0]Sum;
    output Cout;
    

	wire carry3;
	wire carry7;
	wire carry11;
	
FullAdder4bit FA40(
	A[3:0],
	B[3:0],
	Cin,
	Sum[3:0],
	carry3
);

FullAdder4bit FA41(
	A[7:4],
	B[7:4],
	carry3,
	Sum[7:4],
	carry7
);

FullAdder4bit FA42(
	A[11:8],
	B[11:8],
	carry7,
	Sum[11:8],
	carry11
);

FullAdder4bit FA43(
	A[15:12],
	B[15:12],
	carry11,
	Sum[15:12],
	Cout
);


endmodule

module FullAdder32bit(
    input [31:0]A,B,
    input Cin,
    output [31:0]Sum,
    output Cout
    );
	 
	 wire carry15;
	 
FullAdder16bit FA160(
	.A(A[15:0]),
	.B(B[15:0]),
	.Cin(Cin),
	.Sum(Sum[15:0]),
	.Cout(carry15)
);

FullAdder16bit FA161(
	.A(A[31:16]),
	.B(B[31:16]),
	.Cin(carry15),
	.Sum(Sum[31:16]),
	.Cout(Cout)
);
	 


endmodule