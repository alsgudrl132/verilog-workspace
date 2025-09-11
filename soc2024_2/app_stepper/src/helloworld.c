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
/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * stepper_motor.c: 28BYJ-48 스테핑 모터 제어 애플리케이션
 */
#include <stdint.h>
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xgpio.h"
#include "sleep.h"

#define GPIO_ADDR XPAR_AXI_GPIO_0_BASEADDR
#define STEPPER_CHANNEL 1

// Half-step 시퀀스 (더 부드러운 회전)
static const uint8_t HALF_STEP_SEQ[8] = {
    0x01,  // 0001 - IN1=1, IN2=0, IN3=0, IN4=0
    0x03,  // 0011 - IN1=1, IN2=1, IN3=0, IN4=0
    0x02,  // 0010 - IN1=0, IN2=1, IN3=0, IN4=0
    0x06,  // 0110 - IN1=0, IN2=1, IN3=1, IN4=0
    0x04,  // 0100 - IN1=0, IN2=0, IN3=1, IN4=0
    0x0C,  // 1100 - IN1=0, IN2=0, IN3=1, IN4=1
    0x08,  // 1000 - IN1=0, IN2=0, IN3=0, IN4=1
    0x09   // 1001 - IN1=1, IN2=0, IN3=0, IN4=1
};

void stepMotor(XGpio *gpio_instance, uint8_t step)
{
    // 4개 핀을 한번에 제어 (하위 4비트 사용)
    XGpio_DiscreteWrite(gpio_instance, STEPPER_CHANNEL, HALF_STEP_SEQ[step]);
}

void rotateSteps(XGpio *gpio_instance, int steps, int delay_ms, int direction)
{
    int step_index = 0;
    
    for(int i = 0; i < steps; i++) {
        stepMotor(gpio_instance, step_index);
        
        // 다음 스텝 계산
        if(direction == 1) {  // 시계방향
            step_index = (step_index + 1) % 8;
        } else {              // 반시계방향
            step_index = (step_index - 1 + 8) % 8;
        }
        
        usleep(delay_ms * 1000);  // 마이크로초 단위 딜레이
    }
    
    // 모터 정지 (모든 코일 OFF)
    XGpio_DiscreteWrite(gpio_instance, STEPPER_CHANNEL, 0x00);
}

int main()
{
    init_platform();
    
    XGpio gpio_instance;  
    
    // GPIO 초기화
    int status = XGpio_Initialize(&gpio_instance, GPIO_ADDR);
    if(status != XST_SUCCESS) {
        print("GPIO 초기화 실패\n\r");
        return -1;
    }
    
    // 채널 1의 모든 핀을 출력으로 설정
    XGpio_SetDataDirection(&gpio_instance, STEPPER_CHANNEL, 0x0000);
    
    print("28BYJ-48 스테핑 모터 제어 시작\n\r");
    
    while(1) {
        print("시계방향 1회전 (약 512스텝)\n\r");
        rotateSteps(&gpio_instance, 512, 2, 1);  // 시계방향, 2ms 딜레이
        sleep(2);  // 2초 대기
    }
    
    cleanup_platform();
    return 0;
}