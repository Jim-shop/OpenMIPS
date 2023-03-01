import chisel3._
import chisel3.internal.firrtl.Width

package object openmips {
  final object Utils {
    def getWidth(range: (Int, Int)): Width = { (range._1 - range._2).W }
    def getBits(vector: Bits, range: (Int, Int)): UInt = { vector(range._1, range._2) }
    def getBin(digits: Int)(i: Int): String = { String.format(s"%${digits}s", i.toBinaryString).replace(" ", "0") }
  }
  final object Params {
    final object Global {
      final val zeroWord = 0.U(Width.instBus)

      final object Range {
        final val op        = (31, 26)
        final val address   = (25, 0)
        final val rs        = (25, 21)
        final val rt        = (20, 16)
        final val immediate = (15, 0)
        final val rd        = (15, 11)
        final val sa        = (10, 6)
        final val func      = (5, 0)
      }

      final object Width {
        final val word    = 32.W
        final val instBus = word
        final val addrBus = word
        final object Atom {
          final val op        = Utils.getWidth(Range.op)
          final val address   = Utils.getWidth(Range.address)
          final val rs        = Utils.getWidth(Range.rs)
          final val rt        = Utils.getWidth(Range.rt)
          final val immediate = Utils.getWidth(Range.immediate)
          final val rd        = Utils.getWidth(Range.rd)
          final val sa        = Utils.getWidth(Range.sa)
          final val func      = Utils.getWidth(Range.func)
        }
      }

      final object Ops {
        final val ori = "b001101".U(Width.Atom.op)
        final val nop = "b000000".U(Width.Atom.op)
      }
    }

    final object Regfile {
      final val num         = 32
      final val readPortNum = 2
      final val nopAddr     = "b00000".U(Width.addr)
      final object Width {
        final val addr = 5.W
        final val data = Global.Width.instBus;
      }
    }

    final object Alu {
      final object Ops {
        final val nop = "b00000000".U(Width.op)
        final val or  = "b00100101".U(Width.op)
      }
      final object Sel {
        final val nop   = "b000".U(Width.sel)
        final val logic = "b001".U(Width.sel)
      }
      final object Width {
        final val op  = 8.W
        final val sel = 3.W
      }
    }

    final object Rom {
      final val num = 131071
    }
  }
}
