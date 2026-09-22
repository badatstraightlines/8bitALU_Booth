module operand_regs(
    input clk,rst,
    input load_a,load_b,
    input [7:0] data_in_a,data_in_b,
    output reg [7:0] reg_out_a,reg_out_b
);
    always@(posedge clk) begin
        if (rst) begin
            reg_out_a <= 8'b0;
            reg_out_b <= 8'b0;
        end
        else begin
            if (load_a) begin //load_a driven by FSM
                reg_out_a <= data_in_a;
            end
            if (load_b) begin //load_b driven by FSM
                reg_out_b <= data_in_b;
            end
        end
    end
endmodule
