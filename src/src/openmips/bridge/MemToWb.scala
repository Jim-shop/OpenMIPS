package openmips.bridge

import chisel3._
import chisel3.experimental.BundleLiterals._

import openmips.Params
import openmips.bundle.RegfileWrite

class MemToWb extends Module {
  val io = IO(new Bundle {
    val in  = Input(new RegfileWrite)
    val out = Output(new RegfileWrite)
  })

  val reg = RegNext(
    io.in,
    (new RegfileWrite).Lit(
      _.en -> false.B,
      _.addr -> Params.Regfile.nopAddr,
      _.data -> Params.Global.zeroWord
    )
  )

  io.out := reg
}
