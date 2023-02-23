package openmips.bridge

import chisel3._
import chisel3.experimental.BundleLiterals._
import chisel3.experimental.VecLiterals._
import openmips.Params
import openmips.Params.Global.zeroWord
import openmips.bundle.IdExPort

class IdToEx extends Module {
  val io = IO(new Bundle {
    val in  = Input(new IdExPort)
    val out = Output(new IdExPort)
  })

  val reg = RegNext(
    io.in,
    (new IdExPort).Lit(
      _.aluOp -> zeroWord,
      _.aluSel -> zeroWord,
      _.regVal -> Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data)).Lit(
        0 -> zeroWord,
        1 -> zeroWord
      ),
      _.writeAddr -> Params.Regfile.nopAddr,
      _.writeEn -> false.B
    )
  )

  io.out := reg
}
