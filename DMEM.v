module DMEM(
    input logic clk,
    input logic write_enable,
    input logic read_enable,
    input logic [31:0] mem_addr,
    input logic [31:0] mem_write_data,
    output logic [31:0] mem_read_data
);

    logic [31:0] data_memory [0:255];

    always_ff @(posedge clk) begin
        if (write_enable)
            data_memory[mem_addr[9:2]] <= mem_write_data;
    end

    always_comb begin
        if (read_enable)
            mem_read_data = data_memory[mem_addr[9:2]];
        else
            mem_read_data = 32'b0;
    end

endmodule