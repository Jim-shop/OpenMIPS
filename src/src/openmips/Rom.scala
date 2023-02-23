package openmips

import chisel3._
import chisel3.util.experimental.loadMemoryFromFileInline
import firrtl.annotations.MemoryLoadFileType

import openmips.Params
import openmips.bundle.RomRead
import openmips.Params.Global.zeroWord

class Rom(memoryFile: String) extends Module {
  val io = IO(new RomRead)

  val mem = SyncReadMem(Params.Rom.num, UInt(Params.Global.Width.instBus))
  loadMemoryFromFileInline(mem, memoryFile, MemoryLoadFileType.Binary)

  when(io.ce) {
    io.data := mem(io.addr)
  }.otherwise {
    io.data := zeroWord
  }
}
