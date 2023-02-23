package openmips.bridge

import chisel3._
import chisel3.experimental.BundleLiterals._
import openmips.Params.Global.zeroWord
import openmips.bundle.IfIdPort

class IfToId extends Module {
  val io = IO(new Bundle {
    val in  = Input(new IfIdPort)
    val out = Output(new IfIdPort)
  })

  val reg = RegNext(io.in, (new IfIdPort).Lit(_.pc -> zeroWord, _.inst -> zeroWord))

  io.out := reg
}
