package openmips.bundle

import chisel3._
import openmips.Params

class IdExPort extends Bundle {
  val aluOp     = UInt(Params.Alu.Width.op)
  val aluSel    = UInt(Params.Alu.Width.sel)
  val regVal    = Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data))
  val writeAddr = UInt(Params.Regfile.Width.addr)
  val writeEn   = Bool()
}
