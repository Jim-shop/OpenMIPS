package openmips.test.module

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._
import chisel3.experimental.VecLiterals._

import utest._

import openmips.Params
import openmips.module.Mem
import openmips.bundle.RegfileWrite
import openmips.Params.Global.zeroWord

object MemSpec extends ChiselUtestTester {
  val tests = Tests {
    test("ori") {
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
      testCircuit(new Mem) { mem =>
        for (data <- datas) {
          mem.io.in.poke(data)
          mem.io.out.expect(data)
        }
      }
    }
  }
}
