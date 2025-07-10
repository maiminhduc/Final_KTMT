module RegisterFile(
    input logic clk,
    input logic write_enable,
    input logic [4:0] read_reg1,
    input logic [4:0] read_reg2,
    input logic [4:0] write_reg,
    input logic [31:0] write_data,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

    logic [31:0] registers [31:0];

    assign read_data1 = (read_reg1 != 0) ? registers[read_reg1] : 32'b0;
    assign read_data2 = (read_reg2 != 0) ? registers[read_reg2] : 32'b0;

    always_ff @(posedge clk) begin
        if (write_enable && write_reg != 0)
            registers[write_reg] <= write_data;
    end

endmodule