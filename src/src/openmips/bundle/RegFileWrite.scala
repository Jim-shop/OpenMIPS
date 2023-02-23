package openmips.bundle

import chisel3._
import openmips.Params

class RegfileWrite extends Bundle {
  val en   = Bool()
  val addr = UInt(Params.Regfile.Width.addr)
  val data = UInt(Params.Regfile.Width.data)
}
