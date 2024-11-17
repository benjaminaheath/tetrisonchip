# Define Project File Structure
PROJ_ROOT := $(shell git rev-parse --show-toplevel | xargs)# Project Root Directory
RTL := $(PROJ_ROOT)/rtl# RTL Root Directory
VERIF := $(PROJ_ROOT)/verification# Verification Root Directory

SIM := verilator		# Use Verilator as Simulator
SIM_FLAGS := -Wall --cc --sv --exe --timing  # Default flags: All warnings, c++ output, sv, executable output
TRACE ?= True			# Traceable output is optional, default true
ifeq ($(TRACE), True)
	$(SIM_FLAGS) += --trace # If trace not disabled, append --trace flag
endif
CORES ?= 4			# Set default transpile cores as 4
$(SIM_FLAGS) += -j $(CORES)	# Sim flags for core

# Sim Output and Build Directories
SIM_OUTPUT := $(BUILD)/simulation
BUILD := $(VERIF)/build

# Module Test Directories
LFSR_SRC := $(RTL)/controller/lfsr.sv
LFSR_TEST := $(VERIF)/test_lfsr.sv

BAG_SRC := $(RTL)/controller/bag.sv
BAG_TEST := $(VERIF)/test_bag.sv

RANDOMBAG_SRC := $(RTL)/controller/randombag.sv
RANDOMBAG_SRC += $(LFSR_SRC) $(BAG_SRC)
RANDOMBAG_TEST := $(VERIF)/test_randombag.sv

BOARD_MEM_SRC := $(RTL)/board_mem.sv
BOARD_MEM_TEST := $(VERIF)/test_board.sv

IC_SRC := $(RTL)/controller/interrupt_controller.sv
IC_TEST := $(VERIF)/test_interrupt_controller.sv

.PHONY: all
all: # disable the all flag
	

lfsr: $(LFSR_SRC) $(LFSR_TEST)
	@mkdir -p $(BUILD)
	$(SIM) $(SIM_FLAGS) -o $(BUILD)/$@ $^
	@$(BUILD)/$@

bag: $(BAG_SRC) $(BAG_TEST)
	@mkdir -p $(BUILD)
	$(SIM) $(SIM_FLAGS) -o $(BUILD)/$@ $^
	@$(BUILD)/$@

board_mem: $(BOARD_MEM_SRC) $(BOARD_MEM_TEST)
	@mkdir -p $(BUILD)
	$(SIM) $(SIM_FLAGS) -o $(BUILD)/$@ $^
	@$(BUILD)/$@

ic: $(IC_SRC) $(IC_TEST)
	@mkdir -p $(BUILD)
	$(SIM) $(SIM_FLAGS) -o $(BUILD)/$@ $^
	@$(BUILD)/$@

randombag: $(RANDOMBAG_SRC) $(RANDOMBAG_TEST)
	@mkdir -p $(BUILD)
	$(SIM) $(SIM_FLAGS) -o $(BUILD)/$@ $^
	@$(BUILD)/$@

.PHONY: clean
clean:
	rm -rf $(BUILD)

