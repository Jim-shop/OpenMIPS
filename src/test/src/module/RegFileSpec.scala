

import chisel3._
import chiseltest._
import chisel3.experimental.BundleLiterals._

import utest._

import openmips.module.Regfile
import openmips.Params.Regfile.num

object RegfileSpec extends ChiselUtestTester {
  val tests = Tests {
    // test("检查初始化") {
    //   testCircuit(new Regfile) { regfile =>
    //     for (read <- regfile.io.reads) {
    //       read.en.poke(true.B)
    //       for (addr <- 0 until num) {
    //         read.addr.poke(addr.U)
    //         read.data.expect(0.U)
    //       }
    //     }
    //   }
    // }
    test("先写后读") {
      testCircuit(new Regfile) { regfile =>
        regfile.io.write.en.poke(true.B)
        for (addr <- 0 until num) {
          regfile.io.write.addr.poke(addr.U)
          regfile.io.write.data.poke((128 - addr).U)
          regfile.clock.step()
        }
        regfile.io.write.en.poke(false.B)
        for (read <- regfile.io.reads) {
          read.en.poke(true.B)
          // $0特殊处理
          read.addr.poke(0.U)
          read.data.expect(0.U)
          for (addr <- 1 until num) {
            read.addr.poke(addr.U)
            read.data.expect((128 - addr).U) // 应当是组合逻辑
          }
        }
      }
    }
    test("先写，然后读端口同时读取") {
      testCircuit(new Regfile) { regfile =>
        regfile.io.write.en.poke(true.B)
        for (addr <- 0 until num) {
          regfile.io.write.addr.poke(addr.U)
          regfile.io.write.data.poke((128 - addr).U)
          regfile.clock.step()
        }
        regfile.io.write.en.poke(false.B)
        regfile.io.reads(0).en.poke(true.B)
        regfile.io.reads(1).en.poke(true.B)
        // $0特殊处理
        regfile.io.reads(0).addr.poke(0.U)
        regfile.io.reads(1).addr.poke(0.U)
        regfile.io.reads(0).data.expect(0.U)
        regfile.io.reads(1).data.expect(0.U)
        for (addr <- 1 until num) {
          regfile.io.reads(0).addr.poke(addr.U)
          regfile.io.reads(1).addr.poke(addr.U)
          regfile.io.reads(0).data.expect((128 - addr).U)
          regfile.io.reads(1).data.expect((128 - addr).U) // 应当是组合逻辑
        }
      }
    }
    test("写同时读") {
      testCircuit(new Regfile) { regfile =>
        regfile.io.write.en.poke(true.B)
        regfile.io.reads(0).en.poke(true.B)
        regfile.io.reads(1).en.poke(true.B)
        for (addr <- 0 until num) {
          regfile.io.write.addr.poke(addr.U)
          regfile.io.reads(0).addr.poke(addr.U)
          regfile.io.reads(1).addr.poke(addr.U)
          regfile.io.write.data.poke(addr.U)
          regfile.io.reads(0).data.expect(addr.U)
          regfile.io.reads(1).data.expect(addr.U)
        }
      }
    }
    test("写en关测试") {
      testCircuit(new Regfile) { regfile =>
        regfile.io.write.en.poke(false.B)
        regfile.io.reads(0).en.poke(true.B)
        regfile.io.reads(1).en.poke(true.B)
        for (addr <- 0 until num) {
          regfile.io.write.addr.poke(addr.U)
          regfile.io.write.data.poke(addr.U)
          regfile.io.reads(0).addr.poke(addr.U)
          regfile.io.reads(1).addr.poke(addr.U)
          regfile.io.reads(0).data.expect(0.U)
          regfile.io.reads(1).data.expect(0.U)
        }
      }
    }
    test("读en关测试") {
      testCircuit(new Regfile) { regfile =>
        regfile.io.write.en.poke(true.B)
        for (addr <- 0 until num) {
          regfile.io.write.addr.poke(addr.U)
          regfile.io.write.data.poke((128 - addr).U)
          regfile.clock.step()
        }
        for (read <- regfile.io.reads) {
          read.en.poke(false.B)
          // $0特殊处理
          read.addr.poke(0.U)
          read.data.expect(0.U)
          for (addr <- 0 until num) {
            read.addr.poke(addr.U)
            read.data.expect(0.U)
          }
        }
      }
    }
  }
}
