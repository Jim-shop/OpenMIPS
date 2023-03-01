package openmips

import chisel3.{Mem => _, _}

import module._
import bridge._
import bundle.{RegfileRead, RomRead}

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
  id.io.ifIdPort <> ifToId.io.out

  val idToEx = Module(new IdToEx)
  idToEx.io.in <> id.io.idExPort

  val ex = Module(new Ex)
  ex.io.idExPort <> idToEx.io.out
  id.io.exRegWrite <> ex.io.regWrite

  val exToMem = Module(new ExToMem)
  exToMem.io.in <> ex.io.regWrite

  val mem = Module(new Mem)
  mem.io.in <> exToMem.io.out
  id.io.memRegWrite <> mem.io.out

  val memToWb = Module(new MemToWb)
  memToWb.io.in <> mem.io.out

  val regfile = Module(new Regfile)
  regfile.io.write <> memToWb.io.out
  id.io.regReads <> regfile.io.reads

  val debug = IO(
    new Bundle {
      val pc_val     = chiselTypeOf(pc.io.pc)
      val ifInst_val = chiselTypeOf(ifToId.io.out.inst)
      val aluOp_val  = chiselTypeOf(idToEx.io.out.aluOp)
      val aluSel_val = chiselTypeOf(idToEx.io.out.aluSel)
      val wb_val     = chiselTypeOf(regfile.io.write.data)
      val reg        = Output(Vec(Params.Regfile.num, UInt(Params.Regfile.Width.data)))
    }
  )
  debug.pc_val     := pc.io.pc
  debug.ifInst_val := ifToId.io.in.inst
  debug.aluOp_val  := idToEx.io.out.aluOp
  debug.aluSel_val := idToEx.io.out.aluSel
  debug.wb_val     := regfile.io.write.data
  debug.reg        := regfile.debug
}
