8-Bit ALU with Booth's Multiplier (RTL to GDSII)

An 8-bit Arithmetic Logic Unit (ALU) integrated with a Booth's Multiplication Algorithm module, implemented in SystemVerilog and taken through full physical design synthesis, placement, and routing using the OpenLane ASIC flow.

🎨 Physical Layout View

Below is the layout generated after completing the full Place and Route (P&R) pipeline, verified with DRC and LVS checks in KLayout / Magic:

Note: The layout above displays standard cell placement rows, power distribution networks (PDN), and global/detailed routing pins.

🚀 Key Features

SystemVerilog RTL: Designed using modular SystemVerilog constructs.

Booth's Multiplier: Implements signed 8-bit multiplication using Booth's algorithm to reduce partial products and enhance execution efficiency.

ALU Operations:

Arithmetic: Addition, Subtraction, Multiplication (Booth's).

Logical: AND, OR, XOR, NOT.

Shifts/Rotates: Logical and Arithmetic shifts.

ASIC Implementation: Taken through complete RTL-to-GDSII flow using OpenLane.

📊 Physical Design Summary

Metric

Details

PDK Process

SkyWater 130nm (sky130hd)

EDA Toolchain

OpenLane (OpenROAD / Yosys / KLayout / Magic)

Physical Design Outputs

.def (Layout exchange), .gds (GDSII stream)

DRC / LVS Status

Clean (0 Violations)

📂 Repository Structure

├── rtl/                     # SystemVerilog RTL source files
│   ├── alu_top.sv
│   └── booth_multiplier.sv
├── tb/                      # Testbench files
├── layout/                  # Generated physical design layout files (.def)
│   └── final.def
├── docs/                    # Layout images and architectural diagrams
│   └── layout.png
└── README.md


⚙️ How to Reproduce

1. Functional Verification (Simulation)

Compile and run the SystemVerilog testbench using your preferred simulator (e.g., ModelSim, Questa, Verilator, or Icarus Verilog):

# Example using Verilator / Icarus Verilog
iverilog -g2012 -o alu_tb rtl/*.sv tb/*.sv
vvp alu_tb


2. ASIC Physical Design Flow (OpenLane)

To run the automated Place & Route flow in OpenLane:

# Clone and setup OpenLane environment
cd $OPENLANE_ROOT
./flow.tcl -design 8bitALU_Booth


📝 License

This project is open-source under the MIT License.
