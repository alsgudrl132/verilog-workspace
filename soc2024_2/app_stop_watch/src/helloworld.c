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
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"
#include "xiic.h"
#include "xgpio.h"
#define BTN_ADDR XPAR_XGPIO_0_BASEADDR
#define IIC2_ADDR XPAR_AXI_IIC_0_BASEADDR
#define STOP_WATCH_ADDR XPAR_MYIP_STOP_WATCH_0_BASEADDR
#define BTN_CHANNEL 1



void lcdCommand(uint8_t command)
{
    uint8_t high_nibble, low_nibble;
    uint8_t i2c_buffer[4];
    high_nibble = command & 0xf0;
    low_nibble = (command << 4) & 0xf0;
    i2c_buffer[0] = high_nibble | 0x04 | 0x08; // en=1, rs=0, rw=0, backlight=1
    i2c_buffer[1] = high_nibble | 0x00 | 0x08; // en=0, rs=0, rw=0, backlight=1
    i2c_buffer[2] = low_nibble | 0x04 | 0x08; // en=1, rs=0, rw=0, backlight=1
    i2c_buffer[3] = low_nibble | 0x00 | 0x08; // en=0, rs=0, rw=0, backlight=1
    XIic_Send(IIC2_ADDR, 0x27, i2c_buffer, 4, XIIC_STOP);
}


void lcdData(uint8_t data)
{
    uint8_t high_nibble, low_nibble;
    uint8_t i2c_buffer[4];
    high_nibble = data & 0xf0;
    low_nibble = (data << 4) & 0xf0;
    i2c_buffer[0] = high_nibble | 0x05 | 0x08;
    i2c_buffer[1] = high_nibble | 0x01 | 0x08;
    i2c_buffer[2] = low_nibble | 0x05 | 0x08;
    i2c_buffer[3] = low_nibble | 0x01 | 0x08;
    XIic_Send(IIC2_ADDR, 0x27, i2c_buffer, 4, XIIC_STOP);
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

    print("Hello World\n\r");
    print("Successfully ran Hello World application");

    XGpio btn_instance;

    XGpio_Initialize(&btn_instance, BTN_ADDR);
    XGpio_SetDataDirection(&btn_instance, BTN_CHANNEL, 0b1111);
    XIic iic_intance;
    XIic_Initialize(&iic_intance, IIC2_ADDR);
    volatile unsigned int*stopwatch_instance = (volatile unsigned int*) STOP_WATCH_ADDR;

    unsigned int data = 0;
       uint32_t btn_data;
    uint32_t prev_btn_state = 0;
    int is_running = 0;   

    // ★ 랩 타임 저장 변수
    int lap_time_sec = 0;
    int lap_time_csec = 0;
    int lap_time_min = 0;
uint32_t lap_cnt = 0;
    lcdInit();
    lcdString("00:00");

    while (1) {
        btn_data = XGpio_DiscreteRead(&btn_instance, BTN_CHANNEL); 

        if (btn_data != 0 && prev_btn_state == 0) {
            switch (btn_data) {
                case 1:  // ★ 스타트/스탑 토글
                    is_running = !is_running;
                    break;

                case 2:  // ★ 랩
                   stopwatch_instance[0] = 2;  // lap_btn 활성화
                    msleep(10);
                    stopwatch_instance[0] = 0;
                    
                    // 현재 시간을 랩타임으로 저장
                    lap_time_sec = stopwatch_instance[1];
                    lap_time_csec = stopwatch_instance[2];
                    lap_time_min = stopwatch_instance[6];
                    
                    // 랩 카운트 증가 (0→1→0 순환)
                    lap_cnt = (lap_cnt + 1) % 2;
                    break;

                case 4:  // ★ 클리어 (리셋)
                   stopwatch_instance[0] = 4;  // clear_btn 활성화
                    msleep(10);
                    stopwatch_instance[0] = 0;
                    
                    // 모든 변수 리셋
                    lap_time_sec = 0;
                    lap_time_csec = 0;
                    is_running = 0;
                    lap_cnt = 0;
                    
                    // LCD 즉시 갱신
                    moveCursor(0, 0);
                    lcdString("00:00");
                    moveCursor(1, 0);
                    lcdString("        "); // 두 번째 줄 지우기
                    moveCursor(1, 8);
                     lcdString("        "); // 두 번째 줄 지우기
                    break;

                case 8:  // 미사용 (추가 기능 가능)
                    break;
            }
            msleep(1); // 디바운싱
        }
        prev_btn_state = btn_data;

        // ★ 동작 여부 반영
        stopwatch_instance[0] = is_running;

        // 현재 시간 출력
        moveCursor(0, 0);
        lcdData(stopwatch_instance[5] / 10 % 10 + '0');
        lcdData(stopwatch_instance[5] % 10 + '0');
        lcdData(':');
        lcdData(stopwatch_instance[1] / 10 % 10 + '0');
        lcdData(stopwatch_instance[1] % 10 + '0');
        lcdData(':');
        lcdData(stopwatch_instance[2] / 10 % 10 + '0');
        lcdData(stopwatch_instance[2] % 10 + '0');

        // 랩 타임 출력
        if (lap_cnt == 0 && (lap_time_sec > 0 || lap_time_csec > 0 || lap_time_min > 0)) {
            // 첫 번째 랩타임 출력 (왼쪽)
            moveCursor(1, 0);
            lcdData(lap_time_min / 10 % 10 + '0');
            lcdData(lap_time_min % 10 + '0');
            lcdData(':');
            lcdData(lap_time_sec / 10 % 10 + '0');
            lcdData(lap_time_sec % 10 + '0');
            lcdData(':');
            lcdData(lap_time_csec / 10 % 10 + '0');
            lcdData(lap_time_csec % 10 + '0');
        }
        else if (lap_cnt == 1 && (lap_time_sec > 0 || lap_time_csec > 0 || lap_time_min > 0)) {
            // 두 번째 랩타임 출력 (오른쪽)
            moveCursor(1, 8);
            lcdData(lap_time_min / 10 % 10 + '0');
            lcdData(lap_time_min % 10 + '0');
            lcdData(':');
            lcdData(lap_time_sec / 10 % 10 + '0');
            lcdData(lap_time_sec % 10 + '0');
            lcdData(':');
            lcdData(lap_time_csec / 10 % 10 + '0');
            lcdData(lap_time_csec % 10 + '0');
        }

        msleep(1);
    }

    cleanup_platform();
    return 0;
}