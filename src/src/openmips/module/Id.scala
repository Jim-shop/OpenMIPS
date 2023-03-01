package openmips.module

import chisel3._
import chisel3.util._

import openmips.Params
import openmips.Params.Global.zeroWord
import openmips.Utils.getBits
import openmips.bundle.{IdExPort, IfIdPort, RegfileRead, RegfileWrite}

class Id extends Module {
  val io = IO(new Bundle {
    val ifIdPort    = Input(new IfIdPort)
    val regReads    = Vec(Params.Regfile.readPortNum, Flipped(new RegfileRead))
    val idExPort    = Output(new IdExPort)
    val exRegWrite  = Input(new RegfileWrite)
    val memRegWrite = Input(new RegfileWrite)
  })

  // parse inst
  val inst_op        = getBits(io.ifIdPort.inst, Params.Global.Range.op)
  val inst_address   = getBits(io.ifIdPort.inst, Params.Global.Range.address)
  val inst_rs        = getBits(io.ifIdPort.inst, Params.Global.Range.rs)
  val inst_rt        = getBits(io.ifIdPort.inst, Params.Global.Range.rt)
  val inst_immediate = getBits(io.ifIdPort.inst, Params.Global.Range.immediate)
  val inst_rd        = getBits(io.ifIdPort.inst, Params.Global.Range.rd)
  val inst_sa        = getBits(io.ifIdPort.inst, Params.Global.Range.sa)
  val inst_func      = getBits(io.ifIdPort.inst, Params.Global.Range.func)

  val imm       = Wire(UInt(Params.Global.Width.word))
  val instValid = Wire(Bool())

  // fallback
  io.idExPort.aluOp     := Params.Alu.Ops.nop
  io.idExPort.aluSel    := Params.Alu.Sel.nop
  io.idExPort.writeAddr := inst_rd
  io.idExPort.writeEn   := false.B
  io.regReads(0).en     := false.B
  io.regReads(1).en     := false.B
  io.regReads(0).addr   := inst_rs
  io.regReads(1).addr   := inst_rt
  imm                   := zeroWord
  instValid             := false.B

  switch(inst_op) {
    is(Params.Global.Ops.special) {
      switch(inst_sa) {
        is("b00000".U(5.W)) {
          switch(inst_func) {
            is(Params.Global.Ops.or) {
              io.idExPort.aluOp  := Params.Alu.Ops.or
              io.idExPort.aluSel := Params.Alu.Sel.logic
              // io.idExPort.writeAddr := inst_rd
              io.idExPort.writeEn := true.B
              io.regReads(0).en  := true.B
              io.regReads(1).en  := true.B
              // io.regReads(0).addr   := inst_rs
              // io.regReads(1).addr   := inst_rt
              // imm                   := zeroWord
              instValid := true.B
            }
            is(Params.Global.Ops.and) {
              io.idExPort.aluOp  := Params.Alu.Ops.and
              io.idExPort.aluSel := Params.Alu.Sel.logic
              // io.idExPort.writeAddr := inst_rd
              io.idExPort.writeEn := true.B
              io.regReads(0).en  := true.B
              io.regReads(1).en  := true.B
              // io.regReads(0).addr   := inst_rs
              // io.regReads(1).addr   := inst_rt
              // imm                   := zeroWord
              instValid := true.B
            }
            is(Params.Global.Ops.xor) {
              io.idExPort.aluOp  := Params.Alu.Ops.xor
              io.idExPort.aluSel := Params.Alu.Sel.logic
              // io.idExPort.writeAddr := inst_rd
              io.idExPort.writeEn := true.B
              io.regReads(0).en  := true.B
              io.regReads(1).en  := true.B
              // io.regReads(0).addr   := inst_rs
              // io.regReads(1).addr   := inst_rt
              // imm                   := zeroWord
              instValid := true.B
            }
            is(Params.Global.Ops.nor) {
              io.idExPort.aluOp  := Params.Alu.Ops.nor
              io.idExPort.aluSel := Params.Alu.Sel.logic
              // io.idExPort.writeAddr := inst_rd
              io.idExPort.writeEn := true.B
              io.regReads(0).en  := true.B
              io.regReads(1).en  := true.B
              // io.regReads(0).addr   := inst_rs
              // io.regReads(1).addr   := inst_rt
              // imm                   := zeroWord
              instValid := true.B
            }
            is(Params.Global.Ops.sllv) {
              io.idExPort.aluOp  := Params.Alu.Ops.sll
              io.idExPort.aluSel := Params.Alu.Sel.shift
              // io.idExPort.writeAddr := inst_rd
              io.idExPort.writeEn := true.B
              io.regReads(0).en  := true.B
              io.regReads(1).en  := true.B
              // io.regReads(0).addr   := inst_rs
              // io.regReads(1).addr   := inst_rt
              // imm                   := zeroWord
              instValid := true.B
            }
            is(Params.Global.Ops.srlv) {
              io.idExPort.aluOp  := Params.Alu.Ops.srl
              io.idExPort.aluSel := Params.Alu.Sel.shift
              // io.idExPort.writeAddr := inst_rd
              io.idExPort.writeEn := true.B
              io.regReads(0).en  := true.B
              io.regReads(1).en  := true.B
              // io.regReads(0).addr   := inst_rs
              // io.regReads(1).addr   := inst_rt
              // imm                   := zeroWord
              instValid := true.B
            }
            is(Params.Global.Ops.srav) {
              io.idExPort.aluOp  := Params.Alu.Ops.sra
              io.idExPort.aluSel := Params.Alu.Sel.shift
              // io.idExPort.writeAddr := inst_rd
              io.idExPort.writeEn := true.B
              io.regReads(0).en  := true.B
              io.regReads(1).en  := true.B
              // io.regReads(0).addr   := inst_rs
              // io.regReads(1).addr   := inst_rt
              // imm                   := zeroWord
              instValid := true.B
            }
            is(Params.Global.Ops.sync) {
              io.idExPort.aluOp  := Params.Alu.Ops.nop
              io.idExPort.aluSel := Params.Alu.Sel.nop
              // io.idExPort.writeAddr := inst_rd
              io.idExPort.writeEn := false.B
              io.regReads(0).en  := false.B
              io.regReads(1).en  := true.B
              // io.regReads(0).addr   := inst_rs
              // io.regReads(1).addr   := inst_rt
              // imm                   := zeroWord
              instValid := true.B
            }
          }
        }
      }
    }
    is(Params.Global.Ops.ori) {
      io.idExPort.aluOp     := Params.Alu.Ops.or
      io.idExPort.aluSel    := Params.Alu.Sel.logic
      io.idExPort.writeAddr := inst_rt
      io.idExPort.writeEn   := true.B
      io.regReads(0).en     := true.B;
      io.regReads(1).en     := false.B
      // io.regReads(0).addr   := inst_rs
      // io.regReads(1).addr   := inst_rt
      imm       := inst_immediate
      instValid := true.B
    }
    is(Params.Global.Ops.andi) {
      io.idExPort.aluOp     := Params.Alu.Ops.and
      io.idExPort.aluSel    := Params.Alu.Sel.logic
      io.idExPort.writeAddr := inst_rt
      io.idExPort.writeEn   := true.B
      io.regReads(0).en     := true.B;
      io.regReads(1).en     := false.B
      // io.regReads(0).addr   := inst_rs
      // io.regReads(1).addr   := inst_rt
      imm       := inst_immediate
      instValid := true.B
    }
    is(Params.Global.Ops.xori) {
      io.idExPort.aluOp     := Params.Alu.Ops.xor
      io.idExPort.aluSel    := Params.Alu.Sel.logic
      io.idExPort.writeAddr := inst_rt
      io.idExPort.writeEn   := true.B
      io.regReads(0).en     := true.B;
      io.regReads(1).en     := false.B
      // io.regReads(0).addr   := inst_rs
      // io.regReads(1).addr   := inst_rt
      imm       := inst_immediate
      instValid := true.B
    }
    is(Params.Global.Ops.lui) {
      io.idExPort.aluOp     := Params.Alu.Ops.or
      io.idExPort.aluSel    := Params.Alu.Sel.logic
      io.idExPort.writeAddr := inst_rt
      io.idExPort.writeEn   := true.B
      io.regReads(0).en     := true.B;
      io.regReads(1).en     := false.B
      // io.regReads(0).addr   := inst_rs
      // io.regReads(1).addr   := inst_rt
      imm       := Cat(inst_immediate, 0.U(16.W))
      instValid := true.B
    }
    is(Params.Global.Ops.pref) {
      io.idExPort.aluOp     := Params.Alu.Ops.nop
      io.idExPort.aluSel    := Params.Alu.Sel.nop
      io.idExPort.writeAddr := inst_rt
      io.idExPort.writeEn   := false.B
      io.regReads(0).en     := false.B;
      io.regReads(1).en     := false.B
      // io.regReads(0).addr   := inst_rs
      // io.regReads(1).addr   := inst_rt
      imm       := inst_immediate
      instValid := true.B
    }
  }
  when(getBits(io.ifIdPort.inst, (31, 21)) === 0.U(11.W)) {
    switch(inst_func) {
      is(Params.Global.Ops.sll) {
        io.idExPort.aluOp     := Params.Alu.Ops.sll
        io.idExPort.aluSel    := Params.Alu.Sel.shift
        io.idExPort.writeAddr := inst_rd
        io.idExPort.writeEn    := true.B
        io.regReads(0).en      := false.B
        io.regReads(1).en      := true.B
        // io.regReads(0).addr   := inst_rs
        // io.regReads(1).addr   := inst_rt
        imm       := inst_sa
        instValid := true.B
      }
      is(Params.Global.Ops.srl) {
        io.idExPort.aluOp     := Params.Alu.Ops.srl
        io.idExPort.aluSel    := Params.Alu.Sel.shift
        io.idExPort.writeAddr := inst_rd
        io.idExPort.writeEn     := true.B
        io.regReads(0).en      := false.B
        io.regReads(1).en      := true.B
        // io.regReads(0).addr   := inst_rs
        // io.regReads(1).addr   := inst_rt
        imm       := inst_sa
        instValid := true.B
      }
      is(Params.Global.Ops.sra) {
        io.idExPort.aluOp     := Params.Alu.Ops.sra
        io.idExPort.aluSel    := Params.Alu.Sel.shift
        io.idExPort.writeAddr := inst_rd
        io.idExPort.writeEn     := true.B
        io.regReads(0).en      := false.B
        io.regReads(1).en      := true.B
        // io.regReads(0).addr   := inst_rs
        // io.regReads(1).addr   := inst_rt
        imm       := inst_sa
        instValid := true.B
      }
    }
  }

  for ((regOut, regRead) <- io.idExPort.regVal.zip(io.regReads)) {
    when(regRead.en) {
      when((io.exRegWrite.en) && (regRead.addr === io.exRegWrite.addr)) {
        regOut := io.exRegWrite.data
      }.elsewhen((io.memRegWrite.en) && (regRead.addr === io.memRegWrite.addr)) {
        regOut := io.memRegWrite.data
      }.otherwise {
        regOut := regRead.data
      }
    }.otherwise {
      regOut := imm
    }
  }
}
