transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/lib_cdc_v1_0_3
vlib riviera/proc_sys_reset_v5_0_16
vlib riviera/xil_defaultlib
vlib riviera/microblaze_v11_0_14
vlib riviera/microblaze_riscv_v1_0_3
vlib riviera/lmb_v10_v3_0_14
vlib riviera/lmb_bram_if_cntlr_v4_0_25
vlib riviera/blk_mem_gen_v8_4_9
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/mdm_riscv_v1_0_3
vlib riviera/lib_pkg_v1_0_4
vlib riviera/lib_srl_fifo_v1_0_4
vlib riviera/axi_uartlite_v2_0_37
vlib riviera/xlconstant_v1_1_9
vlib riviera/smartconnect_v1_0
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_register_slice_v2_1_33
vlib riviera/axi_vip_v1_1_19
vlib riviera/interrupt_control_v3_1_5
vlib riviera/axi_gpio_v2_0_35
vlib riviera/axi_iic_v2_1_9

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap lib_cdc_v1_0_3 riviera/lib_cdc_v1_0_3
vmap proc_sys_reset_v5_0_16 riviera/proc_sys_reset_v5_0_16
vmap xil_defaultlib riviera/xil_defaultlib
vmap microblaze_v11_0_14 riviera/microblaze_v11_0_14
vmap microblaze_riscv_v1_0_3 riviera/microblaze_riscv_v1_0_3
vmap lmb_v10_v3_0_14 riviera/lmb_v10_v3_0_14
vmap lmb_bram_if_cntlr_v4_0_25 riviera/lmb_bram_if_cntlr_v4_0_25
vmap blk_mem_gen_v8_4_9 riviera/blk_mem_gen_v8_4_9
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap mdm_riscv_v1_0_3 riviera/mdm_riscv_v1_0_3
vmap lib_pkg_v1_0_4 riviera/lib_pkg_v1_0_4
vmap lib_srl_fifo_v1_0_4 riviera/lib_srl_fifo_v1_0_4
vmap axi_uartlite_v2_0_37 riviera/axi_uartlite_v2_0_37
vmap xlconstant_v1_1_9 riviera/xlconstant_v1_1_9
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_33 riviera/axi_register_slice_v2_1_33
vmap axi_vip_v1_1_19 riviera/axi_vip_v1_1_19
vmap interrupt_control_v3_1_5 riviera/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_35 riviera/axi_gpio_v2_0_35
vmap axi_iic_v2_1_9 riviera/axi_iic_v2_1_9

vlog -work xilinx_vip  -incr "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work lib_cdc_v1_0_3 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_16 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0831/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_proc_sys_reset_0_0/sim/soc_stop_watch_proc_sys_reset_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_clk_wiz_0/soc_stop_watch_clk_wiz_0_clk_wiz.v" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_clk_wiz_0/soc_stop_watch_clk_wiz_0.v" \

vcom -work microblaze_v11_0_14 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/a243/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work microblaze_riscv_v1_0_3 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f9dd/hdl/microblaze_riscv_v1_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_microblaze_riscv_0_0/sim/soc_stop_watch_microblaze_riscv_0_0.vhd" \

vcom -work lmb_v10_v3_0_14 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/7495/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_dlmb_v10_0/sim/soc_stop_watch_dlmb_v10_0.vhd" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_ilmb_v10_0/sim/soc_stop_watch_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_25 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/73e9/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_dlmb_bram_if_cntlr_0/sim/soc_stop_watch_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_ilmb_bram_if_cntlr_0/sim/soc_stop_watch_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_9  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/5ec1/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_lmb_bram_0/sim/soc_stop_watch_lmb_bram_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work mdm_riscv_v1_0_3 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/d547/hdl/mdm_riscv_v1_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_mdm_1_0/sim/soc_stop_watch_mdm_1_0.vhd" \

vcom -work lib_pkg_v1_0_4 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/8c68/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_4 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/1e5a/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_37 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/9a87/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_uartlite_0_0/sim/soc_stop_watch_axi_uartlite_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/sim/bd_b74d.v" \

vlog -work xlconstant_v1_1_9  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_0/sim/bd_b74d_one_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_1/sim/bd_b74d_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_2/sim/bd_b74d_arinsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_3/sim/bd_b74d_rinsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_4/sim/bd_b74d_awinsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_5/sim/bd_b74d_winsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_6/sim/bd_b74d_binsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_7/sim/bd_b74d_aroutsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_8/sim/bd_b74d_routsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_9/sim/bd_b74d_awoutsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_10/sim/bd_b74d_woutsw_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_11/sim/bd_b74d_boutsw_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_12/sim/bd_b74d_arni_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_13/sim/bd_b74d_rni_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_14/sim/bd_b74d_awni_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_15/sim/bd_b74d_wni_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_16/sim/bd_b74d_bni_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f49a/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_17/sim/bd_b74d_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_18/sim/bd_b74d_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/63ed/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_19/sim/bd_b74d_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_20/sim/bd_b74d_s00a2s_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_21/sim/bd_b74d_sarn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_22/sim/bd_b74d_srn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_23/sim/bd_b74d_sawn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_24/sim/bd_b74d_swn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_25/sim/bd_b74d_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_26/sim/bd_b74d_m00s2a_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_27/sim/bd_b74d_m00arn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_28/sim/bd_b74d_m00rn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_29/sim/bd_b74d_m00awn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_30/sim/bd_b74d_m00wn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_31/sim/bd_b74d_m00bn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/37bc/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_32/sim/bd_b74d_m00e_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_33/sim/bd_b74d_m01s2a_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_34/sim/bd_b74d_m01arn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_35/sim/bd_b74d_m01rn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_36/sim/bd_b74d_m01awn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_37/sim/bd_b74d_m01wn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_38/sim/bd_b74d_m01bn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_39/sim/bd_b74d_m01e_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_40/sim/bd_b74d_m02s2a_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_41/sim/bd_b74d_m02arn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_42/sim/bd_b74d_m02rn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_43/sim/bd_b74d_m02awn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_44/sim/bd_b74d_m02wn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_45/sim/bd_b74d_m02bn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_46/sim/bd_b74d_m02e_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_47/sim/bd_b74d_m03s2a_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_48/sim/bd_b74d_m03arn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_49/sim/bd_b74d_m03rn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_50/sim/bd_b74d_m03awn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_51/sim/bd_b74d_m03wn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_52/sim/bd_b74d_m03bn_0.sv" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/bd_0/ip/ip_53/sim/bd_b74d_m03e_0.sv" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_33  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3ee4/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_19  -incr "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/8c45/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_smc_0/sim/soc_stop_watch_axi_smc_0.v" \
"../../../bd/soc_stop_watch/ipshared/cbd0/hdl/myip_stop_watch_slave_lite_v1_0_S00_AXI.v" \
"../../../bd/soc_stop_watch/ipshared/cbd0/hdl/myip_stop_watch.v" \
"../../../bd/soc_stop_watch/ipshared/cbd0/src/exam02_sequential_logic.v" \
"../../../bd/soc_stop_watch/ipshared/cbd0/src/test_top.v" \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_myip_stop_watch_0_0/sim/soc_stop_watch_myip_stop_watch_0_0.v" \

vcom -work interrupt_control_v3_1_5 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_35 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/6718/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_gpio_0_0/sim/soc_stop_watch_axi_gpio_0_0.vhd" \

vcom -work axi_iic_v2_1_9 -93  -incr \
"../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/2eec/hdl/axi_iic_v2_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/soc_stop_watch/ip/soc_stop_watch_axi_iic_0_0/sim/soc_stop_watch_axi_iic_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_stop_watch/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l xil_defaultlib -l microblaze_v11_0_14 -l microblaze_riscv_v1_0_3 -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_riscv_v1_0_3 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 -l interrupt_control_v3_1_5 -l axi_gpio_v2_0_35 -l axi_iic_v2_1_9 \
"../../../bd/soc_stop_watch/sim/soc_stop_watch.v" \

vlog -work xil_defaultlib \
"glbl.v"

