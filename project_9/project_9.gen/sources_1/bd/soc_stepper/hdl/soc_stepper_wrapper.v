//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Thu Sep 11 15:51:51 2025
//Host        : min running 64-bit Ubuntu 24.04.2 LTS
//Command     : generate_target soc_stepper_wrapper.bd
//Design      : soc_stepper_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module soc_stepper_wrapper
   (dip_switches_16bits_tri_i,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  input [3:0]dip_switches_16bits_tri_i;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire [3:0]dip_switches_16bits_tri_i;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  soc_stepper soc_stepper_i
       (.dip_switches_16bits_tri_i(dip_switches_16bits_tri_i),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
