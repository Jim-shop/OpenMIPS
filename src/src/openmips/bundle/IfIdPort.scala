package openmips.bundle

import chisel3._
import openmips.Params

class IfIdPort extends Bundle {
  val pc   = UInt(Params.Global.Width.addrBus)
  val inst = UInt(Params.Global.Width.instBus)
}
