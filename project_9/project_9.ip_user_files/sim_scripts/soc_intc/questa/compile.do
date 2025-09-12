vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xpm
vlib questa_lib/msim/lib_cdc_v1_0_3
vlib questa_lib/msim/proc_sys_reset_v5_0_16
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/microblaze_v11_0_14
vlib questa_lib/msim/microblaze_riscv_v1_0_3
vlib questa_lib/msim/lmb_v10_v3_0_14
vlib questa_lib/msim/lmb_bram_if_cntlr_v4_0_25
vlib questa_lib/msim/blk_mem_gen_v8_4_9
vlib questa_lib/msim/generic_baseblocks_v2_1_2
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_register_slice_v2_1_33
vlib questa_lib/msim/fifo_generator_v13_2_11
vlib questa_lib/msim/axi_data_fifo_v2_1_32
vlib questa_lib/msim/axi_crossbar_v2_1_34
vlib questa_lib/msim/axi_lite_ipif_v3_0_4
vlib questa_lib/msim/axi_intc_v4_1_20
vlib questa_lib/msim/xlconcat_v2_1_6
vlib questa_lib/msim/mdm_riscv_v1_0_3
vlib questa_lib/msim/lib_pkg_v1_0_4
vlib questa_lib/msim/lib_srl_fifo_v1_0_4
vlib questa_lib/msim/axi_uartlite_v2_0_37
vlib questa_lib/msim/interrupt_control_v3_1_5
vlib questa_lib/msim/axi_gpio_v2_0_35

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xpm questa_lib/msim/xpm
vmap lib_cdc_v1_0_3 questa_lib/msim/lib_cdc_v1_0_3
vmap proc_sys_reset_v5_0_16 questa_lib/msim/proc_sys_reset_v5_0_16
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap microblaze_v11_0_14 questa_lib/msim/microblaze_v11_0_14
vmap microblaze_riscv_v1_0_3 questa_lib/msim/microblaze_riscv_v1_0_3
vmap lmb_v10_v3_0_14 questa_lib/msim/lmb_v10_v3_0_14
vmap lmb_bram_if_cntlr_v4_0_25 questa_lib/msim/lmb_bram_if_cntlr_v4_0_25
vmap blk_mem_gen_v8_4_9 questa_lib/msim/blk_mem_gen_v8_4_9
vmap generic_baseblocks_v2_1_2 questa_lib/msim/generic_baseblocks_v2_1_2
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_33 questa_lib/msim/axi_register_slice_v2_1_33
vmap fifo_generator_v13_2_11 questa_lib/msim/fifo_generator_v13_2_11
vmap axi_data_fifo_v2_1_32 questa_lib/msim/axi_data_fifo_v2_1_32
vmap axi_crossbar_v2_1_34 questa_lib/msim/axi_crossbar_v2_1_34
vmap axi_lite_ipif_v3_0_4 questa_lib/msim/axi_lite_ipif_v3_0_4
vmap axi_intc_v4_1_20 questa_lib/msim/axi_intc_v4_1_20
vmap xlconcat_v2_1_6 questa_lib/msim/xlconcat_v2_1_6
vmap mdm_riscv_v1_0_3 questa_lib/msim/mdm_riscv_v1_0_3
vmap lib_pkg_v1_0_4 questa_lib/msim/lib_pkg_v1_0_4
vmap lib_srl_fifo_v1_0_4 questa_lib/msim/lib_srl_fifo_v1_0_4
vmap axi_uartlite_v2_0_37 questa_lib/msim/axi_uartlite_v2_0_37
vmap interrupt_control_v3_1_5 questa_lib/msim/interrupt_control_v3_1_5
vmap axi_gpio_v2_0_35 questa_lib/msim/axi_gpio_v2_0_35

vlog -work xilinx_vip -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/psh/tools/Vivado/2024.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work lib_cdc_v1_0_3 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_16 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/0831/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_intc/ip/soc_intc_proc_sys_reset_0_0/sim/soc_intc_proc_sys_reset_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_intc/ip/soc_intc_clk_wiz_0/soc_intc_clk_wiz_0_clk_wiz.v" \
"../../../bd/soc_intc/ip/soc_intc_clk_wiz_0/soc_intc_clk_wiz_0.v" \

vcom -work microblaze_v11_0_14 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/a243/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work microblaze_riscv_v1_0_3 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/f9dd/hdl/microblaze_riscv_v1_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_intc/ip/soc_intc_microblaze_riscv_0_0/sim/soc_intc_microblaze_riscv_0_0.vhd" \

vcom -work lmb_v10_v3_0_14 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/7495/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_intc/ip/soc_intc_dlmb_v10_2/sim/soc_intc_dlmb_v10_2.vhd" \
"../../../bd/soc_intc/ip/soc_intc_ilmb_v10_2/sim/soc_intc_ilmb_v10_2.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_25 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/73e9/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_intc/ip/soc_intc_dlmb_bram_if_cntlr_2/sim/soc_intc_dlmb_bram_if_cntlr_2.vhd" \
"../../../bd/soc_intc/ip/soc_intc_ilmb_bram_if_cntlr_2/sim/soc_intc_ilmb_bram_if_cntlr_2.vhd" \

vlog -work blk_mem_gen_v8_4_9 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/5ec1/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_intc/ip/soc_intc_lmb_bram_2/sim/soc_intc_lmb_bram_2.v" \

vlog -work generic_baseblocks_v2_1_2 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_33 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3ee4/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_11 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/6080/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_11 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/6080/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_11 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/6080/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_32 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/65ce/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_34 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/a7e3/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_intc/ip/soc_intc_microblaze_riscv_0_axi_periph_imp_xbar_1/sim/soc_intc_microblaze_riscv_0_axi_periph_imp_xbar_1.v" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work axi_intc_v4_1_20 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/99b7/hdl/axi_intc_v4_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_intc/ip/soc_intc_microblaze_riscv_0_axi_intc_1/sim/soc_intc_microblaze_riscv_0_axi_intc_1.vhd" \

vlog -work xlconcat_v2_1_6 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/6120/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_intc/ip/soc_intc_microblaze_riscv_0_xlconcat_1/sim/soc_intc_microblaze_riscv_0_xlconcat_1.v" \

vcom -work mdm_riscv_v1_0_3 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/d547/hdl/mdm_riscv_v1_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_intc/ip/soc_intc_mdm_1_2/sim/soc_intc_mdm_1_2.vhd" \

vcom -work lib_pkg_v1_0_4 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/8c68/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_4 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/1e5a/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_37 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/9a87/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_intc/ip/soc_intc_axi_uartlite_0_0/sim/soc_intc_axi_uartlite_0_0.vhd" \

vcom -work interrupt_control_v3_1_5 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/d8cc/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_35 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/6718/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_intc/ip/soc_intc_axi_gpio_0_0/sim/soc_intc_axi_gpio_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_intc/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_intc/sim/soc_intc.v" \

vlog -work xil_defaultlib \
"glbl.v"

