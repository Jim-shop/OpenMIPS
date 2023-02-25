package openmips.module

import chisel3._

import _root_.openmips.Params
import _root_.openmips.Params.Global.zeroWord
import _root_.openmips.bundle.{RegfileRead, RegfileWrite}

class Regfile extends Module {
  val io = IO(new Bundle {
    val write = Input(new RegfileWrite)
    val reads = Vec(Params.Regfile.readPortNum, new RegfileRead)
  })

  val regs: Vec[UInt] = RegInit(VecInit(Seq.fill(Params.Regfile.num)(zeroWord)))

  when(io.write.en && io.write.addr =/= Params.Regfile.nopAddr) {
    regs(io.write.addr) := io.write.data
  }

  for (read <- io.reads) {
    when(read.addr === Params.Regfile.nopAddr) {
      read.data := zeroWord
    }.elsewhen(read.addr === io.write.addr && read.en && io.write.en) {
      read.data := io.write.data;
    }.elsewhen(read.en) {
      read.data := regs(read.addr)
    }.otherwise {
      read.data := zeroWord
    }
  }

}
