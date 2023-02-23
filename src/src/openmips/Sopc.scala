package openmips

import chisel3._

import openmips.{Cpu, Rom}

class Sopc(memoryFile: String) extends Module {

  val cpu = Module(new Cpu)
  val rom = Module(new Rom(memoryFile))

  rom.io.ce           := cpu.io.romRead.ce
  rom.io.addr         := cpu.io.romRead.addr
  cpu.io.romRead.data := rom.io.data
}
