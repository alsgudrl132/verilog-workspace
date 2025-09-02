//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Tue Sep  2 12:42:00 2025
//Host        : min running 64-bit Ubuntu 24.04.2 LTS
//Command     : generate_target soc_hello_wrapper.bd
//Design      : soc_hello_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module soc_hello_wrapper
   (dip_switches_16bits_tri_i,
    led_16bits_tri_o,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  input [15:0]dip_switches_16bits_tri_i;
  output [15:0]led_16bits_tri_o;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire [15:0]dip_switches_16bits_tri_i;
  wire [15:0]led_16bits_tri_o;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  soc_hello soc_hello_i
       (.dip_switches_16bits_tri_i(dip_switches_16bits_tri_i),
        .led_16bits_tri_o(led_16bits_tri_o),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
