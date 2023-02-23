package openmips.test.bridge

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._

import utest._

import openmips.Params
import openmips.bridge.IfToId

object IfToIdSpec extends ChiselUtestTester {
  val randUint32: Seq[Int] = Seq(
    0, 1, 3, 2, 2147483647, 6, 6, 1919810, 114514, 1919810
  )
  val tests = Tests {
    test("独立测试PC传递功能") {
      testCircuit(new IfToId) { ifToId =>
        var prevPc = 0.U(Params.Global.Width.addrBus)
        ifToId.io.in.pc.poke(prevPc)
        ifToId.clock.step()
        for (randPc <- randUint32.map { _.U(Params.Global.Width.addrBus) }) {
          ifToId.io.in.pc.poke(randPc)
          ifToId.io.out.pc.expect(prevPc)
          ifToId.clock.step()
          ifToId.io.out.pc.expect(randPc)
          prevPc = randPc
        }
      }
    }
    test("独立测试inst传递功能") {
      testCircuit(new IfToId) { ifToId =>
        var prevInst = 0.U(Params.Global.Width.instBus)
        ifToId.io.in.inst.poke(prevInst)
        ifToId.clock.step()
        for (randInst <- randUint32.map { _.U(Params.Global.Width.instBus) }) {
          ifToId.io.in.inst.poke(randInst)
          ifToId.io.out.inst.expect(prevInst)
          ifToId.clock.step()
          ifToId.io.out.inst.expect(randInst)
          prevInst = randInst
        }
      }
    }
    test("测试PC inst同时传递") {
      testCircuit(new IfToId) { ifToId =>
        var prevPc   = 0.U(Params.Global.Width.addrBus)
        var prevInst = 0.U(Params.Global.Width.instBus)
        ifToId.io.in.pc.poke(prevPc)
        ifToId.io.in.inst.poke(prevInst)
        ifToId.clock.step()
        for {
          randPc <- randUint32.map { _.U(Params.Global.Width.addrBus) }
          randInst <- randUint32.map { _.U(Params.Global.Width.instBus) }
        } {
          ifToId.io.in.pc.poke(randPc)
          ifToId.io.in.inst.poke(randInst)
          ifToId.io.out.pc.expect(prevPc)
          ifToId.io.out.inst.expect(prevInst)
          ifToId.clock.step()
          ifToId.io.out.pc.expect(randPc)
          ifToId.io.out.inst.expect(randInst)
          prevPc   = randPc
          prevInst = randInst
        }
      }
    }
  }
}
