module top (
    input clk, rst,
    input start,
    input [3:0] opcode,
    input [1:0] src_addr_a, src_addr_b, dst_addr,
    output [7:0] result_out,
    output [15:0] mult_result_out,
    output done
);

    // internal wires
    wire load_a, load_b;
    wire [2:0] alu_op;
    wire mult_start, mult_done;
    wire write_en, result_sel;
    wire [1:0] write_addr;

    wire [7:0] rf_data_out_a, rf_data_out_b;
    wire [7:0] op_reg_a_out, op_reg_b_out;
    wire [7:0] alu_result;
    wire alu_C, alu_Z, alu_N, alu_V;
    wire [15:0] mult_product;

    wire [7:0] writeback_data;

    // writeback mux: ALU result or lower byte of multiplier product
    assign writeback_data = result_sel ? mult_product[7:0] : alu_result;
    assign result_out     = writeback_data;
    assign mult_result_out = mult_product;

    // instantiations
    fsm_control fsm (
        .clk(clk), .rst(rst), .start(start),
        .opcode(opcode), .src_addr_a(src_addr_a),
        .src_addr_b(src_addr_b), .dst_addr(dst_addr),
        .mult_done(mult_done),
        .load_a(load_a), .load_b(load_b),
        .alu_op(alu_op), .mult_start(mult_start),
        .write_en(write_en), .write_addr(write_addr),
        .result_sel(result_sel), .done(done)
    );

    register_file rf (
        .clk(clk), .rst(rst),
        .write_en(write_en),
        .write_addr(write_addr),
        .data_in(writeback_data),
        .read_addr_a(src_addr_a),
        .read_addr_b(src_addr_b),
        .data_out_a(rf_data_out_a),
        .data_out_b(rf_data_out_b)
    );

    operand_regs op_regs (
        .clk(clk), .rst(rst),
        .load_a(load_a), .load_b(load_b),
        .data_in_a(rf_data_out_a),
        .data_in_b(rf_data_out_b),
        .reg_out_a(op_reg_a_out),
        .reg_out_b(op_reg_b_out)
    );

    alu alu_inst (
        .a(op_reg_a_out), .b(op_reg_b_out),
        .op(alu_op),
        .result(alu_result),
        .C(alu_C), .Z(alu_Z), .N(alu_N), .V(alu_V)
    );

    booth_mult mult (
        .clk(clk), .rst(rst),
        .start(mult_start),
        .multiplicand(op_reg_a_out),
        .multiplier_in(op_reg_b_out),
        .product(mult_product),
        .done(mult_done)
    );

endmodule