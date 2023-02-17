`define   S0      4'b0000
`define   S1      4'b0001
`define   S2      4'b0010
`define   S3      4'b0011
`define   S4      4'b0100
`define   S5      4'b0101
`define   S6      4'b0110
`define   S7      4'b0111
`define   S8      4'b1000
`define   S9      4'b1001

module controller (Start, clk, X1, X0, rst,ld_X, ld_Y, ld_A, ld_ff, init_A, init_ff, add, sub, Done, shift_x, shift_a);
  input Start, clk, X1, X0, rst;
  output reg ld_X, ld_Y, ld_A, ld_ff, init_A, init_ff, add, sub, Done, shift_x, shift_a;

  reg [3:0] ps, ns;
  wire [2:0] counter;
  reg c_up, init_cnt;

  Counter cnt(c_up, clk, init_cnt, counter);

  always @(Start, X1, X0, ps) begin
    case (ps)
      `S0 : if (Start) ns = `S1;
      `S1 : ns = `S2;
      `S2 : ns = ({X1, X0} == 2'b01) ? `S3 : ({X1, X0} == 2'b10) ? `S4 : `S7;
      `S3 : ns = `S6; 
      `S4 : ns = `S6;
      `S5 : ns = (counter >= 3'b101) ? `S0 : ({X1, X0} == 2'b01) ? `S3 : ({X1, X0} == 2'b10) ? `S4 : `S7;
      `S6 : ns = `S7;
      `S7 : ns = `S8;
      `S8 : ns = `S9;
      `S9 : ns = `S5;
      default : ns = `S0;
    endcase
  end
  
  always @(ps) begin
    {ld_X, ld_Y, ld_A, ld_ff, init_A, init_ff, add, sub, Done, shift_x, shift_a, c_up, init_cnt} = 13'b0;
    case (ps)
      `S0 : {Done, init_cnt} = 2'b11;
      `S1 : {ld_X, init_A, init_ff} = 3'b111;
      `S2 : ld_Y = 1'b1;
      `S3 : add = 1'b1;
      `S4 : sub = 1'b1;
      `S6 : ld_A = 1'b1;
      `S7 : shift_a = 1'b1;
      `S8 : shift_x = 1'b1;
      `S9 : {ld_ff, c_up} = 2'b11;
    endcase
  end

  always @(posedge clk)
    if (rst)
      ps <= 4'b0000;
    else
      ps <= ns;
  
endmodule 
