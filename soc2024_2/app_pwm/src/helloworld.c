/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdint.h>
#include <stdio.h>
#include <sys/_types.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"
#define PWM_ADDR XPAR_MYIP_PWM_0_BASEADDR


int main()
{
    init_platform();
    print("PWM RGB Blue Breathing\n\r");
    
    volatile unsigned int *pwm_reg = (volatile unsigned int*)PWM_ADDR;
    uint8_t pwm_direction = 0;  // 0: 증가, 1: 감소
    
    while (1) {
        if (!pwm_direction) {
            // 증가 모드
            pwm_reg[0] = pwm_reg[0] + 1;
            
            if (pwm_reg[0] >= 0x000000f0) {
                pwm_direction = 1;  // 감소 모드로 전환
            }
        } else {
            // 감소 모드  
            pwm_reg[0] = pwm_reg[0] - 1;
            
            if (pwm_reg[0] <= 0) {
                pwm_direction = 0;  // 증가 모드로 전환
            }
        }
        
        msleep(5);
    }
    
    cleanup_platform();
    return 0;
}