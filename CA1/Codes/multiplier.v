module multiplier(X, Y, clk, start, rst, result, Done);
  input [4:0] X, Y;
  input clk, start, rst;
  output [9:0] result;
  wire [9:0] result;
  output Done;
  
  wire ld_X, ld_Y, ld_A, ld_ff, init_A, init_ff, add, sub, shift_x, shift_a, X1, X0;
  
  datapath dp(X, Y, clk, ld_X, ld_Y, ld_A, ld_ff, init_A, init_ff, add, sub, shift_x, shift_a, result, X1, X0);
  controller cu(start, clk, X1, X0, rst, ld_X, ld_Y, ld_A, ld_ff, init_A, init_ff, add, sub, Done, shift_x, shift_a);
  
endmodule
