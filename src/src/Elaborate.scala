import openmips._

import chisel3.stage._
import circt.stage.{CIRCTTarget, CIRCTTargetAnnotation}
import circt.stage

object Elaborate extends App {
  val useMFC    = true // use MLIR-based firrtl compiler
  val generator = Seq(chisel3.stage.ChiselGeneratorAnnotation(() => top))

  // def top = new Sopc(memoryFile="./src/test/rom/ori.data", debug=false)
  def top = new Cpu

  if (useMFC) {
    (new stage.ChiselStage)
      .execute(args, generator :+ CIRCTTargetAnnotation(CIRCTTarget.Verilog))
  } else {
    (new ChiselStage).execute(args, generator)
  }
}
