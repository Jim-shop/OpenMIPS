package openmips.test.module

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._

import utest._

import openmips.module.Pc

object PcSpec extends ChiselUtestTester {
  val tests = Tests {
    test("通常情况") {
      testCircuit(new Pc) { pc =>
        pc.io.pc.expect(0.U)
        pc.io.ce.expect(false.B)
        for (i <- 0 until 100) {
          pc.clock.step(1)
          pc.io.pc.expect(i.U)
          pc.io.ce.expect(true.B)
        }
      }
    }
  }
}
