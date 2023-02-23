package openmips

import chisel3.{Mem => _, _}

import openmips.Params
import openmips.module._
import openmips.bridge._
import openmips.bundle.{RomRead}

class Cpu extends Module {
  val io = IO(new Bundle {
    val romRead = Flipped(new RomRead)
  })

  val pc = Module(new Pc)
  io.romRead.addr := pc.io.pc
  io.romRead.ce   := pc.io.ce

  val ifToId = Module(new IfToId)
  ifToId.io.in.pc   := pc.io.pc
  ifToId.io.in.inst := io.romRead.data

  val id = Module(new Id)
  id.io.ifIdPort := ifToId.io.out

  val idToEx = Module(new IdToEx)
  idToEx.io.in := id.io.idExPort

  val ex = Module(new Ex)
  ex.io.idExPort := idToEx.io.out

  val exToMem = Module(new ExToMem)
  exToMem.io.in := ex.io.regWrite

  val mem = Module(new Mem)
  mem.io.in := exToMem.io.out

  val memToWb = Module(new MemToWb)
  memToWb.io.in := mem.io.out

  val regfile = Module(new Regfile)
  regfile.io.write := memToWb.io.out
  for ((src, dst) <- id.io.regReads.zip(regfile.io.reads)) {
    dst.en   := src.en
    dst.addr := src.addr
    src.data := dst.data
  }
}