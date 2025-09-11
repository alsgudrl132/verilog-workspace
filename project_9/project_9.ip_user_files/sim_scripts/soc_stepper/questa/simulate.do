onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib soc_stepper_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {soc_stepper.udo}

run 1000ns

quit -force
