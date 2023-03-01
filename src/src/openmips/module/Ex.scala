package openmips.module

import chisel3._
import chisel3.util._

import openmips.Params
import openmips.Params.Global.zeroWord
import openmips.bundle.{IdExPort, RegfileWrite}

class Ex extends Module {
  val io = IO(new Bundle {
    val idExPort = Input(new IdExPort)
    val regWrite = Output(new RegfileWrite)
  })

  val logicOut = Wire(UInt(Params.Global.Width.word))
  val shiftOut = Wire(UInt(Params.Global.Width.word))

  // fallback
  logicOut := zeroWord
  shiftOut := zeroWord

  switch(io.idExPort.aluOp) {
    // logic
    is(Params.Alu.Ops.or) {
      logicOut := io.idExPort.regVal(0) | io.idExPort.regVal(1)
    }
    is(Params.Alu.Ops.and) {
      logicOut := io.idExPort.regVal(0) & io.idExPort.regVal(1)
    }
    is(Params.Alu.Ops.nor) {
      logicOut := ~(io.idExPort.regVal(0) | io.idExPort.regVal(1))
    }
    is(Params.Alu.Ops.xor) {
      logicOut := io.idExPort.regVal(0) ^ io.idExPort.regVal(1)
    }
  }
  switch(io.idExPort.aluOp) {
    // shift
    is(Params.Alu.Ops.sll) {
      shiftOut := io.idExPort.regVal(1) << io.idExPort.regVal(0)(4, 0)
    }
    is(Params.Alu.Ops.srl) {
      shiftOut := io.idExPort.regVal(1) >> io.idExPort.regVal(0)(4, 0)
    }
    is(Params.Alu.Ops.sra) {
      shiftOut := (io.idExPort.regVal(1).asSInt >> io.idExPort.regVal(0)(4, 0)).asUInt
    }
  }

  // fallback
  io.regWrite.en   := io.idExPort.writeEn;
  io.regWrite.addr := io.idExPort.writeAddr;
  io.regWrite.data := zeroWord;

  switch(io.idExPort.aluSel) {
    is(Params.Alu.Sel.logic) {
      io.regWrite.data := logicOut
    }
    is(Params.Alu.Sel.shift) {
      io.regWrite.data := shiftOut
    }
  }

}
