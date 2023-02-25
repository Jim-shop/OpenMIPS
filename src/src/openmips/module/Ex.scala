package openmips.module

import chisel3._
import chisel3.util._

import _root_.openmips.Params
import _root_.openmips.Params.Global.zeroWord
import _root_.openmips.bundle.{IdExPort, RegfileWrite}

class Ex extends Module {
  val io = IO(new Bundle {
    val idExPort = Input(new IdExPort)
    val regWrite = Output(new RegfileWrite)
  })

  val logicOut = Wire(UInt(Params.Global.Width.word))

  // fallback
  logicOut := zeroWord

  switch(io.idExPort.aluOp) {
    is(Params.Alu.Ops.or) {
      logicOut := io.idExPort.regVal(0) | io.idExPort.regVal(1)
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
  }

}
