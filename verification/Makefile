PROJ_ROOT := ~/tetrisonchip
RTL := $(PROJ_ROOT)/rtl
VERIF := $(PROJ_ROOT)/verification

BUILD := $(VERIF)/build
SIM_OUTPUT := $(BUILD)/simulation

all: run

$(SIM_OUTPUT): $(RTL)/controller/lfsr.v $(VERIF)/test_lfsr.v
	@clear
	@mkdir -p $(BUILD)
	iverilog -Wall -o $@ $^

run: $(SIM_OUTPUT)
	vvp $(SIM_OUTPUT)

.PHONY: clean
clean:
	rm -rf $(BUILD)

