package openmips.module

import chisel3._
import openmips.Params
import openmips.Params.Global.zeroWord

class Pc extends Module {
  val io = IO(new Bundle {
    val pc = Output(UInt(Params.Global.Width.addrBus))
    val ce = Output(Bool())
  })

  val pcReg = RegInit(zeroWord)
  val ceReg = RegNext(true.B, false.B)

  io.pc := pcReg
  io.ce := ceReg

  when(ceReg === false.B) {
    pcReg := 0.U
  }.otherwise {
    pcReg := pcReg + 1.U // 以字长取址
  }
}
