# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "/home/psh/work/soc2024_2/platform_txtlcd/microblaze_riscv_0/standalone_microblaze_riscv_0/bsp/include/sleep.h"
  "/home/psh/work/soc2024_2/platform_txtlcd/microblaze_riscv_0/standalone_microblaze_riscv_0/bsp/include/xiltimer.h"
  "/home/psh/work/soc2024_2/platform_txtlcd/microblaze_riscv_0/standalone_microblaze_riscv_0/bsp/include/xtimer_config.h"
  "/home/psh/work/soc2024_2/platform_txtlcd/microblaze_riscv_0/standalone_microblaze_riscv_0/bsp/lib/libxiltimer.a"
  )
endif()
