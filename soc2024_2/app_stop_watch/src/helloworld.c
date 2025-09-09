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
#include <string.h>
#include <sys/_types.h>
#include <xiic_l.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"
#include "xiic.h"
#include "xgpio.h"
#define IIC_ADDR XPAR_AXI_IIC_0_BASEADDR
#define STOP_WATCH_ADDR XPAR_MYIP_STOP_WATCH_0_BASEADDR
#define BTN_ADDR XPAR_AXI_GPIO_0_BASEADDR
#define BTN_CHANNEL 1


void lcdCommand(uint8_t command)
{
    uint8_t high_nibble, low_nibble;
    uint8_t i2c_buffer[4];
    high_nibble = command & 0xf0;
    low_nibble = (command << 4) & 0xf0;
    i2c_buffer[0] = high_nibble | 0x04 | 0x08;  // en=1, rs=0, rw=0, backlight=1
    i2c_buffer[1] = high_nibble | 0x00 | 0x08;  // en=0, rs=0, rw=0, backlight=1
    i2c_buffer[2] = low_nibble  | 0x04 | 0x08;  // en=1, rs=0, rw=0, backlight=1
    i2c_buffer[3] = low_nibble  | 0x00 | 0x08;  // en=0, rs=0, rw=0, backlight=1
    XIic_Send(IIC_ADDR, 0x27, i2c_buffer, 4, XIIC_STOP);
}

void lcdData(uint8_t data)
{
    uint8_t high_nibble, low_nibble;
    uint8_t i2c_buffer[4];
    high_nibble = data & 0xf0;
    low_nibble = (data << 4) & 0xf0;
    i2c_buffer[0] = high_nibble | 0x05 | 0x08;
    i2c_buffer[1] = high_nibble | 0x01 | 0x08;
    i2c_buffer[2] = low_nibble  | 0x05 | 0x08;
    i2c_buffer[3] = low_nibble  | 0x01 | 0x08;
    XIic_Send(IIC_ADDR, 0x27, i2c_buffer, 4, XIIC_STOP);
}

void lcdInit()
{
    msleep(50);
    lcdCommand(0x33);
    msleep(5);
    lcdCommand(0x32);
    msleep(5);
    lcdCommand(0x28);
    msleep(5);
    lcdCommand(0x0C);
    msleep(5);
    lcdCommand(0x06);
    msleep(5);
    lcdCommand(0x01);
    msleep(2);
}

void lcdString(char *str)
{
    while (*str) lcdData(*str++);
}

void moveCursor(uint8_t row, uint8_t col)
{
    lcdCommand(0x80 | row << 6 | col);
}

void lcdStart(int humi, int temp)
{
    char humiStr[20];
    char tempStr[20];

    sprintf(humiStr, "sec:%d", humi);
    sprintf(tempStr, "csec:%d", temp);

    lcdInit();
    moveCursor(0, 0);
    lcdString(humiStr);
    moveCursor(1, 0);
    lcdString(tempStr);
    sleep(1);
}


int main()
{
    init_platform();

    print("Start\n\r");
    
    XGpio btn_instance;
    XGpio_Initialize(&btn_instance, BTN_ADDR);
    XGpio_SetDataDirection(&btn_instance, BTN_CHANNEL, 0xf);
    XIic iic_instance;
    XIic_Initialize(&iic_instance, IIC_ADDR);
    volatile unsigned int *stop_watch_instatnce = (volatile unsigned int*)STOP_WATCH_ADDR;

    uint32_t btn_data;
    
    while (1) {
        stop_watch_instatnce[0] = 1;
        printf("sec : %d csec : %d\n", stop_watch_instatnce[1], stop_watch_instatnce[2]);
        lcdStart(stop_watch_instatnce[1], stop_watch_instatnce[2]); 
        // btn_data = XGpio_DiscreteRead(&btn_instance, BTN_CHANNEL);
        // sleep(1);
    }
    cleanup_platform();
    return 0;
}

