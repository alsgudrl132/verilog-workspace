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

#define DHT_11_ADDR XPAR_MYIP_DHT11_0_BASEADDR

int add(a,b) {
    int result = a + b;
    return result;
}

int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    volatile unsigned int *dht_11_addr = (volatile unsigned int*)DHT_11_ADDR;

    while (1) {
        printf("humi : %d\n", dht_11_addr[0]);
        printf("temp : %d\n", dht_11_addr[1]);
        sleep(1);
    }
    cleanup_platform();
    return 0;
}