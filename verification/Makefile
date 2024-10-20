PROJ_ROOT := ~/tetrisonchip
RTL := $(PROJ_ROOT)/rtl
VERIF := $(PROJ_ROOT)/verification

BUILD := $(VERIF)/build
SIM_OUTPUT := $(BUILD)/simulation
SIM_FLAGS := -Wall -g2005-sv

LSFR_SRC := $(RTL)/controller/lfsr.v
LSFR_TEST := $(VERIF)/test_lfst.v

PIECEGENERATOR_SRC := $(RTL)/controller/piecegenerator.v
PIECEGENERATOR_SRC += $(LFSR_SRC)
PIECEGENERATOR_TEST := $(VERIF)/test_piecegenerator.v

.PHONY: all
all: # disable the all flag

lfsr: $(LSFR_SRC) $(LFSR_TEST)
	@mkdir -p $(BUILD)
	iverilog $(SIM_FLAGS) -o $(SIM_OUTPUT) $^

piecegen: $(PIECEGENERATOR_SRC) $(PIECEGENERATOR_TEST)
	@mkdir -p $(BUILD)
	iverilog $(SIM_FLAGS) -o $(SIM_OUTPUT) $^

run: $(SIM_OUTPUT)
	vvp $(SIM_OUTPUT)

.PHONY: clean
clean:
	rm -rf $(BUILD)

