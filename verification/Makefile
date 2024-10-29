PROJ_ROOT := ~/tetrisonchip
RTL := $(PROJ_ROOT)/rtl
VERIF := $(PROJ_ROOT)/verification

BUILD := $(VERIF)/build
SIM_OUTPUT := $(BUILD)/simulation
SIM_FLAGS := -Wall -g2012

LFSR_SRC := $(RTL)/controller/lfsr.sv
LFSR_TEST := $(VERIF)/test_lfsr.sv

BAG_SRC := $(RTL)/controller/bag.sv
BAG_TEST := $(VERIF)/test_bag.sv

RANDOMBAG_SRC := $(RTL)/controller/randombag.sv
RANDOMBAG_SRC += $(LFSR_SRC)
RANDOMBAG_SRC += $(BAG_SRC)
RANDOMBAG_TEST := $(VERIF)/test_randombag.sv


.PHONY: all
all: # disable the all flag

lfsr: $(LFSR_SRC) $(LFSR_TEST)
	@mkdir -p $(BUILD)
	iverilog $(SIM_FLAGS) -o $(SIM_OUTPUT) $^

bag: $(BAG_SRC) $(BAG_TEST)
	@mkdir -p $(BUILD)
	iverilog $(SIM_FLAGS) -o $(SIM_OUTPUT) $^

randombag: $(RANDOMBAG_SRC) $(RANDOMBAG_TEST)
	@mkdir -p $(BUILD)
	iverilog $(SIM_FLAGS) -o $(SIM_OUTPUT) $^

run: $(SIM_OUTPUT)
	vvp $(SIM_OUTPUT)

.PHONY: clean
clean:
	rm -rf $(BUILD)

