module IMEM(
    input logic [31:0] pc_addr,
    output logic [31:0] instruction
);

    logic [31:0] instr_memory [0:255];

    initial begin
        $readmemh("instructions.mem", instr_memory);
    end

    assign instruction = instr_memory[pc_addr[9:2]];

endmodule