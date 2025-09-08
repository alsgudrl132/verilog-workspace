onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib soc_dht11_iic_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {soc_dht11_iic.udo}

run 1000ns

quit -force
