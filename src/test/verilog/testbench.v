`timescale 1ns / 1ps

module testbench();
    
    reg clk, rst;
    
    initial begin
        clk = 1'b0;
    end
    
    always #10 clk = ~clk;
    
    initial begin
        rst      = 1'b1;
        #195 rst = 1'b0;
        #1000 $stop;
    end
    
    Sopc u_Sopc(
    .clock (clk),
    .reset (rst)
    );
    
    
endmodule
