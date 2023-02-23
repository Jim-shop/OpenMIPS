package openmips.test.module

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._
import chisel3.experimental.VecLiterals._

import utest._

import openmips.Params
import openmips.module.Ex
import openmips.bundle.{IdExPort, RegfileWrite}

object ExSpec extends ChiselUtestTester {
  val tests = Tests {
    test("ori") {
      case class OriData(writeAddrBinStr: String, writeEnBoolean: Boolean, regValInt: (Int, Int)) {
        private val writeEn   = writeEnBoolean.B
        private val writeAddr = writeAddrBinStr.U(Params.Regfile.Width.addr)
        val input = (new IdExPort).Lit(
          _.aluOp -> Params.Alu.Ops.or,
          _.aluSel -> Params.Alu.Sel.logic,
          _.writeAddr -> writeAddr,
          _.writeEn -> writeEn,
          _.regVal -> Vec(Params.Regfile.readPortNum, UInt(Params.Regfile.Width.data)).Lit(
            0 -> regValInt._1.U(Params.Regfile.Width.data),
            1 -> regValInt._2.U(Params.Regfile.Width.data)
          )
        )
        val assumeOutput = (new RegfileWrite).Lit(
          _.en -> writeEn,
          _.addr -> writeAddr,
          _.data -> (regValInt._1 | regValInt._2).U(Params.Regfile.Width.data)
        )
      }
      val datas = Seq(
        OriData("b00000", false, (0, 0)),
        OriData("b10101", true, (114514, 123)),
        OriData("b10101", true, (114514, 123)),
        OriData("b01010", true, (114514, 456)),
        OriData("b01010", true, (998477353, 0)),
        OriData("b11111", false, (0, 32768)),
        OriData("b00000", false, (1919810, 32768))
      )
      testCircuit(new Ex) { ex =>
        for (data <- datas) {
          ex.io.idExPort.poke(data.input)
          ex.io.regWrite.expect(data.assumeOutput)
        }
      }
    }
  }

}
