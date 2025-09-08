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

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"

#define DHT11_ADDR XPAR_MYIP_DHT11_0_BASEADDR
#define FND_ADDR XPAR_MYIP_FND_0_BASEADDR

int main()
{
    init_platform();

    volatile unsigned int *dht11_inst = (volatile unsigned int*)DHT11_ADDR;
    volatile unsigned int *fnd_addr = (volatile unsigned int*)FND_ADDR;
    
    while (1) {
        fnd_addr[0] = dht11_inst[0];
    }
    
    cleanup_platform();
    return 0;
}
