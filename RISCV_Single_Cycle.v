module RISCV_Single_Cycle(
    input logic clk,
    input logic rst_n,
    output logic [31:0] Instruction_out_top,
    output logic [31:0] Mem_out_top
);

    logic [31:0] pc_current, pc_next;
    logic [31:0] instruction;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] reg_data1, reg_data2, alu_operand2, write_back_data;
    logic [31:0] imm_value;
    logic [3:0] alu_ctrl;
    logic [31:0] alu_result;
    logic alu_zero;
    logic branch_taken;
    logic mem_read, mem_write;
    logic [31:0] mem_read_data;

    logic control_branch, control_mem_read, control_mem_to_reg;
    logic [1:0] control_alu_op;
    logic control_mem_write, control_alu_src, control_reg_write;

    Program_Counter pc_inst(
        .clk(clk), .reset_n(rst_n), .next_pc(pc_next), .current_pc(pc_current)
    );

    IMEM imem_inst(
        .pc_addr(pc_current), .instruction(instruction)
    );

    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];

    RegisterFile regfile_inst(
        .clk(clk),
        .write_enable(control_reg_write),
        .read_reg1(rs1), .read_reg2(rs2),
        .write_reg(rd), .write_data(write_back_data),
        .read_data1(reg_data1), .read_data2(reg_data2)
    );

    Imm_Gen immgen_inst(
        .instruction(instruction), .imm_out(imm_value)
    );

    control_unit cu_inst(
        .opcode(instruction[6:0]),
        .control_branch(control_branch),
        .control_mem_read(control_mem_read),
        .control_mem_to_reg(control_mem_to_reg),
        .control_alu_op(control_alu_op),
        .control_mem_write(control_mem_write),
        .control_alu_src(control_alu_src),
        .control_reg_write(control_reg_write)
    );

    assign alu_operand2 = control_alu_src ? imm_value : reg_data2;

    ALU_decoder aludec_inst(
        .alu_op(control_alu_op),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .alu_control_signal(alu_ctrl)
    );

    ALU alu_inst(
        .operand_a(reg_data1),
        .operand_b(alu_operand2),
        .alu_control_signal(alu_ctrl),
        .alu_result(alu_result),
        .alu_zero(alu_zero)
    );

    Branch_Comp branchcomp_inst(
        .operand_a(reg_data1), .operand_b(reg_data2),
        .branch_eq(control_branch), .branch_ne(1'b0),
        .branch_taken(branch_taken)
    );

    assign pc_next = (control_branch && branch_taken) ? pc_current + imm_value : pc_current + 4;

    DMEM dmem_inst(
        .clk(clk),
        .write_enable(control_mem_write),
        .read_enable(control_mem_read),
        .mem_addr(alu_result),
        .mem_write_data(reg_data2),
        .mem_read_data(mem_read_data)
    );

    assign write_back_data = control_mem_to_reg ? mem_read_data : alu_result;

    assign Instruction_out_top = instruction;
    assign Mem_out_top = mem_read_data;

endmodule
