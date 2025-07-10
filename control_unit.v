module control_unit(
    input logic [6:0] opcode,
    output logic control_branch,
    output logic control_mem_read,
    output logic control_mem_to_reg,
    output logic [1:0] control_alu_op,
    output logic control_mem_write,
    output logic control_alu_src,
    output logic control_reg_write
);

    always_comb begin
        case (opcode)
            7'b0110011: begin // R-type
                control_alu_src = 0;
                control_mem_to_reg = 0;
                control_reg_write = 1;
                control_mem_read = 0;
                control_mem_write = 0;
                control_branch = 0;
                control_alu_op = 2'b10;
            end
            7'b0000011: begin // lw
                control_alu_src = 1;
                control_mem_to_reg = 1;
                control_reg_write = 1;
                control_mem_read = 1;
                control_mem_write = 0;
                control_branch = 0;
                control_alu_op = 2'b00;
            end
            7'b0100011: begin // sw
                control_alu_src = 1;
                control_mem_to_reg = 'x;
                control_reg_write = 0;
                control_mem_read = 0;
                control_mem_write = 1;
                control_branch = 0;
                control_alu_op = 2'b00;
            end
            7'b1100011: begin // beq
                control_alu_src = 0;
                control_mem_to_reg = 'x;
                control_reg_write = 0;
                control_mem_read = 0;
                control_mem_write = 0;
                control_branch = 1;
                control_alu_op = 2'b01;
            end
            default: begin
                control_alu_src = 0;
                control_mem_to_reg = 0;
                control_reg_write = 0;
                control_mem_read = 0;
                control_mem_write = 0;
                control_branch = 0;
                control_alu_op = 2'b00;
            end
        endcase
    end

endmodule