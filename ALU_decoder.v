module ALU_decoder(
    input logic [1:0] alu_op,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic [3:0] alu_control_signal
);

    always_comb begin
        case (alu_op)
            2'b00: alu_control_signal = 4'b0010; // lw/sw/addi -> add
            2'b01: alu_control_signal = 4'b0110; // beq -> sub
            2'b10: begin
                case ({funct7, funct3})
                    10'b0000000_000: alu_control_signal = 4'b0010; // add
                    10'b0100000_000: alu_control_signal = 4'b0110; // sub
                    10'b0000000_111: alu_control_signal = 4'b0000; // and
                    10'b0000000_110: alu_control_signal = 4'b0001; // or
                    10'b0000000_010: alu_control_signal = 4'b0111; // slt
                    default:         alu_control_signal = 4'b0000;
                endcase
            end
            default: alu_control_signal = 4'b0000;
        endcase
    end

endmodule