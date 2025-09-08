//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Mon Sep  8 09:27:28 2025
//Host        : min running 64-bit Ubuntu 24.04.2 LTS
//Command     : generate_target soc_dht11_iic_wrapper.bd
//Design      : soc_dht11_iic_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module soc_dht11_iic_wrapper
   (dht11_data_0,
    iic_rtl_scl_io,
    iic_rtl_sda_io,
    led_0,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  inout dht11_data_0;
  inout iic_rtl_scl_io;
  inout iic_rtl_sda_io;
  output [15:0]led_0;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire dht11_data_0;
  wire iic_rtl_scl_i;
  wire iic_rtl_scl_io;
  wire iic_rtl_scl_o;
  wire iic_rtl_scl_t;
  wire iic_rtl_sda_i;
  wire iic_rtl_sda_io;
  wire iic_rtl_sda_o;
  wire iic_rtl_sda_t;
  wire [15:0]led_0;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  IOBUF iic_rtl_scl_iobuf
       (.I(iic_rtl_scl_o),
        .IO(iic_rtl_scl_io),
        .O(iic_rtl_scl_i),
        .T(iic_rtl_scl_t));
  IOBUF iic_rtl_sda_iobuf
       (.I(iic_rtl_sda_o),
        .IO(iic_rtl_sda_io),
        .O(iic_rtl_sda_i),
        .T(iic_rtl_sda_t));
  soc_dht11_iic soc_dht11_iic_i
       (.dht11_data_0(dht11_data_0),
        .iic_rtl_scl_i(iic_rtl_scl_i),
        .iic_rtl_scl_o(iic_rtl_scl_o),
        .iic_rtl_scl_t(iic_rtl_scl_t),
        .iic_rtl_sda_i(iic_rtl_sda_i),
        .iic_rtl_sda_o(iic_rtl_sda_o),
        .iic_rtl_sda_t(iic_rtl_sda_t),
        .led_0(led_0),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
