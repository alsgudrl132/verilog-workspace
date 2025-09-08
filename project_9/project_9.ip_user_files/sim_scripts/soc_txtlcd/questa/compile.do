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
vlib questa_lib/msim/axi_lite_ipif_v3_0_4
vlib questa_lib/msim/mdm_riscv_v1_0_3
vlib questa_lib/msim/lib_pkg_v1_0_4
vlib questa_lib/msim/lib_srl_fifo_v1_0_4
vlib questa_lib/msim/axi_uartlite_v2_0_37
vlib questa_lib/msim/xlconstant_v1_1_9
vlib questa_lib/msim/smartconnect_v1_0
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_register_slice_v2_1_33
vlib questa_lib/msim/axi_vip_v1_1_19

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
vmap axi_lite_ipif_v3_0_4 questa_lib/msim/axi_lite_ipif_v3_0_4
vmap mdm_riscv_v1_0_3 questa_lib/msim/mdm_riscv_v1_0_3
vmap lib_pkg_v1_0_4 questa_lib/msim/lib_pkg_v1_0_4
vmap lib_srl_fifo_v1_0_4 questa_lib/msim/lib_srl_fifo_v1_0_4
vmap axi_uartlite_v2_0_37 questa_lib/msim/axi_uartlite_v2_0_37
vmap xlconstant_v1_1_9 questa_lib/msim/xlconstant_v1_1_9
vmap smartconnect_v1_0 questa_lib/msim/smartconnect_v1_0
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_33 questa_lib/msim/axi_register_slice_v2_1_33
vmap axi_vip_v1_1_19 questa_lib/msim/axi_vip_v1_1_19

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

vlog -work xpm -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/home/psh/tools/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work lib_cdc_v1_0_3 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_16 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0831/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_proc_sys_reset_0_0/sim/soc_txtlcd_proc_sys_reset_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_clk_wiz_0/soc_txtlcd_clk_wiz_0_clk_wiz.v" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_clk_wiz_0/soc_txtlcd_clk_wiz_0.v" \

vcom -work microblaze_v11_0_14 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/a243/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work microblaze_riscv_v1_0_3 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f9dd/hdl/microblaze_riscv_v1_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_microblaze_riscv_0_0/sim/soc_txtlcd_microblaze_riscv_0_0.vhd" \

vcom -work lmb_v10_v3_0_14 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/7495/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_dlmb_v10_0/sim/soc_txtlcd_dlmb_v10_0.vhd" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_ilmb_v10_0/sim/soc_txtlcd_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_25 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/73e9/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_dlmb_bram_if_cntlr_0/sim/soc_txtlcd_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_ilmb_bram_if_cntlr_0/sim/soc_txtlcd_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_9 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/5ec1/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_lmb_bram_0/sim/soc_txtlcd_lmb_bram_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work mdm_riscv_v1_0_3 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/d547/hdl/mdm_riscv_v1_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_mdm_1_0/sim/soc_txtlcd_mdm_1_0.vhd" \

vcom -work lib_pkg_v1_0_4 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/8c68/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_4 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/1e5a/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_37 -64 -93  \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/9a87/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_uartlite_0_0/sim/soc_txtlcd_axi_uartlite_0_0.vhd" \

vlog -work xlconstant_v1_1_9 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_0/sim/bd_5040_one_0.v" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_1/sim/bd_5040_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_2/sim/bd_5040_arinsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_3/sim/bd_5040_rinsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_4/sim/bd_5040_awinsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_5/sim/bd_5040_winsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_6/sim/bd_5040_binsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_7/sim/bd_5040_aroutsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_8/sim/bd_5040_routsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_9/sim/bd_5040_awoutsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_10/sim/bd_5040_woutsw_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_11/sim/bd_5040_boutsw_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_12/sim/bd_5040_arni_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_13/sim/bd_5040_rni_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_14/sim/bd_5040_awni_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_15/sim/bd_5040_wni_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_16/sim/bd_5040_bni_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f49a/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_17/sim/bd_5040_s00mmu_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_18/sim/bd_5040_s00tr_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/63ed/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_19/sim/bd_5040_s00sic_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_20/sim/bd_5040_s00a2s_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_21/sim/bd_5040_sarn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_22/sim/bd_5040_srn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_23/sim/bd_5040_sawn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_24/sim/bd_5040_swn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_25/sim/bd_5040_sbn_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_26/sim/bd_5040_m00s2a_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_27/sim/bd_5040_m00arn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_28/sim/bd_5040_m00rn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_29/sim/bd_5040_m00awn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_30/sim/bd_5040_m00wn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_31/sim/bd_5040_m00bn_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/37bc/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_32/sim/bd_5040_m00e_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_33/sim/bd_5040_m01s2a_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_34/sim/bd_5040_m01arn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_35/sim/bd_5040_m01rn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_36/sim/bd_5040_m01awn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_37/sim/bd_5040_m01wn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_38/sim/bd_5040_m01bn_0.sv" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/ip/ip_39/sim/bd_5040_m01e_0.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/bd_0/sim/bd_5040.v" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_33 -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3ee4/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_19 -64 -incr -mfcu  -sv -L axi_vip_v1_1_19 -L smartconnect_v1_0 -L xilinx_vip "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/8c45/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/3cbc" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/f0b6/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/0127/hdl/verilog" "+incdir+../../../../project_9.gen/sources_1/bd/soc_txtlcd/ipshared/ec67/hdl" "+incdir+/home/psh/tools/Vivado/2024.2/data/xilinx_vip/include" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_axi_smc_0/sim/soc_txtlcd_axi_smc_0.v" \
"../../../bd/soc_txtlcd/ipshared/3f1b/hdl/myip_iic_txtlcd_slave_lite_v1_0_S00_AXI.v" \
"../../../bd/soc_txtlcd/ipshared/3f1b/src/clock_library.v" \
"../../../bd/soc_txtlcd/ipshared/3f1b/src/controller.v" \
"../../../bd/soc_txtlcd/ipshared/3f1b/src/exam02_sequential_logic.v" \
"../../../bd/soc_txtlcd/ipshared/3f1b/hdl/myip_iic_txtlcd.v" \
"../../../bd/soc_txtlcd/ip/soc_txtlcd_myip_iic_txtlcd_0_0/sim/soc_txtlcd_myip_iic_txtlcd_0_0.v" \
"../../../bd/soc_txtlcd/sim/soc_txtlcd.v" \

vlog -work xil_defaultlib \
"glbl.v"

