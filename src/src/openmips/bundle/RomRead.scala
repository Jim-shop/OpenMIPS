package openmips.bundle

import chisel3._
import openmips.Params

class RomRead extends Bundle {
  val data = Output(UInt(Params.Global.Width.instBus))
  val addr = Input(UInt(Params.Global.Width.addrBus))
  val ce   = Input(Bool())
}
