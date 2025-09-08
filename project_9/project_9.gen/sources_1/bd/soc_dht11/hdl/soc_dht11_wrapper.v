//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Fri Sep  5 09:33:52 2025
//Host        : min running 64-bit Ubuntu 24.04.2 LTS
//Command     : generate_target soc_dht11_wrapper.bd
//Design      : soc_dht11_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module soc_dht11_wrapper
   (dht11_data_0,
    led_0,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  inout dht11_data_0;
  output [15:0]led_0;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire dht11_data_0;
  wire [15:0]led_0;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  soc_dht11 soc_dht11_i
       (.dht11_data_0(dht11_data_0),
        .led_0(led_0),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
