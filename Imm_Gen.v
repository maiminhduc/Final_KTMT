module Imm_Gen(
    input logic [31:0] instruction,
    output logic [31:0] imm_out
);

    logic [6:0] opcode;
    assign opcode = instruction[6:0];

    always_comb begin
        case (opcode)
            7'b0010011, 7'b0000011, 7'b1100111: // I-type
                imm_out = {{20{instruction[31]}}, instruction[31:20]};
            7'b0100011: // S-type
                imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            7'b1100011: // B-type
                imm_out = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            7'b0110111, 7'b0010111: // U-type
                imm_out = {instruction[31:12], 12'b0};
            7'b1101111: // J-type
                imm_out = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            default:
                imm_out = 32'b0;
        endcase
    end

endmodule