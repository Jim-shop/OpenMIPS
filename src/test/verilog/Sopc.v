module Sopc(input clock,
            reset);
    
    wire [31:0] inst_addr;
    wire [31:0]       inst;
    wire rom_ce;
    Cpu u_Cpu(
    .clock               (clock),
    .reset               (reset),
    .io_romRead_data     (inst),
    .io_romRead_addr     (inst_addr),
    .io_romRead_ce       (rom_ce)
    );
    Rom u_Rom(
    .clock   (clock),
    .reset   (reset),
    .io_addr (inst_addr),
    .io_ce   (rom_ce),
    .io_data (inst)
    );
    
endmodule
    
