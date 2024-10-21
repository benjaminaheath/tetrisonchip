PROJ_ROOT := ~/tetrisonchip
RTL := $(PROJ_ROOT)/rtl
VERIF := $(PROJ_ROOT)/verification

BUILD := $(VERIF)/build
SIM_OUTPUT := $(BUILD)/simulation
SIM_FLAGS := -Wall -g2012

LFSR_SRC := $(RTL)/controller/lfsr.sv
LFSR_TEST := $(VERIF)/test_lfsr.sv

PIECEGEN_SRC := $(RTL)/controller/piecegenerator.sv
PIECEGEN_SRC += $(LFSR_SRC)
PIECEGEN_TEST := $(VERIF)/test_piecegenerator.sv

.PHONY: all
all: # disable the all flag

lfsr: $(LFSR_SRC) $(LFSR_TEST)
	@mkdir -p $(BUILD)
	iverilog $(SIM_FLAGS) -o $(SIM_OUTPUT) $^

piecegen: $(PIECEGEN_SRC) $(PIECEGEN_TEST)
	@mkdir -p $(BUILD)
	iverilog $(SIM_FLAGS) -o $(SIM_OUTPUT) $^

run: $(SIM_OUTPUT)
	vvp $(SIM_OUTPUT)

.PHONY: clean
clean:
	rm -rf $(BUILD)

