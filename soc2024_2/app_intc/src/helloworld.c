/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: UART, GPIO 버튼, 인터럽트 테스트 예제
 *
 * - UART Lite를 통한 송수신
 * - 버튼(GPIO) 인터럽트 처리
 * - 인터럽트 컨트롤러(XIntc) 활용
 */

#include <stdio.h>
#include <sys/_intsup.h>
#include <xil_printf.h>
#include <xil_types.h>
#include "platform.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xintc.h"
#include "xuartlite.h"
#include "xil_exception.h"
#include "sleep.h"

// ----------------------------- 하드웨어 매크로 -----------------------------
#define UART_ADDR   XPAR_AXI_UARTLITE_0_BASEADDR   // UART Lite 주소
#define BTN_ADDR    XPAR_XGPIO_0_BASEADDR          // 버튼 GPIO 주소
#define INTC_ADDR   XPAR_XINTC_0_BASEADDR          // 인터럽트 컨트롤러 주소

#define UART_VEC_ID XPAR_FABRIC_AXI_UARTLITE_0_INTR // UART 인터럽트 ID
#define BTN_VECT_ID XPAR_FABRIC_AXI_GPIO_0_INTR     // 버튼 인터럽트 ID

#define BTN_CHANNEL 1   // 버튼이 연결된 GPIO 채널

// ----------------------------- 전역 변수 -----------------------------
XGpio btn_instance;       // 버튼 GPIO 드라이버 인스턴스
XIntc intc_instance;      // 인터럽트 컨트롤러 인스턴스
XUartLite uart_instance;  // UART Lite 인스턴스

// ----------------------------- 함수 선언 -----------------------------
void btn_isr(void *CallBackRef);                             // 버튼 ISR
void RecvHandler(void *CallBackRef, unsigned int EventData); // UART 수신 핸들러
void SendHandler(void *CallBackRef, unsigned int EventData); // UART 송신 핸들러

int main()
{
    init_platform();

    print("Hello World\n\r");
    print("Successfully ran Hello World application\n");

    // ---------------- 드라이버 초기화 ----------------
    XUartLite_Initialize(&uart_instance, UART_ADDR);
    XGpio_Initialize(&btn_instance, BTN_ADDR);
    XIntc_Initialize(&intc_instance, INTC_ADDR);

    // 버튼 GPIO 입력 설정 (채널1, 4비트 모두 입력)
    XGpio_SetDataDirection(&btn_instance, BTN_CHANNEL, 0b1111);

    // ---------------- 인터럽트 연결 ----------------
    XIntc_Connect(&intc_instance, UART_VEC_ID,
                  (XInterruptHandler)XUartLite_InterruptHandler,
                  (void *)&uart_instance);

    XIntc_Connect(&intc_instance, BTN_VECT_ID,
                  (XInterruptHandler)btn_isr,
                  &btn_instance);

    // ---------------- 인터럽트 활성화 ----------------
    XIntc_Enable(&intc_instance, UART_VEC_ID);
    XIntc_Enable(&intc_instance, BTN_VECT_ID);
    XIntc_Start(&intc_instance, XIN_REAL_MODE);

    XGpio_InterruptEnable(&btn_instance, BTN_CHANNEL);
    XGpio_InterruptGlobalEnable(&btn_instance);

    // ---------------- UART 콜백 등록 ----------------
    XUartLite_SetRecvHandler(&uart_instance, RecvHandler, &uart_instance);
    XUartLite_SetSendHandler(&uart_instance, SendHandler, &uart_instance);
    XUartLite_EnableInterrupt(&uart_instance);

    // ---------------- 예외 처리기 등록 ----------------
    Xil_ExceptionInit();
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
                                 (Xil_ExceptionHandler)XIntc_InterruptHandler,
                                 &intc_instance);
    Xil_ExceptionEnable();

    // ---------------- 메인 루프 ----------------
    while (1) {
        // 메인 루프는 대기 상태 (모든 이벤트는 인터럽트로 처리됨)
    }

    cleanup_platform();
    return 0;
}

// ----------------------------- ISR / 콜백 함수 -----------------------------

// 버튼 인터럽트 서비스 루틴
void btn_isr(void *CallBackRef) {
    XGpio *Gpio_ptr = (XGpio *)CallBackRef;
    unsigned int btn_value = XGpio_DiscreteRead(Gpio_ptr, BTN_CHANNEL);

    if (btn_value == 1) {
        print("Button 0 rising\n");
    } else if (btn_value == 0) {
        print("Button 1 falling\n");
    }

    print("Button interrupt\n");
    XGpio_InterruptClear(Gpio_ptr, BTN_CHANNEL);
}

// UART 수신 완료 시 호출
void RecvHandler(void *CallBackRef, unsigned int EventData)
{
    u8 rxData;
    XUartLite_Recv(CallBackRef, &rxData, 1);
    printf("recv %c\n", rxData);
}

// UART 송신 완료 시 호출
void SendHandler(void *CallBackRef, unsigned int EventData)
{
    return;
}
