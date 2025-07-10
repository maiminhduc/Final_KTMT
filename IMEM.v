module IMEM(
    input logic [31:0] pc_addr,
    output logic [31:0] instruction
);

    logic [31:0] memory [0:255];

    initial begin
        $readmemh("instructions.mem", memory);
    end

    assign instruction = memory[pc_addr[9:2]];

endmodule
