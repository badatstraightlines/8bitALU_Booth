8-Bit ALU with Booth's Multiplier (RTL to GDSII)

An 8-bit Arithmetic Logic Unit (ALU) integrated with a Booth's Multiplication Algorithm module, implemented in SystemVerilog and implemented through a complete ASIC physical design flow (Synthesis, Floorplanning, Placement, Clock Tree Synthesis, and Routing) using OpenLane.

🚀 Key Features

SystemVerilog RTL Design: Clean, synthesizable modular design using SystemVerilog.

Booth's Multiplier Module: Implements signed 8-bit multiplication using Booth's algorithm to reduce partial products and increase computation efficiency.

Comprehensive ALU Operations:

Arithmetic: Addition, Subtraction, Signed Multiplication (Booth's).

Logic: Bitwise AND, OR, XOR, NOT, NAND, NOR.

Shifts: Logical Shift Left/Right, Arithmetic Shift Right.

Complete ASIC Physical Design: Taken through OpenLane automated P&R flow targeting SkyWater 130nm technology.

📊 Physical Design & Implementation Summary

Metric

Details / Specifications

Technology Node

SkyWater 130nm (sky130hd)

Toolchain

OpenLane (Yosys, OpenROAD, KLayout, Magic)

Design Phase

Post-Route Signoff

Physical Artifacts

Layout Exchange Format (.def) included in repository

Signoff Checks

DRC / LVS Clean (0 Violations)

📂 Repository Structure

├── rtl/               # SystemVerilog source code

├── tb/                # Testbench files for RTL simulation

├── layout/            # Final physical design files (DEF)

│   └── *.def          # Post-route layout file for KLayout / OpenROAD

└── README.md          # Project documentation


⚙️ How to Reproduce & View

1. Inspecting the Layout

To view the physical placement and routing without building the entire flow, load the provided .def file in KLayout or OpenROAD:

klayout layout/*.def


2. Functional Verification

Compile and simulate the SystemVerilog testbench using your preferred simulator (e.g., ModelSim, Questa, Verilator, or Icarus Verilog):

# Example with Icarus Verilog
iverilog -g2012 -o alu_tb rtl/*.sv tb/*.sv
vvp alu_tb


3. Running OpenLane ASIC Flow

To re-run the synthesis and place & route flow:

cd $OPENLANE_ROOT
./flow.tcl -design fsm_datapath


📝 License

This project is released under the MIT License.
