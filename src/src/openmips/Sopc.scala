package openmips

import chisel3._

import openmips.{Cpu, Rom}
import openmips.bundle.RegfileRead

class Sopc(memoryFile: String) extends Module {
  val io = IO(new Bundle {
    val debugPort = Output(new Bundle {
      val addr = UInt(Params.Regfile.Width.addr)
      val data = UInt(Params.Regfile.Width.data)
    })
  })
  val cpu = Module(new Cpu())
  val rom = Module(new Rom(memoryFile))

  rom.io.ce           := cpu.io.romRead.ce
  rom.io.addr         := cpu.io.romRead.addr
  cpu.io.romRead.data := rom.io.data

  io.debugPort.addr := rom.io.addr
  io.debugPort.data := rom.io.data
}
