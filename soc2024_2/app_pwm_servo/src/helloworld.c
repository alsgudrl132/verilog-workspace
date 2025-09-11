/*
 * servo_control.c: 서보모터 제어 (펄스폭 기반)
 * 
 * PWM 설정 분석:
 * - 시스템 클럭: 100MHz
 * - PWM 주파수: 50Hz (20ms 주기)  
 * - 분해능: 200 스텝
 * - 각 스텝: 20ms / 200 = 0.1ms = 100us
 * 
 * 서보모터 제어:
 * - 0도: 1ms → 10 스텝
 * - 90도: 1.5ms → 15 스텝  
 * - 180도: 2ms → 20 스텝
 */

#include <stdint.h>
#include <stdio.h>
#include <sys/_types.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"

#define PWM_ADDR XPAR_MYIP_PWM_0_BASEADDR

// 서보 위치 정의 (펄스폭 기준)
#define SERVO_MIN    10    // 1ms (0도)
#define SERVO_CENTER 15    // 1.5ms (90도)  
#define SERVO_MAX    20    // 2ms (180도)

int main()
{
    init_platform();
    print("Servo Motor Control - Pulse Width Based\n\r");
    print("Min: 10 (1ms), Center: 15 (1.5ms), Max: 20 (2ms)\n\r");
    
    volatile unsigned int *pwm_reg = (volatile unsigned int*)PWM_ADDR;
    
    // 초기화: 중앙 위치
    pwm_reg[0] = SERVO_CENTER;
    print("Servo initialized to center position\n\r");
    msleep(2000);
    
    while (1) {
        // 0도로 이동
        print("Moving to 0 degrees (1ms pulse)\n\r");
        pwm_reg[0] = SERVO_MIN;
        msleep(2000);
        
        // 90도로 이동  
        print("Moving to 90 degrees (1.5ms pulse)\n\r");
        pwm_reg[0] = SERVO_CENTER;
        msleep(2000);
        
        // 180도로 이동
        print("Moving to 180 degrees (2ms pulse)\n\r");
        pwm_reg[0] = SERVO_MAX;
        msleep(2000);
        
        // 다시 중앙으로
        print("Back to center (90 degrees)\n\r");
        pwm_reg[0] = SERVO_CENTER;
        msleep(2000);
    }
    
    cleanup_platform();
    return 0;
}