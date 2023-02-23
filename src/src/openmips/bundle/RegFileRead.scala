package openmips.bundle

import chisel3._
import openmips.Params

class RegfileRead extends Bundle {
  val en   = Input(Bool())
  val addr = Input(UInt(Params.Regfile.Width.addr))
  val data = Output(UInt(Params.Regfile.Width.data))
}
