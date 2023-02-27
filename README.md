# OpenMIPS (Chisel)


## 概览

该项目是《自己动手写CPU》一书中OpenMIPS处理器的Chisel实现。

## 完成情况

- [x] ori

## 依赖

- `Scala` 2.13.10
- `GNU make`

其他所需的工具已自带：

- 来自`llvm/CIRCT`的`firtool`：
  
    Win/Linux/macOS二进制文件已自带，开箱即用

- 构建系统`mill`：
  
    已自带`millw`，可自动联网下载mill，首次使用需网络畅通


## 使用方式

使用`GNU make`自动化构建：
- `make test`：运行所有测试
- `make verilog`：构建并生成 Verilog 模块

其他自动化任务请参考 `Makefile` 和 <https://github.com/OpenXiangShan/chisel-playground>
