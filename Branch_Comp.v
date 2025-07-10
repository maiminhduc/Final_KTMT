module Branch_Comp(
    input logic [31:0] operand_a,
    input logic [31:0] operand_b,
    input logic branch_eq,
    input logic branch_ne,
    output logic branch_taken
);

    always_comb begin
        if (branch_eq)
            branch_taken = (operand_a == operand_b);
        else if (branch_ne)
            branch_taken = (operand_a != operand_b);
        else
            branch_taken = 0;
    end

endmodule