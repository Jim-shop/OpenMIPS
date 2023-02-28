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
    is(Params.Global.Ops.ori) {
      io.idExPort.aluOp     := Params.Alu.Ops.or
      io.idExPort.aluSel    := Params.Alu.Sel.logic
      io.idExPort.writeAddr := inst_rt
      io.idExPort.writeEn   := true.B
      io.regReads(0).en     := true.B;
      io.regReads(1).en     := false.B
      io.regReads(0).addr   := inst_rs
      io.regReads(1).addr   := inst_rt
      imm                   := inst_immediate
      instValid             := true.B
    }
  }

  for ((regOut, regRead) <- io.idExPort.regVal.zip(io.regReads)) {
    when(regRead.en) {
      when((io.exRegWrite.en) && (regRead.addr === io.exRegWrite.addr)) {
        regOut := io.exRegWrite.data
      }.elsewhen ((io.memRegWrite.en) && (regRead.addr === io.memRegWrite.addr)) {
        regOut := io.memRegWrite.data
      }.otherwise {
        regOut := regRead.data
      }
    }.otherwise {
      regOut := imm
    }
  }

}
