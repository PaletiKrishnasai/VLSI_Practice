module fulladder(a,b,cin,sum,cout);

input a,b,cin;
output sum,cout;
wire w1,w2,w3;
xor XOR2_1(sum,a,b,cin);
and AND2_1(w1,a,b);
and AND2_2(w2,b,cin);
and AND2_3(w3,a,cin);
or OR2_1(cout,w1,w2,w3);

    
endmodule