// Generated by CIRCT unknown git version
// Standard header to adapt well known macros to our needs.
`ifndef RANDOMIZE
  `ifdef RANDOMIZE_REG_INIT
    `define RANDOMIZE
  `endif // RANDOMIZE_REG_INIT
`endif // not def RANDOMIZE

// RANDOM may be set to an expression that produces a 32-bit random unsigned value.
`ifndef RANDOM
  `define RANDOM $random
`endif // not def RANDOM

// Users can define INIT_RANDOM as general code that gets injected into the
// initializer block for modules with registers.
`ifndef INIT_RANDOM
  `define INIT_RANDOM
`endif // not def INIT_RANDOM

// If using random initialization, you can also define RANDOMIZE_DELAY to
// customize the delay used, otherwise 0.002 is used.
`ifndef RANDOMIZE_DELAY
  `define RANDOMIZE_DELAY 0.002
`endif // not def RANDOMIZE_DELAY

// Define INIT_RANDOM_PROLOG_ for use in our modules below.
`ifndef INIT_RANDOM_PROLOG_
  `ifdef RANDOMIZE
    `ifdef VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM
    `else  // VERILATOR
      `define INIT_RANDOM_PROLOG_ `INIT_RANDOM #`RANDOMIZE_DELAY begin end
    `endif // VERILATOR
  `else  // RANDOMIZE
    `define INIT_RANDOM_PROLOG_
  `endif // RANDOMIZE
`endif // not def INIT_RANDOM_PROLOG_

module Pc(	// <stdin>:3:10
  input         clock,	// <stdin>:4:11
                reset,	// <stdin>:5:11
  output [31:0] io_pc,	// <stdin>:6:12
  output        io_ce	// <stdin>:6:12
);

  reg [31:0] pcReg;	// Pc.scala:14:22
  reg        ceReg;	// Pc.scala:15:22
  always @(posedge clock) begin	// <stdin>:4:11
    if (reset) begin	// <stdin>:4:11
      pcReg <= 32'h0;	// Pc.scala:14:22
      ceReg <= 1'h0;	// Pc.scala:15:22
    end
    else begin	// <stdin>:4:11
      if (ceReg)	// Pc.scala:15:22
        pcReg <= pcReg + 32'h1;	// Pc.scala:14:22, :23:20
      else	// Pc.scala:15:22
        pcReg <= 32'h0;	// Pc.scala:14:22
      ceReg <= 1'h1;	// Pc.scala:15:22
    end
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:3:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:3:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:3:10
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin	// <stdin>:3:10
      automatic logic [31:0] _RANDOM_0;	// <stdin>:3:10
      automatic logic [31:0] _RANDOM_1;	// <stdin>:3:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:3:10
        `INIT_RANDOM_PROLOG_	// <stdin>:3:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:3:10
        _RANDOM_0 = `RANDOM;	// <stdin>:3:10
        _RANDOM_1 = `RANDOM;	// <stdin>:3:10
        pcReg = _RANDOM_0;	// Pc.scala:14:22
        ceReg = _RANDOM_1[0];	// Pc.scala:15:22
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:3:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:3:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign io_pc = pcReg;	// <stdin>:3:10, Pc.scala:14:22
  assign io_ce = ceReg;	// <stdin>:3:10, Pc.scala:15:22
endmodule

module IfToId(	// <stdin>:24:10
  input         clock,	// <stdin>:25:11
                reset,	// <stdin>:26:11
  input  [31:0] io_in_inst,	// <stdin>:27:12
  output [31:0] io_out_inst	// <stdin>:27:12
);

  reg [31:0] reg_inst;	// IfToId.scala:14:20
  always @(posedge clock) begin	// <stdin>:25:11
    if (reset)	// <stdin>:25:11
      reg_inst <= 32'h0;	// <stdin>:30:23, IfToId.scala:14:20
    else	// <stdin>:25:11
      reg_inst <= io_in_inst;	// IfToId.scala:14:20
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:24:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:24:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:24:10
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin	// <stdin>:24:10
      automatic logic [31:0] _RANDOM_0;	// <stdin>:24:10
      automatic logic [31:0] _RANDOM_1;	// <stdin>:24:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:24:10
        `INIT_RANDOM_PROLOG_	// <stdin>:24:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:24:10
        _RANDOM_0 = `RANDOM;	// <stdin>:24:10
        _RANDOM_1 = `RANDOM;	// <stdin>:24:10
        reg_inst = _RANDOM_1;	// IfToId.scala:14:20
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:24:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:24:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign io_out_inst = reg_inst;	// <stdin>:24:10, IfToId.scala:14:20
endmodule

module Id(	// <stdin>:38:10
  input  [31:0] io_ifIdPort_inst,	// <stdin>:41:12
                io_regReads_0_data,	// <stdin>:41:12
  output        io_regReads_0_en,	// <stdin>:41:12
  output [4:0]  io_regReads_0_addr,	// <stdin>:41:12
  output [7:0]  io_idExPort_aluOp,	// <stdin>:41:12
  output [2:0]  io_idExPort_aluSel,	// <stdin>:41:12
  output [31:0] io_idExPort_regVal_0,	// <stdin>:41:12
                io_idExPort_regVal_1,	// <stdin>:41:12
  output [4:0]  io_idExPort_writeAddr,	// <stdin>:41:12
  output        io_idExPort_writeEn	// <stdin>:41:12
);

  wire _io_regReads_0_en_output = io_ifIdPort_inst[31:26] == 6'hC;	// Id.scala:43:19, package.scala:7:66
  assign io_regReads_0_en = _io_regReads_0_en_output;	// <stdin>:38:10, Id.scala:43:19
  assign io_regReads_0_addr = io_ifIdPort_inst[25:21];	// <stdin>:38:10, package.scala:7:66
  assign io_idExPort_aluOp = _io_regReads_0_en_output ? 8'h25 : 8'h0;	// <stdin>:38:10, Id.scala:32:25, :43:19, :45:29
  assign io_idExPort_aluSel = {2'h0, _io_regReads_0_en_output};	// <stdin>:38:10, Id.scala:33:25, :43:19, :46:29
  assign io_idExPort_regVal_0 = _io_regReads_0_en_output ? io_regReads_0_data : 32'h0;	// <stdin>:38:10, :41:12, Id.scala:43:19, :59:22, :60:14, :62:14
  assign io_idExPort_regVal_1 =
    _io_regReads_0_en_output ? {16'h0, io_ifIdPort_inst[15:0]} : 32'h0;	// <stdin>:38:10, :41:12, Id.scala:40:25, :43:19, :53:29, package.scala:7:66
  assign io_idExPort_writeAddr =
    _io_regReads_0_en_output ? io_ifIdPort_inst[20:16] : io_ifIdPort_inst[15:11];	// <stdin>:38:10, Id.scala:34:25, :43:19, :47:29, package.scala:7:66
  assign io_idExPort_writeEn = _io_regReads_0_en_output;	// <stdin>:38:10, Id.scala:43:19
endmodule

module IdToEx(	// <stdin>:85:10
  input         clock,	// <stdin>:86:11
                reset,	// <stdin>:87:11
  input  [7:0]  io_in_aluOp,	// <stdin>:88:12
  input  [2:0]  io_in_aluSel,	// <stdin>:88:12
  input  [31:0] io_in_regVal_0,	// <stdin>:88:12
                io_in_regVal_1,	// <stdin>:88:12
  input  [4:0]  io_in_writeAddr,	// <stdin>:88:12
  input         io_in_writeEn,	// <stdin>:88:12
  output [7:0]  io_out_aluOp,	// <stdin>:88:12
  output [2:0]  io_out_aluSel,	// <stdin>:88:12
  output [31:0] io_out_regVal_0,	// <stdin>:88:12
                io_out_regVal_1,	// <stdin>:88:12
  output [4:0]  io_out_writeAddr,	// <stdin>:88:12
  output        io_out_writeEn	// <stdin>:88:12
);

  reg [7:0]  reg_aluOp;	// IdToEx.scala:16:20
  reg [2:0]  reg_aluSel;	// IdToEx.scala:16:20
  reg [31:0] reg_regVal_0;	// IdToEx.scala:16:20
  reg [31:0] reg_regVal_1;	// IdToEx.scala:16:20
  reg [4:0]  reg_writeAddr;	// IdToEx.scala:16:20
  reg        reg_writeEn;	// IdToEx.scala:16:20
  always @(posedge clock) begin	// <stdin>:86:11
    if (reset) begin	// <stdin>:86:11
      reg_aluOp <= 8'h0;	// <stdin>:96:21, IdToEx.scala:16:20
      reg_aluSel <= 3'h0;	// <stdin>:95:22, IdToEx.scala:16:20
      reg_regVal_0 <= 32'h0;	// <stdin>:93:28, IdToEx.scala:16:20
      reg_regVal_1 <= 32'h0;	// <stdin>:93:28, IdToEx.scala:16:20
      reg_writeAddr <= 5'h0;	// <stdin>:92:28, IdToEx.scala:16:20
      reg_writeEn <= 1'h0;	// <stdin>:91:26, IdToEx.scala:16:20
    end
    else begin	// <stdin>:86:11
      reg_aluOp <= io_in_aluOp;	// IdToEx.scala:16:20
      reg_aluSel <= io_in_aluSel;	// IdToEx.scala:16:20
      reg_regVal_0 <= io_in_regVal_0;	// IdToEx.scala:16:20
      reg_regVal_1 <= io_in_regVal_1;	// IdToEx.scala:16:20
      reg_writeAddr <= io_in_writeAddr;	// IdToEx.scala:16:20
      reg_writeEn <= io_in_writeEn;	// IdToEx.scala:16:20
    end
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:85:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:85:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:85:10
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin	// <stdin>:85:10
      automatic logic [31:0] _RANDOM_0;	// <stdin>:85:10
      automatic logic [31:0] _RANDOM_1;	// <stdin>:85:10
      automatic logic [31:0] _RANDOM_2;	// <stdin>:85:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:85:10
        `INIT_RANDOM_PROLOG_	// <stdin>:85:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:85:10
        _RANDOM_0 = `RANDOM;	// <stdin>:85:10
        _RANDOM_1 = `RANDOM;	// <stdin>:85:10
        _RANDOM_2 = `RANDOM;	// <stdin>:85:10
        reg_aluOp = _RANDOM_0[7:0];	// IdToEx.scala:16:20
        reg_aluSel = _RANDOM_0[10:8];	// IdToEx.scala:16:20
        reg_regVal_0 = {_RANDOM_0[31:11], _RANDOM_1[10:0]};	// IdToEx.scala:16:20
        reg_regVal_1 = {_RANDOM_1[31:11], _RANDOM_2[10:0]};	// IdToEx.scala:16:20
        reg_writeAddr = _RANDOM_2[15:11];	// IdToEx.scala:16:20
        reg_writeEn = _RANDOM_2[16];	// IdToEx.scala:16:20
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:85:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:85:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign io_out_aluOp = reg_aluOp;	// <stdin>:85:10, IdToEx.scala:16:20
  assign io_out_aluSel = reg_aluSel;	// <stdin>:85:10, IdToEx.scala:16:20
  assign io_out_regVal_0 = reg_regVal_0;	// <stdin>:85:10, IdToEx.scala:16:20
  assign io_out_regVal_1 = reg_regVal_1;	// <stdin>:85:10, IdToEx.scala:16:20
  assign io_out_writeAddr = reg_writeAddr;	// <stdin>:85:10, IdToEx.scala:16:20
  assign io_out_writeEn = reg_writeEn;	// <stdin>:85:10, IdToEx.scala:16:20
endmodule

module Ex(	// <stdin>:107:10
  input  [7:0]  io_idExPort_aluOp,	// <stdin>:110:12
  input  [2:0]  io_idExPort_aluSel,	// <stdin>:110:12
  input  [31:0] io_idExPort_regVal_0,	// <stdin>:110:12
                io_idExPort_regVal_1,	// <stdin>:110:12
  input  [4:0]  io_idExPort_writeAddr,	// <stdin>:110:12
  input         io_idExPort_writeEn,	// <stdin>:110:12
  output        io_regWrite_en,	// <stdin>:110:12
  output [4:0]  io_regWrite_addr,	// <stdin>:110:12
  output [31:0] io_regWrite_data	// <stdin>:110:12
);

  assign io_regWrite_en = io_idExPort_writeEn;	// <stdin>:107:10
  assign io_regWrite_addr = io_idExPort_writeAddr;	// <stdin>:107:10
  assign io_regWrite_data =
    io_idExPort_aluSel == 3'h1 & io_idExPort_aluOp == 8'h25
      ? io_idExPort_regVal_0 | io_idExPort_regVal_1
      : 32'h0;	// <stdin>:107:10, Ex.scala:19:12, :21:29, :23:41, :30:20, :32:30, :34:24
endmodule

module ExToMem(	// <stdin>:126:10, :149:10
  input         clock,	// <stdin>:127:11, :150:11
                reset,	// <stdin>:128:11, :151:11
                io_in_en,	// <stdin>:129:12, :152:12
  input  [4:0]  io_in_addr,	// <stdin>:129:12, :152:12
  input  [31:0] io_in_data,	// <stdin>:129:12, :152:12
  output        io_out_en,	// <stdin>:129:12, :152:12
  output [4:0]  io_out_addr,	// <stdin>:129:12, :152:12
  output [31:0] io_out_data	// <stdin>:129:12, :152:12
);

  reg        reg_en;	// ExToMem.scala:15:20, MemToWb.scala:15:20
  reg [4:0]  reg_addr;	// ExToMem.scala:15:20, MemToWb.scala:15:20
  reg [31:0] reg_data;	// ExToMem.scala:15:20, MemToWb.scala:15:20
  always @(posedge clock) begin	// <stdin>:127:11, :150:11
    if (reset) begin	// <stdin>:127:11, :150:11
      reg_en <= 1'h0;	// <stdin>:134:21, :157:21, ExToMem.scala:15:20, MemToWb.scala:15:20
      reg_addr <= 5'h0;	// <stdin>:133:23, :156:23, ExToMem.scala:15:20, MemToWb.scala:15:20
      reg_data <= 32'h0;	// <stdin>:132:23, :155:23, ExToMem.scala:15:20, MemToWb.scala:15:20
    end
    else begin	// <stdin>:127:11, :150:11
      reg_en <= io_in_en;	// ExToMem.scala:15:20, MemToWb.scala:15:20
      reg_addr <= io_in_addr;	// ExToMem.scala:15:20, MemToWb.scala:15:20
      reg_data <= io_in_data;	// ExToMem.scala:15:20, MemToWb.scala:15:20
    end
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:126:10, :149:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:126:10, :149:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:126:10, :149:10
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin	// <stdin>:126:10, :149:10
      automatic logic [31:0] _RANDOM_0;	// <stdin>:126:10, :149:10
      automatic logic [31:0] _RANDOM_1;	// <stdin>:126:10, :149:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:126:10, :149:10
        `INIT_RANDOM_PROLOG_	// <stdin>:126:10, :149:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:126:10, :149:10
        _RANDOM_0 = `RANDOM;	// <stdin>:126:10, :149:10
        _RANDOM_1 = `RANDOM;	// <stdin>:126:10, :149:10
        reg_en = _RANDOM_0[0];	// ExToMem.scala:15:20, MemToWb.scala:15:20
        reg_addr = _RANDOM_0[5:1];	// ExToMem.scala:15:20, MemToWb.scala:15:20
        reg_data = {_RANDOM_0[31:6], _RANDOM_1[5:0]};	// ExToMem.scala:15:20, MemToWb.scala:15:20
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:126:10, :149:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:126:10, :149:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign io_out_en = reg_en;	// <stdin>:126:10, :149:10, ExToMem.scala:15:20, MemToWb.scala:15:20
  assign io_out_addr = reg_addr;	// <stdin>:126:10, :149:10, ExToMem.scala:15:20, MemToWb.scala:15:20
  assign io_out_data = reg_data;	// <stdin>:126:10, :149:10, ExToMem.scala:15:20, MemToWb.scala:15:20
endmodule

module Mem(	// <stdin>:142:10
  input         io_in_en,	// <stdin>:145:12
  input  [4:0]  io_in_addr,	// <stdin>:145:12
  input  [31:0] io_in_data,	// <stdin>:145:12
  output        io_out_en,	// <stdin>:145:12
  output [4:0]  io_out_addr,	// <stdin>:145:12
  output [31:0] io_out_data	// <stdin>:145:12
);

  assign io_out_en = io_in_en;	// <stdin>:142:10
  assign io_out_addr = io_in_addr;	// <stdin>:142:10
  assign io_out_data = io_in_data;	// <stdin>:142:10
endmodule

module Regfile(	// <stdin>:165:10
  input         clock,	// <stdin>:166:11
                reset,	// <stdin>:167:11
                io_write_en,	// <stdin>:168:12
  input  [4:0]  io_write_addr,	// <stdin>:168:12
  input  [31:0] io_write_data,	// <stdin>:168:12
  input         io_reads_0_en,	// <stdin>:168:12
  input  [4:0]  io_reads_0_addr,	// <stdin>:168:12
  output [31:0] io_reads_0_data	// <stdin>:168:12
);

  reg  [31:0]       regs_0;	// RegFile.scala:15:32
  reg  [31:0]       regs_1;	// RegFile.scala:15:32
  reg  [31:0]       regs_2;	// RegFile.scala:15:32
  reg  [31:0]       regs_3;	// RegFile.scala:15:32
  reg  [31:0]       regs_4;	// RegFile.scala:15:32
  reg  [31:0]       regs_5;	// RegFile.scala:15:32
  reg  [31:0]       regs_6;	// RegFile.scala:15:32
  reg  [31:0]       regs_7;	// RegFile.scala:15:32
  reg  [31:0]       regs_8;	// RegFile.scala:15:32
  reg  [31:0]       regs_9;	// RegFile.scala:15:32
  reg  [31:0]       regs_10;	// RegFile.scala:15:32
  reg  [31:0]       regs_11;	// RegFile.scala:15:32
  reg  [31:0]       regs_12;	// RegFile.scala:15:32
  reg  [31:0]       regs_13;	// RegFile.scala:15:32
  reg  [31:0]       regs_14;	// RegFile.scala:15:32
  reg  [31:0]       regs_15;	// RegFile.scala:15:32
  reg  [31:0]       regs_16;	// RegFile.scala:15:32
  reg  [31:0]       regs_17;	// RegFile.scala:15:32
  reg  [31:0]       regs_18;	// RegFile.scala:15:32
  reg  [31:0]       regs_19;	// RegFile.scala:15:32
  reg  [31:0]       regs_20;	// RegFile.scala:15:32
  reg  [31:0]       regs_21;	// RegFile.scala:15:32
  reg  [31:0]       regs_22;	// RegFile.scala:15:32
  reg  [31:0]       regs_23;	// RegFile.scala:15:32
  reg  [31:0]       regs_24;	// RegFile.scala:15:32
  reg  [31:0]       regs_25;	// RegFile.scala:15:32
  reg  [31:0]       regs_26;	// RegFile.scala:15:32
  reg  [31:0]       regs_27;	// RegFile.scala:15:32
  reg  [31:0]       regs_28;	// RegFile.scala:15:32
  reg  [31:0]       regs_29;	// RegFile.scala:15:32
  reg  [31:0]       regs_30;	// RegFile.scala:15:32
  reg  [31:0]       regs_31;	// RegFile.scala:15:32
  wire [31:0][31:0] _GEN =
    {{regs_31},
     {regs_30},
     {regs_29},
     {regs_28},
     {regs_27},
     {regs_26},
     {regs_25},
     {regs_24},
     {regs_23},
     {regs_22},
     {regs_21},
     {regs_20},
     {regs_19},
     {regs_18},
     {regs_17},
     {regs_16},
     {regs_15},
     {regs_14},
     {regs_13},
     {regs_12},
     {regs_11},
     {regs_10},
     {regs_9},
     {regs_8},
     {regs_7},
     {regs_6},
     {regs_5},
     {regs_4},
     {regs_3},
     {regs_2},
     {regs_1},
     {regs_0}};	// RegFile.scala:15:32, :27:17
  always @(posedge clock) begin	// <stdin>:166:11
    if (reset) begin	// <stdin>:166:11
      regs_0 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_1 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_2 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_3 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_4 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_5 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_6 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_7 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_8 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_9 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_10 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_11 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_12 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_13 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_14 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_15 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_16 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_17 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_18 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_19 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_20 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_21 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_22 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_23 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_24 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_25 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_26 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_27 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_28 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_29 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_30 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
      regs_31 <= 32'h0;	// <stdin>:168:12, RegFile.scala:15:32
    end
    else begin	// <stdin>:166:11
      automatic logic _T_1 = io_write_en & (|io_write_addr);	// RegFile.scala:17:{20,37}
      if (_T_1 & io_write_addr == 5'h0)	// RegFile.scala:15:32, :17:{20,37,65}, :18:25
        regs_0 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h1)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_1 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h2)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_2 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h3)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_3 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h4)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_4 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h5)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_5 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h6)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_6 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h7)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_7 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h8)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_8 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h9)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_9 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'hA)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_10 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'hB)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_11 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'hC)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_12 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'hD)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_13 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'hE)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_14 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'hF)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_15 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h10)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_16 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h11)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_17 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h12)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_18 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h13)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_19 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h14)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_20 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h15)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_21 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h16)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_22 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h17)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_23 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h18)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_24 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h19)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_25 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h1A)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_26 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h1B)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_27 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h1C)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_28 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h1D)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_29 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & io_write_addr == 5'h1E)	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_30 <= io_write_data;	// RegFile.scala:15:32
      if (_T_1 & (&io_write_addr))	// RegFile.scala:15:32, :17:{20,65}, :18:25
        regs_31 <= io_write_data;	// RegFile.scala:15:32
    end
  end // always @(posedge)
  `ifndef SYNTHESIS	// <stdin>:165:10
    `ifdef FIRRTL_BEFORE_INITIAL	// <stdin>:165:10
      `FIRRTL_BEFORE_INITIAL	// <stdin>:165:10
    `endif // FIRRTL_BEFORE_INITIAL
    initial begin	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_0;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_1;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_2;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_3;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_4;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_5;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_6;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_7;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_8;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_9;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_10;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_11;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_12;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_13;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_14;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_15;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_16;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_17;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_18;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_19;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_20;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_21;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_22;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_23;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_24;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_25;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_26;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_27;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_28;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_29;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_30;	// <stdin>:165:10
      automatic logic [31:0] _RANDOM_31;	// <stdin>:165:10
      `ifdef INIT_RANDOM_PROLOG_	// <stdin>:165:10
        `INIT_RANDOM_PROLOG_	// <stdin>:165:10
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT	// <stdin>:165:10
        _RANDOM_0 = `RANDOM;	// <stdin>:165:10
        _RANDOM_1 = `RANDOM;	// <stdin>:165:10
        _RANDOM_2 = `RANDOM;	// <stdin>:165:10
        _RANDOM_3 = `RANDOM;	// <stdin>:165:10
        _RANDOM_4 = `RANDOM;	// <stdin>:165:10
        _RANDOM_5 = `RANDOM;	// <stdin>:165:10
        _RANDOM_6 = `RANDOM;	// <stdin>:165:10
        _RANDOM_7 = `RANDOM;	// <stdin>:165:10
        _RANDOM_8 = `RANDOM;	// <stdin>:165:10
        _RANDOM_9 = `RANDOM;	// <stdin>:165:10
        _RANDOM_10 = `RANDOM;	// <stdin>:165:10
        _RANDOM_11 = `RANDOM;	// <stdin>:165:10
        _RANDOM_12 = `RANDOM;	// <stdin>:165:10
        _RANDOM_13 = `RANDOM;	// <stdin>:165:10
        _RANDOM_14 = `RANDOM;	// <stdin>:165:10
        _RANDOM_15 = `RANDOM;	// <stdin>:165:10
        _RANDOM_16 = `RANDOM;	// <stdin>:165:10
        _RANDOM_17 = `RANDOM;	// <stdin>:165:10
        _RANDOM_18 = `RANDOM;	// <stdin>:165:10
        _RANDOM_19 = `RANDOM;	// <stdin>:165:10
        _RANDOM_20 = `RANDOM;	// <stdin>:165:10
        _RANDOM_21 = `RANDOM;	// <stdin>:165:10
        _RANDOM_22 = `RANDOM;	// <stdin>:165:10
        _RANDOM_23 = `RANDOM;	// <stdin>:165:10
        _RANDOM_24 = `RANDOM;	// <stdin>:165:10
        _RANDOM_25 = `RANDOM;	// <stdin>:165:10
        _RANDOM_26 = `RANDOM;	// <stdin>:165:10
        _RANDOM_27 = `RANDOM;	// <stdin>:165:10
        _RANDOM_28 = `RANDOM;	// <stdin>:165:10
        _RANDOM_29 = `RANDOM;	// <stdin>:165:10
        _RANDOM_30 = `RANDOM;	// <stdin>:165:10
        _RANDOM_31 = `RANDOM;	// <stdin>:165:10
        regs_0 = _RANDOM_0;	// RegFile.scala:15:32
        regs_1 = _RANDOM_1;	// RegFile.scala:15:32
        regs_2 = _RANDOM_2;	// RegFile.scala:15:32
        regs_3 = _RANDOM_3;	// RegFile.scala:15:32
        regs_4 = _RANDOM_4;	// RegFile.scala:15:32
        regs_5 = _RANDOM_5;	// RegFile.scala:15:32
        regs_6 = _RANDOM_6;	// RegFile.scala:15:32
        regs_7 = _RANDOM_7;	// RegFile.scala:15:32
        regs_8 = _RANDOM_8;	// RegFile.scala:15:32
        regs_9 = _RANDOM_9;	// RegFile.scala:15:32
        regs_10 = _RANDOM_10;	// RegFile.scala:15:32
        regs_11 = _RANDOM_11;	// RegFile.scala:15:32
        regs_12 = _RANDOM_12;	// RegFile.scala:15:32
        regs_13 = _RANDOM_13;	// RegFile.scala:15:32
        regs_14 = _RANDOM_14;	// RegFile.scala:15:32
        regs_15 = _RANDOM_15;	// RegFile.scala:15:32
        regs_16 = _RANDOM_16;	// RegFile.scala:15:32
        regs_17 = _RANDOM_17;	// RegFile.scala:15:32
        regs_18 = _RANDOM_18;	// RegFile.scala:15:32
        regs_19 = _RANDOM_19;	// RegFile.scala:15:32
        regs_20 = _RANDOM_20;	// RegFile.scala:15:32
        regs_21 = _RANDOM_21;	// RegFile.scala:15:32
        regs_22 = _RANDOM_22;	// RegFile.scala:15:32
        regs_23 = _RANDOM_23;	// RegFile.scala:15:32
        regs_24 = _RANDOM_24;	// RegFile.scala:15:32
        regs_25 = _RANDOM_25;	// RegFile.scala:15:32
        regs_26 = _RANDOM_26;	// RegFile.scala:15:32
        regs_27 = _RANDOM_27;	// RegFile.scala:15:32
        regs_28 = _RANDOM_28;	// RegFile.scala:15:32
        regs_29 = _RANDOM_29;	// RegFile.scala:15:32
        regs_30 = _RANDOM_30;	// RegFile.scala:15:32
        regs_31 = _RANDOM_31;	// RegFile.scala:15:32
      `endif // RANDOMIZE_REG_INIT
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL	// <stdin>:165:10
      `FIRRTL_AFTER_INITIAL	// <stdin>:165:10
    `endif // FIRRTL_AFTER_INITIAL
  `endif // not def SYNTHESIS
  assign io_reads_0_data =
    io_reads_0_addr == 5'h0
      ? 32'h0
      : io_reads_0_addr == io_write_addr & io_reads_0_en & io_write_en
          ? io_write_data
          : io_reads_0_en ? _GEN[io_reads_0_addr] : 32'h0;	// <stdin>:165:10, :168:12, RegFile.scala:17:37, :22:{20,48}, :23:17, :24:{26,55,71}, :25:17, :26:25, :27:17, :29:17
endmodule

module Cpu(	// <stdin>:239:10
  input         clock,	// <stdin>:240:11
                reset,	// <stdin>:241:11
  input  [31:0] io_romRead_data,	// <stdin>:242:12
  output [31:0] io_romRead_addr,	// <stdin>:242:12
  output        io_romRead_ce,	// <stdin>:242:12
  output [31:0] io_debugPort_ifInst,	// <stdin>:242:12
                io_debugPort_wb	// <stdin>:242:12
);

  wire [31:0] _regfile_io_reads_0_data;	// Cpu.scala:44:23
  wire        _memToWb_io_out_en;	// Cpu.scala:41:23
  wire [4:0]  _memToWb_io_out_addr;	// Cpu.scala:41:23
  wire [31:0] _memToWb_io_out_data;	// Cpu.scala:41:23
  wire        _mem_io_out_en;	// Cpu.scala:38:19
  wire [4:0]  _mem_io_out_addr;	// Cpu.scala:38:19
  wire [31:0] _mem_io_out_data;	// Cpu.scala:38:19
  wire        _exToMem_io_out_en;	// Cpu.scala:35:23
  wire [4:0]  _exToMem_io_out_addr;	// Cpu.scala:35:23
  wire [31:0] _exToMem_io_out_data;	// Cpu.scala:35:23
  wire        _ex_io_regWrite_en;	// Cpu.scala:32:18
  wire [4:0]  _ex_io_regWrite_addr;	// Cpu.scala:32:18
  wire [31:0] _ex_io_regWrite_data;	// Cpu.scala:32:18
  wire [7:0]  _idToEx_io_out_aluOp;	// Cpu.scala:29:22
  wire [2:0]  _idToEx_io_out_aluSel;	// Cpu.scala:29:22
  wire [31:0] _idToEx_io_out_regVal_0;	// Cpu.scala:29:22
  wire [31:0] _idToEx_io_out_regVal_1;	// Cpu.scala:29:22
  wire [4:0]  _idToEx_io_out_writeAddr;	// Cpu.scala:29:22
  wire        _idToEx_io_out_writeEn;	// Cpu.scala:29:22
  wire        _id_io_regReads_0_en;	// Cpu.scala:26:18
  wire [4:0]  _id_io_regReads_0_addr;	// Cpu.scala:26:18
  wire [7:0]  _id_io_idExPort_aluOp;	// Cpu.scala:26:18
  wire [2:0]  _id_io_idExPort_aluSel;	// Cpu.scala:26:18
  wire [31:0] _id_io_idExPort_regVal_0;	// Cpu.scala:26:18
  wire [31:0] _id_io_idExPort_regVal_1;	// Cpu.scala:26:18
  wire [4:0]  _id_io_idExPort_writeAddr;	// Cpu.scala:26:18
  wire        _id_io_idExPort_writeEn;	// Cpu.scala:26:18
  wire [31:0] _ifToId_io_out_inst;	// Cpu.scala:22:22
  Pc pc (	// Cpu.scala:18:18
    .clock (clock),
    .reset (reset),
    .io_pc (io_romRead_addr),
    .io_ce (io_romRead_ce)
  );
  IfToId ifToId (	// Cpu.scala:22:22
    .clock       (clock),
    .reset       (reset),
    .io_in_inst  (io_romRead_data),
    .io_out_inst (_ifToId_io_out_inst)
  );
  Id id (	// Cpu.scala:26:18
    .io_ifIdPort_inst      (_ifToId_io_out_inst),	// Cpu.scala:22:22
    .io_regReads_0_data    (_regfile_io_reads_0_data),	// Cpu.scala:44:23
    .io_regReads_0_en      (_id_io_regReads_0_en),
    .io_regReads_0_addr    (_id_io_regReads_0_addr),
    .io_idExPort_aluOp     (_id_io_idExPort_aluOp),
    .io_idExPort_aluSel    (_id_io_idExPort_aluSel),
    .io_idExPort_regVal_0  (_id_io_idExPort_regVal_0),
    .io_idExPort_regVal_1  (_id_io_idExPort_regVal_1),
    .io_idExPort_writeAddr (_id_io_idExPort_writeAddr),
    .io_idExPort_writeEn   (_id_io_idExPort_writeEn)
  );
  IdToEx idToEx (	// Cpu.scala:29:22
    .clock            (clock),
    .reset            (reset),
    .io_in_aluOp      (_id_io_idExPort_aluOp),	// Cpu.scala:26:18
    .io_in_aluSel     (_id_io_idExPort_aluSel),	// Cpu.scala:26:18
    .io_in_regVal_0   (_id_io_idExPort_regVal_0),	// Cpu.scala:26:18
    .io_in_regVal_1   (_id_io_idExPort_regVal_1),	// Cpu.scala:26:18
    .io_in_writeAddr  (_id_io_idExPort_writeAddr),	// Cpu.scala:26:18
    .io_in_writeEn    (_id_io_idExPort_writeEn),	// Cpu.scala:26:18
    .io_out_aluOp     (_idToEx_io_out_aluOp),
    .io_out_aluSel    (_idToEx_io_out_aluSel),
    .io_out_regVal_0  (_idToEx_io_out_regVal_0),
    .io_out_regVal_1  (_idToEx_io_out_regVal_1),
    .io_out_writeAddr (_idToEx_io_out_writeAddr),
    .io_out_writeEn   (_idToEx_io_out_writeEn)
  );
  Ex ex (	// Cpu.scala:32:18
    .io_idExPort_aluOp     (_idToEx_io_out_aluOp),	// Cpu.scala:29:22
    .io_idExPort_aluSel    (_idToEx_io_out_aluSel),	// Cpu.scala:29:22
    .io_idExPort_regVal_0  (_idToEx_io_out_regVal_0),	// Cpu.scala:29:22
    .io_idExPort_regVal_1  (_idToEx_io_out_regVal_1),	// Cpu.scala:29:22
    .io_idExPort_writeAddr (_idToEx_io_out_writeAddr),	// Cpu.scala:29:22
    .io_idExPort_writeEn   (_idToEx_io_out_writeEn),	// Cpu.scala:29:22
    .io_regWrite_en        (_ex_io_regWrite_en),
    .io_regWrite_addr      (_ex_io_regWrite_addr),
    .io_regWrite_data      (_ex_io_regWrite_data)
  );
  ExToMem exToMem (	// Cpu.scala:35:23
    .clock       (clock),
    .reset       (reset),
    .io_in_en    (_ex_io_regWrite_en),	// Cpu.scala:32:18
    .io_in_addr  (_ex_io_regWrite_addr),	// Cpu.scala:32:18
    .io_in_data  (_ex_io_regWrite_data),	// Cpu.scala:32:18
    .io_out_en   (_exToMem_io_out_en),
    .io_out_addr (_exToMem_io_out_addr),
    .io_out_data (_exToMem_io_out_data)
  );
  Mem mem (	// Cpu.scala:38:19
    .io_in_en    (_exToMem_io_out_en),	// Cpu.scala:35:23
    .io_in_addr  (_exToMem_io_out_addr),	// Cpu.scala:35:23
    .io_in_data  (_exToMem_io_out_data),	// Cpu.scala:35:23
    .io_out_en   (_mem_io_out_en),
    .io_out_addr (_mem_io_out_addr),
    .io_out_data (_mem_io_out_data)
  );
  ExToMem memToWb (	// Cpu.scala:41:23
    .clock       (clock),
    .reset       (reset),
    .io_in_en    (_mem_io_out_en),	// Cpu.scala:38:19
    .io_in_addr  (_mem_io_out_addr),	// Cpu.scala:38:19
    .io_in_data  (_mem_io_out_data),	// Cpu.scala:38:19
    .io_out_en   (_memToWb_io_out_en),
    .io_out_addr (_memToWb_io_out_addr),
    .io_out_data (_memToWb_io_out_data)
  );
  Regfile regfile (	// Cpu.scala:44:23
    .clock           (clock),
    .reset           (reset),
    .io_write_en     (_memToWb_io_out_en),	// Cpu.scala:41:23
    .io_write_addr   (_memToWb_io_out_addr),	// Cpu.scala:41:23
    .io_write_data   (_memToWb_io_out_data),	// Cpu.scala:41:23
    .io_reads_0_en   (_id_io_regReads_0_en),	// Cpu.scala:26:18
    .io_reads_0_addr (_id_io_regReads_0_addr),	// Cpu.scala:26:18
    .io_reads_0_data (_regfile_io_reads_0_data)
  );
  assign io_debugPort_ifInst = io_romRead_data;	// <stdin>:239:10
  assign io_debugPort_wb = _memToWb_io_out_data;	// <stdin>:239:10, Cpu.scala:41:23
endmodule
