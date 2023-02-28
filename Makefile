ifeq ($(OS),Windows_NT) # Windows
BUILD_DIR    = .\build
MKDIR_P_CMD  = -mkdir 2>NUL
RM_RF_CMD    = rmdir /s /q
else # Unix_like
BUILD_DIR    = ./build
MKDIR_P_CMD  = mkdir -p
RM_RF_CMD    = rm -rf
endif

export PATH := $(PATH):$(abspath ./utils)

default: test

mars:
	java -jar ./utils/Mars.jar

test:
	millw -i __.test

verilog:
	$(MKDIR_P_CMD) $(BUILD_DIR)
	millw -i __.test.runMain Elaborate -td $(BUILD_DIR)

help:
	millw -i __.test.runMain Elaborate --help

compile:
	millw -i __.compile

bsp:
	millw -i mill.bsp.BSP/install

reformat:
	millw -i __.reformat

checkformat:
	millw -i __.checkFormat

clean:
	-$(RM_RF_CMD) $(BUILD_DIR) out test_run_dir

.PHONY: default mars test verilog help compile bsp reformat checkformat clean
