package openmips.test.module

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._

import utest._

import openmips.Params
import openmips.Utils.getBin
import openmips.module.Id
import chisel3.internal.firrtl.Width

object IdSpec extends ChiselUtestTester {
  val tests = Tests {
    test("ori") {
      testCircuit(new Id) { id =>
        val op       = "001101"
        val reg0data = 1234.U(Params.Global.Width.instBus)
        val reg1data = 888.U(Params.Global.Width.instBus)
        for {
          rs <- 0 until Params.Regfile.num
          rt <- 0 until Params.Regfile.num
          imm <- Seq(0, 114, 514, 514, 32767, 114)
        } {
          // 激励
          id.io.ifIdPort.inst.poke(s"b${op}_${getBin(5)(rs)}_${getBin(5)(rt)}_${getBin(16)(imm)}".U(Params.Global.Width.instBus))
          id.io.regReads(0).data.poke(reg0data)
          id.io.regReads(1).data.poke(reg1data)
          // 响应（组合电路）
          id.io.regReads(0).en.expect(true.B)
          id.io.regReads(0).addr.expect(rs.U(Params.Regfile.Width.addr))
          id.io.regReads(1).en.expect(false.B)
          id.io.regReads(1).addr.expect(rt.U(Params.Regfile.Width.addr))
          id.io.idExPort.aluOp.expect(Params.Alu.Ops.or)
          id.io.idExPort.aluSel.expect(Params.Alu.Sel.logic)
          id.io.idExPort.writeAddr.expect(rt.U(Params.Regfile.Width.addr))
          id.io.idExPort.writeEn.expect(true.B)
          id.io.idExPort.regVal(0).expect(reg0data)
          id.io.idExPort.regVal(1).expect(imm.U(Params.Global.Width.word))
        }
      }
    }
  }
}
