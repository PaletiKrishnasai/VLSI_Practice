module mux4x1(out,in0,in1,in2,in3,s1,s2);

input in0,in1,in2,in3,s1,s2;
output reg out;

always@(s1,s2,in0,in1,in2,in3)
begin
    case({s1,s2})
        2'b00:out=in0; // no change
        2'b01:out=in1; // right shift
        2'b10:out=in2; // left shift
        2'b11:out=in3; //pipo
    default out=1'bx;
    endcase
end
endmodule