module Program_Counter(
    input logic clk,
    input logic reset_n,
    input logic [31:0] next_pc,
    output logic [31:0] current_pc
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_pc <= 32'h00000000;
        else
            current_pc <= next_pc;
    end

endmodule
