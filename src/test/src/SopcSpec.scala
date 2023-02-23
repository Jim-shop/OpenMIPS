package openmips.test

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._

import utest._

import openmips.Sopc
import openmips.Params

object SopcSpec extends ChiselUtestTester {
  val tests = Tests {
    test("ori") {
      val memoryFile = "./src/test/rom/ori.data"
      testCircuit(new Sopc(memoryFile)) { sopc =>
        sopc.reset.poke(true.B)
        sopc.clock.step(10)
        sopc.reset.poke(false.B)
        sopc.clock.step(50)
      }
    }
  }
}
