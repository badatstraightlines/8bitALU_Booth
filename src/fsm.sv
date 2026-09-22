module fsm_control(
    input clk,rst,
    input start,
    input [3:0] opcode,
    input [1:0] src_addr_a, src_addr_b,dst_addr,
    input mult_done,
    output reg load_a, load_b,
    output reg [2:0] alu_op,
    output reg mult_start,
    output reg write_en,
    output reg [1:0] write_addr,
    output reg result_sel,   // 0 = ALU result, 1 = multiplier product
    output reg done
);

    localparam IDLE       = 3'b000,
               DECODE     = 3'b001,
               EXECUTE    = 3'b010,
               MULT_START = 3'b011,
               MULT_WAIT  = 3'b100,
               WRITEBACK  = 3'b101,
               DONE_ST    = 3'b110;

    localparam MUL_OP = 4'b1000;

    reg [2:0] state;
    reg [3:0] opcode_reg;
    reg [1:0] dst_addr_reg;

    always@(posedge clk) begin
        if (rst) begin
            state<=IDLE;
        end
        else begin
            case (state)
                IDLE: state<=start ? DECODE : IDLE;
                DECODE: state<=(opcode_reg == MUL_OP) ? MULT_START : EXECUTE;
                EXECUTE: state<=WRITEBACK;
                MULT_START: state<=MULT_WAIT;
                MULT_WAIT: state<=mult_done ? WRITEBACK : MULT_WAIT;
                WRITEBACK: state<=DONE_ST;
                DONE_ST: state<=IDLE;
                default: state<=IDLE;
            endcase
        end
    end

     // latch opcode and dst_addr at DECODE so they're stable through execution
    always @(posedge clk) begin
        if (rst) begin
            opcode_reg<=4'b0;
            dst_addr_reg<=2'b0;
        end 
        else if (state == IDLE && start) begin
            opcode_reg<=opcode;
            dst_addr_reg<=dst_addr;
        end
    end

    always@(*) begin
        load_a = 1'b0;
        load_b = 1'b0;
        //alu_op = 3'b000;
        mult_start = 1'b0;
        write_en = 1'b0;
        write_addr = 2'b00;
        //result_sel = 1'b0;
        done = 1'b0;
        alu_op = opcode_reg[2:0]; 
        result_sel = (opcode_reg == MUL_OP) ? 1'b1 : 1'b0;

        case (state)
            IDLE: 
            begin
                // wait till start signal
            end

            DECODE:
            begin
                load_a=1'b1;
                load_b=1'b1;
            end

            EXECUTE:
            begin
                //now the new default will handle the opcode value directly from original opcode reg
            end

            MULT_START:
            begin
                mult_start=1'b1;
            end

            MULT_WAIT:
            begin
                //wait till mult_done = 1'b1
            end

            WRITEBACK: 
            begin
                write_en=1'b1;
                write_addr=dst_addr_reg;
                
            end

            DONE_ST: 
            begin
                done=1'b1;
            end
        endcase
    end
endmodule

