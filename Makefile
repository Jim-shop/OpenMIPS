ifeq ($(OS),Windows_NT) # Windows
	BUILD_DIR    = .\build
	OUT_DIR      = .\out
	TEST_RUN_DIR = .\test_run_dir
	MILLW_PATH   = .\utils\millw
	MKDIR_P_CMD  = -mkdir 2>NUL
	RM_RF_CMD    = rmdir /s /q
else # Unix_like
	BUILD_DIR    = ./build
	OUT_DIR      = ./out
	TEST_RUN_DIR = ./test_run_dir
	MILLW_PATH   = ./utils/millw
	MKDIR_P_CMD  = mkdir -p
	RM_RF_CMD    = rm -rf
endif

export PATH := $(PATH):$(abspath ./utils)

default: verilog

test:
	$(MILLW_PATH) -i __.test

verilog:
	$(MKDIR_P_CMD) $(BUILD_DIR)
	$(MILLW_PATH) -i __.test.runMain Elaborate -td $(BUILD_DIR)

help:
	$(MILLW_PATH) -i __.test.runMain Elaborate --help

compile:
	$(MILLW_PATH) -i __.compile

bsp:
	$(MILLW_PATH) -i mill.bsp.BSP/install

reformat:
	$(MILLW_PATH) -i __.reformat

checkformat:
	$(MILLW_PATH) -i __.checkFormat

clean:
	-$(RM_RF_CMD) $(BUILD_DIR) $(OUT_DIR) $(TEST_RUN_DIR)

.PHONY: default test verilog help compile bsp reformat checkformat clean
