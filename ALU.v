module ALU(
    input logic [31:0] operand_a,
    input logic [31:0] operand_b,
    input logic [3:0] alu_control_signal,
    output logic [31:0] alu_result,
    output logic alu_zero
);

    always_comb begin
        case (alu_control_signal)
            4'b0000: alu_result = operand_a & operand_b;
            4'b0001: alu_result = operand_a | operand_b;
            4'b0010: alu_result = operand_a + operand_b;
            4'b0110: alu_result = operand_a - operand_b;
            4'b0111: alu_result = (operand_a < operand_b) ? 1 : 0;
            4'b1100: alu_result = ~(operand_a | operand_b);
            default: alu_result = 32'b0;
        endcase
    end

    assign alu_zero = (alu_result == 32'b0);

endmodule