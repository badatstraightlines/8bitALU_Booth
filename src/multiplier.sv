module booth_mult(
    input clk, rst,
    input start,
    input [7:0] multiplicand,
    input [7:0] multiplier_in,
    output reg [15:0] product,
    output reg done
);

    reg [7:0] M;
    reg [7:0] Q;
    reg [7:0] A;
    reg Q_m1;
    reg [3:0]  count;
    reg [1:0]  state;

    localparam IDLE = 2'b00, BUSY = 2'b01, DONE_ST = 2'b10;
    
    reg [7:0] A_next; //next state

    always@(*) begin
        case ({Q[0],Q_m1})
            2'b01: A_next = A+M;
            2'b10: A_next = A-M;
            default: A_next = A;
        endcase
    end

    always@(posedge clk) begin
        if(rst) begin
            state<=IDLE;
            M<=8'b0;A<=8'b0;Q<=8'b0;Q_m1<=1'b0;
            count<=4'b0;
            done<=1'b0;
            product<=16'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    done<=1'b0;
                    if(start) begin
                        M<=multiplicand;A<=8'b0;Q<=multiplier_in;Q_m1<=1'b0;count<=4'b0;state<=BUSY;
                    end
                end
                BUSY: begin
                    Q_m1<=Q[0];
                    Q<={A_next[0],Q[7:1]};
                    A<={A_next[7],A_next[7:1]};
                    count<=count+1;
                    if (count == 4'd7)
                        state <= DONE_ST;
                end
                DONE_ST: begin
                    product<={A,Q};
                    done<=1'b1;
                    state<=IDLE;
                end
                default: state<=IDLE;
            endcase
        end
    end
endmodule