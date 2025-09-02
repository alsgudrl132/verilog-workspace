/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: 간단한 GPIO 테스트 애플리케이션
 *
 * - AXI GPIO를 통해 LED를 제어하고 스위치 입력을 읽는 예제
 * - PS7 UART는 이미 BootROM/BSP에서 115200으로 설정되어 있음
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"
#include "xgpio.h"

// Vivado에서 생성한 GPIO IP 주소 및 채널 정의
#define GPIO_ADDR XPAR_AXI_GPIO_LED_SW_BASEADDR // GPIO Base Address
#define LED_CHANNEL 1                           // LED 연결 채널
#define SW_CHANNEL  2                           // 스위치 연결 채널

int main()
{
    init_platform(); 
    // 보드 초기화 (UART, 인터럽트, 캐시 등 기본 세팅)

    print("Hello World\n\r");  
    print("Successfully ran Hello World application\n\r");

    XGpio gpio_device;  
    XGpio_Initialize(&gpio_device, GPIO_ADDR); 
    // GPIO 장치 초기화 및 Base Address와 연결

    // LED 채널을 출력으로 설정 (0 = 출력, 1 = 입력)
    XGpio_SetDataDirection(&gpio_device, LED_CHANNEL, 0x0000); 
    // 0x0000 → 모든 핀을 출력 모드로 지정
    // → LED 제어용 채널이므로 출력으로 설정 필요

    // LED에 초기 값 출력
    XGpio_DiscreteWrite(&gpio_device, LED_CHANNEL, 0xAC0F); 
    // 0xAC0F (2진수: 1010 1100 0000 1111)
    // → 각 비트에 따라 LED 켜짐/꺼짐 설정

    // 스위치 채널을 입력으로 설정 (0 = 출력, 1 = 입력)
    XGpio_SetDataDirection(&gpio_device, SW_CHANNEL, 0xFFFF); 
    // 0xFFFF → 모든 핀을 입력 모드로 지정

    u32 data; // 스위치 상태 저장 변수

    while (1) {
        print("Hello\n"); 
        sleep(1); // 1초마다 "Hello" 출력

        // 스위치 상태 읽기
        data = XGpio_DiscreteRead(&gpio_device, SW_CHANNEL);
        printf("switch : %x\n", data);

        // 읽은 스위치 값을 LED에 출력 (LED 따라 켜짐/꺼짐)
        XGpio_DiscreteWrite(&gpio_device, LED_CHANNEL, data); 
    }
    
    cleanup_platform(); 
    // 보드 종료 처리
    return 0;
}
