compile
iverilog -o cpu.vvp cpu.v alu.v reg.v sign.v cpu_test.v

run
vvp cpu.vvp

open with gtkwave tool
gtkwave wavedata_cpu.vcd
