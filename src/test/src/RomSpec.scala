package openmips.test

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._

import utest._

import openmips.Rom
import openmips.Params
import openmips.Params.Global.zeroWord
import openmips.Params.Global.Width.{addrBus, instBus}

object RomSpec extends ChiselUtestTester {
  val tests = Tests {
    test("检查ROM工作情况") {
      testCircuit(new Rom("./src/test/rom/test.data")) { rom => 
          rom.io.ce.poke(false.B)
          rom.io.addr.poke(123.U(addrBus))
          rom.io.data.expect(zeroWord)
          rom.io.addr.poke(456.U(addrBus))
          rom.io.data.expect(zeroWord)
          rom.io.addr.poke("d4294967295".U(addrBus))
          rom.io.data.expect(zeroWord)
          rom.io.ce.poke(true.B)
          rom.io.addr.poke(0.U(addrBus))
          rom.clock.step()
          rom.io.data.expect("b01101100001000100010010000100001".U(instBus))
          rom.io.addr.poke(1.U(addrBus))
          rom.clock.step()
          rom.io.data.expect("b01010101010101010101010101010101".U(instBus))
          rom.io.addr.poke(3.U(addrBus))
          rom.clock.step()
          rom.io.data.expect("b11111111111111111111111111111111".U(instBus))
      }
    }
  }
}
