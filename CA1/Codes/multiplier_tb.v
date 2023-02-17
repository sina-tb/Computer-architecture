`timescale 1ns/1ns
module multiplier_tb();
  reg [4:0] X, Y;
  reg rst, start, clk;
  wire [9:0] result;
  wire Done;
  
  multiplier DUT(X, Y, clk, start, rst, result, Done);
  
initial
  begin
    repeat(15) X = $random;
    repeat(13) Y = $random;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 1;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 0;
    #100 clk = 1;
    repeat(70) #100 clk = ~clk;
    clk = 0;
    rst = 1;
    #100 clk = 1;
    #10 rst = 0;
    #90 clk = 0;
    repeat(10) X = $random;
    repeat(5) Y = $random;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 1;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 0;
    #100 clk = 1;
    repeat(70) #100 clk = ~clk;
    clk = 0;
    rst = 1;
    #100 clk = 1;
    #10 rst = 0;
    #90 clk = 0;
    repeat(3) X = $random;
    repeat(25) Y = $random;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 1;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 0;
    #100 clk = 1;
    repeat(70) #100 clk = ~clk;
    clk = 0;
    rst = 1;
    #100 clk = 1;
    #10 rst = 0;
    #90 clk = 0;
    repeat(43) X = $random;
    repeat(19) Y = $random;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 1;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 0;
    #100 clk = 1;
    repeat(70) #100 clk = ~clk;
    clk = 0;
    rst = 1;
    #100 clk = 1;
    #10 rst = 0;
    #90 clk = 0;
    repeat(8) X = $random;
    repeat(21) Y = $random;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 1;
    #100 clk = 1;
    #100 clk = 0;
    #10 start = 0;
    #100 clk = 1;
    repeat(70) #100 clk = ~clk;
    $stop;
  end

  
endmodule
