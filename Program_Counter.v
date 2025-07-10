module Program_Counter(
    input logic clk,
    input logic reset,
    input logic [31:0] next_pc,
    output logic [31:0] current_pc
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_pc <= 32'h00000000;
        else
            current_pc <= next_pc;
    end

endmodule