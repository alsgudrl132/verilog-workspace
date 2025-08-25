vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr -mfcu  \
"../../../../project_9.gen/sources_1/ip/xadc_joystic/xadc_joystic.v" \


vlog -work xil_defaultlib \
"glbl.v"

