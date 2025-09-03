/******************************************************************************
 * Copyright (C) 2023 Advanced Micro Devices, Inc.
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

#include "platform.h"
#include "sleep.h"
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include <stdint.h>
#include <stdio.h>

/* 버튼 GPIO */
#define BTN_ADDR XPAR_AXI_GPIO_BTN_BASEADDR
#define BTN_CHANNEL 1

/* FND GPIO */
#define FND_ADDR XPAR_AXI_GPIO_FND_BASEADDR
#define COM_CHANNEL 1
#define SEG_CHANNEL 2

/* 7-Segment 숫자 패턴 (공통 애노드 기준) */
volatile unsigned int FND_font[16] = {
    0b11000000, 0b11111001, 0b10100100, 0b10110000,
    0b10011001, 0b10010010, 0b10000010, 0b11111000,
    0b10000000, 0b10010000, 0b10001000, 0b00000011,
    0b11000110, 0b10100001, 0b10000110, 0b10001110};

/* 4자리 FND 자리 선택 (COM) */
volatile unsigned int FND_digit[4] = {
    0b1110, 0b1101, 0b1011, 0b0111};

/* 표시 데이터 저장 */
volatile unsigned FND[4];

/* 숫자를 4자리로 분해하여 FND 배열에 저장 */
void FnD_update(unsigned int data) {
    FND[0] = FND_font[data % 10];
    FND[1] = FND_font[(data / 10) % 10];
    FND[2] = FND_font[(data / 100) % 10];
    FND[3] = FND_font[(data / 1000) % 10];
}

int main() {
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application\n\r");

    XGpio btn_inst, fnd_inst;

    /* 버튼 GPIO 초기화 (입력) */
    XGpio_Initialize(&btn_inst, BTN_ADDR);
    XGpio_SetDataDirection(&btn_inst, BTN_CHANNEL, 0xf);

    /* FND GPIO 초기화 (출력) */
    XGpio_Initialize(&fnd_inst, FND_ADDR);
    XGpio_SetDataDirection(&fnd_inst, COM_CHANNEL, 0);
    XGpio_SetDataDirection(&fnd_inst, SEG_CHANNEL, 0);

    uint32_t btn_data;
    uint32_t prev_btn_data = 0;
    uint32_t data = 2468;

    while (1) {
        /* FND 4자리 순차 점등 (멀티플렉싱) */
        for (uint8_t i = 0; i < 4; i++) {
            XGpio_DiscreteWrite(&fnd_inst, COM_CHANNEL, FND_digit[i]);
            XGpio_DiscreteWrite(&fnd_inst, SEG_CHANNEL, FND[i]);
            msleep(1);
        }

        /* 버튼 입력 읽기 */
        btn_data = XGpio_DiscreteRead(&btn_inst, BTN_CHANNEL);
        printf("btn_data = %d\n", btn_data);

        /* 버튼이 새로 눌렸을 때만 동작 (엣지 검출) */
        if (btn_data != 0 && prev_btn_data == 0) {
            msleep(1); // 디바운스
            if (btn_data == 1) {
                data = data + 1;   // 업 버튼
            } else if (btn_data == 2) {
                data = data + 2;   // 왼쪽 버튼
            } else if (btn_data == 4) {
                data = data - 2;   // 오른쪽 버튼
            } else if (btn_data == 8) {
                data = data - 1;   // 아래 버튼
            }
        }

        /* 변경된 값 갱신 */
        FnD_update(data);
        prev_btn_data = btn_data;
    }

    cleanup_platform();
    return 0;
}
