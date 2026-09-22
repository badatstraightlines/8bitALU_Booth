module alu(
    input [7:0] a, b,
    input [2:0] op,
    output reg [7:0] result,
    output reg C,
    output reg Z, 
    output reg N,
    output reg V
);

    always@(*)
        begin
            C=1'b0;
            V=1'b0;

            case(op)
                3'b000:
                begin
                    {C,result} = a+b;
                    V = ( ~a[7] & ~b[7] & result[7] ) | ( a[7] & b[7] & ~result[7] );
                end
                3'b001:
                begin
                    {C,result} = a-b;
                    V = ( a[7] & ~b[7] & ~result[7] ) | ( ~a[7] & b[7] & result[7] );
                end
                3'b010: result = a & b;
                3'b011: result = a | b;
                3'b100: result = a ^ b;
                3'b101: result = ~a;
                3'b110: result = a << 1;
                3'b111: result = a >> 1;
                default: result = 8'b0;
            endcase

            Z = (result == 8'b0);
            N = result[7];
        end
endmodule


            