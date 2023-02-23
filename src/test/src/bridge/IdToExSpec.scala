package openmips.test.bridge

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._
import chisel3.experimental.VecLiterals._

import utest._

import openmips.Params
import openmips.bridge.IdToEx
import openmips.bundle.IdExPort
import openmips.Params.Global.zeroWord

object IdToExSpec extends ChiselUtestTester {
  val tests = Tests {
    test("测试传递以及是否有时序") {
      val datas = Seq(
        (new IdExPort).Lit(
          _.aluOp -> zeroWord,
          _.aluSel -> zeroWord,
          _.regVal -> Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data)).Lit(
            0 -> zeroWord,
            1 -> zeroWord
          ),
          _.writeAddr -> Params.Regfile.nopAddr,
          _.writeEn -> false.B
        ),
        (new IdExPort).Lit(
          _.aluOp -> "b10101000".U(Params.Alu.Width.op),
          _.aluSel -> "b011".U(Params.Alu.Width.sel),
          _.regVal -> Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data)).Lit(
            0 -> 114514.U(Params.Regfile.Width.data),
            1 -> 1919810.U(Params.Regfile.Width.data)
          ),
          _.writeAddr -> "b10101".U(Params.Regfile.Width.addr),
          _.writeEn -> true.B
        ),
        (new IdExPort).Lit(
          _.aluOp -> "b11111111".U(Params.Alu.Width.op),
          _.aluSel -> "b100".U(Params.Alu.Width.sel),
          _.regVal -> Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data)).Lit(
            0 -> 114514.U(Params.Regfile.Width.data),
            1 -> 1919810.U(Params.Regfile.Width.data)
          ),
          _.writeAddr -> "b01010".U(Params.Regfile.Width.addr),
          _.writeEn -> true.B
        ),
        (new IdExPort).Lit(
          _.aluOp -> "b11111111".U(Params.Alu.Width.op),
          _.aluSel -> "b100".U(Params.Alu.Width.sel),
          _.regVal -> Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data)).Lit(
            0 -> 998477353.U(Params.Regfile.Width.data),
            1 -> 0.U(Params.Regfile.Width.data)
          ),
          _.writeAddr -> "b01010".U(Params.Regfile.Width.addr),
          _.writeEn -> true.B
        ),
        (new IdExPort).Lit(
          _.aluOp -> "b10101100".U(Params.Alu.Width.op),
          _.aluSel -> "b011".U(Params.Alu.Width.sel),
          _.regVal -> Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data)).Lit(
            0 -> 0.U(Params.Regfile.Width.data),
            1 -> "d4294967295".U(Params.Regfile.Width.data)
          ),
          _.writeAddr -> "b11111".U(Params.Regfile.Width.addr),
          _.writeEn -> false.B
        ),
        (new IdExPort).Lit(
          _.aluOp -> "b00000000".U(Params.Alu.Width.op),
          _.aluSel -> "b111".U(Params.Alu.Width.sel),
          _.regVal -> Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data)).Lit(
            0 -> 1919810.U(Params.Regfile.Width.data),
            1 -> "d4294967295".U(Params.Regfile.Width.data)
          ),
          _.writeAddr -> "b00000".U(Params.Regfile.Width.addr),
          _.writeEn -> false.B
        )
      )
      testCircuit(new IdToEx) { idToEx =>
        for ((data, index) <- datas.zipWithIndex.tail) {
          idToEx.io.in.poke(data)
          idToEx.io.out.expect(datas(index - 1))
          idToEx.clock.step()
          idToEx.io.out.expect(data)
        }
      }
    }
  }
}
