module DMEM(
    input logic clk,
    input logic write_enable,
    input logic read_enable,
    input logic [31:0] mem_addr,
    input logic [31:0] mem_write_data,
    output logic [31:0] mem_read_data
);

    logic [31:0] memory [0:255];

    always_ff @(posedge clk) begin
        if (write_enable)
            memory[mem_addr[9:2]] <= mem_write_data;
    end

    assign mem_read_data = read_enable ? memory[mem_addr[9:2]] : 32'b0;

endmodule
