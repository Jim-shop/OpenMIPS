package openmips.test

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._

import utest._

import openmips.Cpu
import openmips.Params

object CpuSpec extends ChiselUtestTester {
  val tests = Tests {
    def runOnCpu(cpu: Cpu, insts: Seq[String]) = {
      for (i <- 0 until insts.length) {
        val inst = insts(cpu.io.debugPort.pc.peekInt().toInt)
        cpu.io.romRead.data.poke(inst.U)
        cpu.clock.step()
        val out = cpu.io.debugPort.wb.peekInt().toString(16)
        println(s"[Cycle ${i}] Emit: ${inst} Read: ${out}")
      }
    }
    test("ori") {
      testCircuit(new Cpu) { cpu =>
        runOnCpu(
          cpu,
          Seq(
            "b00000000000000000000000000000000",
            "b00110100000000010001000100000000",
            "b00110100000000100000000000100000",
            "b00110100000000111111111100000000",
            "b00110100000001001111111111111111",
            "b00000000000000000000000000000000",
            "b00000000000000000000000000000000",
            "b00000000000000000000000000000000",
            "b00000000000000000000000000000000",
            "b00000000000000000000000000000000"
          )
        )
      }

    }
    test("数据前推") {
      testCircuit(new Cpu) { cpu =>
        runOnCpu(
          cpu,
          Seq(
            "b00000000000000000000000000000000",
            "b00110100000000010001000100000000",
            "b00110100001000010000000000100000",
            "b00110100001000010100010000000000",
            "b00110100001000010000000001000100",
            "b00000000000000000000000000000000",
            "b00000000000000000000000000000000",
            "b00000000000000000000000000000000",
            "b00000000000000000000000000000000",
            "b00000000000000000000000000000000"
          )
        )
      }
    }
  }
}
