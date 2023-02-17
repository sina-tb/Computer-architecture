module ALU(A, B, clk, add, sub, alu_out);
  input  [4:0] A, B;
  input  clk ,add ,sub;
  output reg [4:0] alu_out;

  always@(posedge clk) begin
    if (add)
      alu_out = A + B;
    else if (sub)
      alu_out = A - B;
  end

endmodule