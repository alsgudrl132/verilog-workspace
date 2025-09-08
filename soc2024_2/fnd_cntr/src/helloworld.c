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
#include <sys/_intsup.h>
#include <xgpio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"

#define FND_ADDR XPAR_MYIP_FND_0_BASEADDR
#define BTN_ADDR XPAR_AXI_GPIO_BTN_BASEADDR
#define BTN_CHANNEL 1

int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    volatile unsigned int *fnd_addr = (volatile unsigned int*)FND_ADDR;
    uint32_t data = 1234;
    
    XGpio btn_inst;
    XGpio_Initialize(&btn_inst, BTN_ADDR);
    XGpio_SetDataDirection(&btn_inst, BTN_CHANNEL, 0xf);

    uint8_t prev_state = 0;
    while (1) {
        uint32_t btn_data = XGpio_DiscreteRead(&btn_inst, BTN_CHANNEL);
        if(btn_data != 0 && prev_state == 0){
            msleep(1);
            switch (btn_data) {
                case 1: data = data + 1; break;
                case 2: data = data + 2; break;
                case 4: data = data - 1; break;
                case 8: data = data - 2; break;
            }
        }
        fnd_addr[0] = data;
        prev_state = btn_data;
    }

    cleanup_platform();
    return 0;
}
