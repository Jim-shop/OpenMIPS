package openmips.module

import chisel3._
import chisel3.experimental.BundleLiterals._

import openmips.Params
import openmips.bundle.RegfileWrite

class Mem extends Module {
  val io = IO(new Bundle {
    val in  = Input(new RegfileWrite)
    val out = Output(new RegfileWrite)
  })

  io.out := io.in

}
