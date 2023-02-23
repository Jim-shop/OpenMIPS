package openmips.test.bridge

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._
import chisel3.experimental.VecLiterals._

import utest._

import openmips.Params
import openmips.bridge.ExToMem
import openmips.bundle.RegfileWrite
import openmips.Params.Global.zeroWord

object ExToMemSpec extends ChiselUtestTester {
  val tests = Tests {
    test("测试传递以及是否有时序") {
      val datas = Seq(
        (new RegfileWrite).Lit(
          _.en -> false.B,
          _.addr -> Params.Regfile.nopAddr,
          _.data -> Params.Global.zeroWord
        ),
        (new RegfileWrite).Lit(
          _.en -> true.B,
          _.addr -> "b10101".U(Params.Regfile.Width.addr),
          _.data -> 114514.U(Params.Regfile.Width.data),
        ),
        (new RegfileWrite).Lit(
          _.en -> false.B,
          _.addr -> "b10101".U(Params.Regfile.Width.addr),
          _.data -> 1919810.U(Params.Regfile.Width.data),
        ),
        (new RegfileWrite).Lit(
          _.en -> false.B,
          _.addr -> "b11111".U(Params.Regfile.Width.addr),
          _.data -> "d4294967295".U(Params.Regfile.Width.data),
        ),
        (new RegfileWrite).Lit(
          _.en -> true.B,
          _.addr -> "b00000".U(Params.Regfile.Width.addr),
          _.data -> 114.U(Params.Regfile.Width.data),
        ),
        (new RegfileWrite).Lit(
          _.en -> true.B,
          _.addr -> "b00111".U(Params.Regfile.Width.addr),
          _.data -> 114.U(Params.Regfile.Width.data),
        )
      )
      testCircuit(new ExToMem) { exToMem =>
        for ((data, index) <- datas.zipWithIndex.tail) {
          exToMem.io.in.poke(data)
          exToMem.io.out.expect(datas(index - 1))
          exToMem.clock.step()
          exToMem.io.out.expect(data)
        }
      }
    }
  }
}
