# Chisel Project Template (Beta)

## 概览

该模版主要用于提供一个方便统一的开发环境，同时建立一个 Chisel 项目的标准模版。

## 使用方式

### 前置条件

请确保在开发系统上安装了 Visual Studio Code 和 Docker，并且在 Visual Studio Code 中安装了工作区推荐的所有插件。

### 方法一：使用容器

Visual Studio Code 会提醒识别到一个 Dev Container 配置，并询问是否要使用这个容器配置。如果是第一次使用这个容器，会自动进行容器的搭建，需要花一点时间。

详细操作请参考：<https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container>

### 方法二：不使用容器

*待补充*

### 安装 Chipyard（可选）

在终端中运行项目目录下的脚本 `./chipyard-bootstrap.sh`，然后使用 `source chipyard-env` 激活环境。

## 自动化任务

- `make test`：运行所有测试
- `make verilog`：构建并生成 Verilog 模块

其他自动化任务请参考 `Makefile` 和 <https://github.com/OpenXiangShan/chisel-playground>

## 贡献

这个项目模版并不完美，欢迎改进模版、容器环境和本文档。