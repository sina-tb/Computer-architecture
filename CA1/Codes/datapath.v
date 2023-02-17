module datapath(X, Y, clk, ld_X, ld_Y, ld_A, ld_ff, init_A, init_ff, add, sub, shift_x, shift_a, result, X1, X0);
  input [4:0] X, Y;
  input clk, ld_X, ld_Y, ld_A, ld_ff, init_A, init_ff, add, sub, shift_x, shift_a;
  output reg [9:0] result;
  output X1, X0;
  wire [4:0] alu_out; 
  wire [4:0] x_out, a_out, y_out;
  wire x_co, a_co;
  
  Y_reg Yreg(Y, ld_Y, clk, y_out);
  shift_reg Areg(alu_out, a_out[4], init_A, ld_A, shift_a, clk, a_out, a_co);
  shift_reg Xreg(X, a_co, 1'b0, ld_X, shift_x, clk, x_out, x_co);
  dff X_1(x_co, init_ff, ld_ff, clk ,X0);
  ALU alu(a_out, y_out, clk, add, sub, alu_out);

  assign X1 = x_out[0];
  assign result = {a_out, x_out};

endmodule
