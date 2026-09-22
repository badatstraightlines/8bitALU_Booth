module register_file(
    input clk,rst,
    input write_en,
    input [1:0] write_addr,
    input [7:0] data_in,
    input [1:0] read_addr_a,read_addr_b,
    output reg [7:0] data_out_a, data_out_b
);

    reg [7:0] reg_file [0:3];
    integer i;

        // simulation only -- direct preload
    task preload(input [1:0] addr, input [7:0] data);
        reg_file[addr] = data;
    endtask
        

    always@(posedge clk)
    begin
        if (rst) begin
            for (i=0;i<4;i=i+1) begin
                reg_file[i] <= 8'b0;
            end
        end
        else if (write_en) begin
            reg_file[write_addr] <= data_in;
        end
    end

    always@(*)
    begin
        data_out_a = reg_file[read_addr_a];
        data_out_b = reg_file[read_addr_b];
    end

endmodule