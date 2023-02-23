package openmips.test

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._

import utest._

import openmips.Cpu
import openmips.Params

object CpuSpec extends ChiselUtestTester {
  val tests = Tests {
    test("ori") {
      testCircuit(new Cpu) { cpu =>
        cpu.io.romRead.ce.expect(false.B)
        cpu.io.romRead.addr.expect(0.U(Params.Global.Width.addrBus))
        cpu.clock.step()
        cpu.io.romRead.ce.expect(true.B)
        cpu.io.romRead.addr.expect(0.U(Params.Global.Width.addrBus))
        cpu.clock.step()
        cpu.io.romRead.ce.expect(true.B)
        cpu.io.romRead.addr.expect(1.U(Params.Global.Width.addrBus))
        cpu.clock.step(50)
      }
    }
  }
}
