/*****************************************************************************
 * Copyright (c) 2018 Rowley Associates Limited.                             *
 *                                                                           *
 * This file may be distributed under the terms of the License Agreement     *
 * provided with this software.                                              *
 *                                                                           *
 * THIS FILE IS PROVIDED AS IS WITH NO WARRANTY OF ANY KIND, INCLUDING THE   *
 * WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. *
 *                                                                           *
 *****************************************************************************/

/*****************************************************************************
 *                         Preprocessor Definitions                          *
 *                         ------------------------                          *
 * STARTUP_FROM_RESET                                                        *
 *                                                                           *
 *   If defined, the program will startup from power-on/reset. If not        *
 *   defined the program will just loop endlessly from power-on/reset.       *
 *                                                                           *
 * VECTORS_IN_RAM                                                            *
 *                                                                           *
 *   If defined, an area of RAM will large enough to store the vector table  *
 *   will be reserved.                                                       *
 *                                                                           *
 *****************************************************************************/

  .syntax unified
  .code 16

  .section .init, "ax"
  .align 2

/*****************************************************************************
 * Default Exception Handlers                                                *
 *****************************************************************************/

#ifndef STARTUP_FROM_RESET

  .thumb_func
  .weak Reset_Wait
Reset_Wait:
  b .

#endif

  .thumb_func
  .weak NMI_Handler
NMI_Handler:
  b .

  .thumb_func
  .weak HardFault_Handler
HardFault_Handler:
  b .

  .thumb_func
  .weak SVC_Handler
SVC_Handler:
  b .

  .thumb_func
  .weak PendSV_Handler
PendSV_Handler:
  b .

  .thumb_func
  .weak SysTick_Handler
SysTick_Handler:
  b .

  .thumb_func
Dummy_Handler:
  b .

#if defined(__OPTIMIZATION_SMALL)

  .weak PF_IRQHandler
  .thumb_set PF_IRQHandler,Dummy_Handler

  .weak WDT0_IRQHandler
  .thumb_set WDT0_IRQHandler,Dummy_Handler

  .weak RSV00_IRQHandler
  .thumb_set RSV00_IRQHandler,Dummy_Handler

  .weak RTC_IRQHandler
  .thumb_set RTC_IRQHandler,Dummy_Handler

  .weak RSV01_IRQHandler
  .thumb_set RSV01_IRQHandler,Dummy_Handler

  .weak TMR0_IRQHandler
  .thumb_set TMR0_IRQHandler,Dummy_Handler

  .weak TMR1_IRQHandler
  .thumb_set TMR1_IRQHandler,Dummy_Handler

  .weak TMR2_IRQHandler
  .thumb_set TMR2_IRQHandler,Dummy_Handler

  .weak RSV02_IRQHandler
  .thumb_set RSV02_IRQHandler,Dummy_Handler

  .weak RSV03_IRQHandler
  .thumb_set RSV03_IRQHandler,Dummy_Handler

  .weak RSV04_IRQHandler
  .thumb_set RSV04_IRQHandler,Dummy_Handler

  .weak RSV05_IRQHandler
  .thumb_set RSV05_IRQHandler,Dummy_Handler

  .weak RSV06_IRQHandler
  .thumb_set RSV06_IRQHandler,Dummy_Handler

  .weak I2C0_IRQHandler
  .thumb_set I2C0_IRQHandler,Dummy_Handler

  .weak UART0_IRQHandler
  .thumb_set UART0_IRQHandler,Dummy_Handler

  .weak UART1_IRQHandler
  .thumb_set UART1_IRQHandler,Dummy_Handler

  .weak SPI0_IRQHandler
  .thumb_set SPI0_IRQHandler,Dummy_Handler

  .weak SPI1_IRQHandler
  .thumb_set SPI1_IRQHandler,Dummy_Handler

  .weak RSV07_IRQHandler
  .thumb_set RSV07_IRQHandler,Dummy_Handler

  .weak RSV08_IRQHandler
  .thumb_set RSV08_IRQHandler,Dummy_Handler

  .weak RSV09_IRQHandler
  .thumb_set RSV09_IRQHandler,Dummy_Handler

  .weak RSV10_IRQHandler
  .thumb_set RSV10_IRQHandler,Dummy_Handler

  .weak RSV11_IRQHandler
  .thumb_set RSV11_IRQHandler,Dummy_Handler

  .weak FLC_IRQHandler
  .thumb_set FLC_IRQHandler,Dummy_Handler

  .weak GPIO0_IRQHandler
  .thumb_set GPIO0_IRQHandler,Dummy_Handler

  .weak RSV12_IRQHandler
  .thumb_set RSV12_IRQHandler,Dummy_Handler

  .weak RSV13_IRQHandler
  .thumb_set RSV13_IRQHandler,Dummy_Handler

  .weak RSV14_IRQHandler
  .thumb_set RSV14_IRQHandler,Dummy_Handler

  .weak DMA0_IRQHandler
  .thumb_set DMA0_IRQHandler,Dummy_Handler

  .weak DMA1_IRQHandler
  .thumb_set DMA1_IRQHandler,Dummy_Handler

  .weak DMA2_IRQHandler
  .thumb_set DMA2_IRQHandler,Dummy_Handler

  .weak DMA3_IRQHandler
  .thumb_set DMA3_IRQHandler,Dummy_Handler

  .weak RSV15_IRQHandler
  .thumb_set RSV15_IRQHandler,Dummy_Handler

  .weak RSV16_IRQHandler
  .thumb_set RSV16_IRQHandler,Dummy_Handler

  .weak RSV17_IRQHandler
  .thumb_set RSV17_IRQHandler,Dummy_Handler

  .weak RSV18_IRQHandler
  .thumb_set RSV18_IRQHandler,Dummy_Handler

  .weak I2C1_IRQHandler
  .thumb_set I2C1_IRQHandler,Dummy_Handler

  .weak RSV19_IRQHandler
  .thumb_set RSV19_IRQHandler,Dummy_Handler

  .weak RSV20_IRQHandler
  .thumb_set RSV20_IRQHandler,Dummy_Handler

  .weak RSV21_IRQHandler
  .thumb_set RSV21_IRQHandler,Dummy_Handler

  .weak RSV22_IRQHandler
  .thumb_set RSV22_IRQHandler,Dummy_Handler

  .weak RSV23_IRQHandler
  .thumb_set RSV23_IRQHandler,Dummy_Handler

  .weak RSV24_IRQHandler
  .thumb_set RSV24_IRQHandler,Dummy_Handler

  .weak RSV25_IRQHandler
  .thumb_set RSV25_IRQHandler,Dummy_Handler

  .weak RSV26_IRQHandler
  .thumb_set RSV26_IRQHandler,Dummy_Handler

  .weak RSV27_IRQHandler
  .thumb_set RSV27_IRQHandler,Dummy_Handler

  .weak RSV28_IRQHandler
  .thumb_set RSV28_IRQHandler,Dummy_Handler

  .weak RSV29_IRQHandler
  .thumb_set RSV29_IRQHandler,Dummy_Handler

  .weak RSV30_IRQHandler
  .thumb_set RSV30_IRQHandler,Dummy_Handler

  .weak RSV31_IRQHandler
  .thumb_set RSV31_IRQHandler,Dummy_Handler

  .weak RSV32_IRQHandler
  .thumb_set RSV32_IRQHandler,Dummy_Handler

  .weak RSV33_IRQHandler
  .thumb_set RSV33_IRQHandler,Dummy_Handler

  .weak RSV34_IRQHandler
  .thumb_set RSV34_IRQHandler,Dummy_Handler

  .weak RSV35_IRQHandler
  .thumb_set RSV35_IRQHandler,Dummy_Handler

  .weak GPIOWAKE_IRQHandler
  .thumb_set GPIOWAKE_IRQHandler,Dummy_Handler

#else

  .thumb_func
  .weak PF_IRQHandler
PF_IRQHandler:
  b .

  .thumb_func
  .weak WDT0_IRQHandler
WDT0_IRQHandler:
  b .

  .thumb_func
  .weak RSV00_IRQHandler
RSV00_IRQHandler:
  b .

  .thumb_func
  .weak RTC_IRQHandler
RTC_IRQHandler:
  b .

  .thumb_func
  .weak RSV01_IRQHandler
RSV01_IRQHandler:
  b .

  .thumb_func
  .weak TMR0_IRQHandler
TMR0_IRQHandler:
  b .

  .thumb_func
  .weak TMR1_IRQHandler
TMR1_IRQHandler:
  b .

  .thumb_func
  .weak TMR2_IRQHandler
TMR2_IRQHandler:
  b .

  .thumb_func
  .weak RSV02_IRQHandler
RSV02_IRQHandler:
  b .

  .thumb_func
  .weak RSV03_IRQHandler
RSV03_IRQHandler:
  b .

  .thumb_func
  .weak RSV04_IRQHandler
RSV04_IRQHandler:
  b .

  .thumb_func
  .weak RSV05_IRQHandler
RSV05_IRQHandler:
  b .

  .thumb_func
  .weak RSV06_IRQHandler
RSV06_IRQHandler:
  b .

  .thumb_func
  .weak I2C0_IRQHandler
I2C0_IRQHandler:
  b .

  .thumb_func
  .weak UART0_IRQHandler
UART0_IRQHandler:
  b .

  .thumb_func
  .weak UART1_IRQHandler
UART1_IRQHandler:
  b .

  .thumb_func
  .weak SPI0_IRQHandler
SPI0_IRQHandler:
  b .

  .thumb_func
  .weak SPI1_IRQHandler
SPI1_IRQHandler:
  b .

  .thumb_func
  .weak RSV07_IRQHandler
RSV07_IRQHandler:
  b .

  .thumb_func
  .weak RSV08_IRQHandler
RSV08_IRQHandler:
  b .

  .thumb_func
  .weak RSV09_IRQHandler
RSV09_IRQHandler:
  b .

  .thumb_func
  .weak RSV10_IRQHandler
RSV10_IRQHandler:
  b .

  .thumb_func
  .weak RSV11_IRQHandler
RSV11_IRQHandler:
  b .

  .thumb_func
  .weak FLC_IRQHandler
FLC_IRQHandler:
  b .

  .thumb_func
  .weak GPIO0_IRQHandler
GPIO0_IRQHandler:
  b .

  .thumb_func
  .weak RSV12_IRQHandler
RSV12_IRQHandler:
  b .

  .thumb_func
  .weak RSV13_IRQHandler
RSV13_IRQHandler:
  b .

  .thumb_func
  .weak RSV14_IRQHandler
RSV14_IRQHandler:
  b .

  .thumb_func
  .weak DMA0_IRQHandler
DMA0_IRQHandler:
  b .

  .thumb_func
  .weak DMA1_IRQHandler
DMA1_IRQHandler:
  b .

  .thumb_func
  .weak DMA2_IRQHandler
DMA2_IRQHandler:
  b .

  .thumb_func
  .weak DMA3_IRQHandler
DMA3_IRQHandler:
  b .

  .thumb_func
  .weak RSV15_IRQHandler
RSV15_IRQHandler:
  b .

  .thumb_func
  .weak RSV16_IRQHandler
RSV16_IRQHandler:
  b .

  .thumb_func
  .weak RSV17_IRQHandler
RSV17_IRQHandler:
  b .

  .thumb_func
  .weak RSV18_IRQHandler
RSV18_IRQHandler:
  b .

  .thumb_func
  .weak I2C1_IRQHandler
I2C1_IRQHandler:
  b .

  .thumb_func
  .weak RSV19_IRQHandler
RSV19_IRQHandler:
  b .

  .thumb_func
  .weak RSV20_IRQHandler
RSV20_IRQHandler:
  b .

  .thumb_func
  .weak RSV21_IRQHandler
RSV21_IRQHandler:
  b .

  .thumb_func
  .weak RSV22_IRQHandler
RSV22_IRQHandler:
  b .

  .thumb_func
  .weak RSV23_IRQHandler
RSV23_IRQHandler:
  b .

  .thumb_func
  .weak RSV24_IRQHandler
RSV24_IRQHandler:
  b .

  .thumb_func
  .weak RSV25_IRQHandler
RSV25_IRQHandler:
  b .

  .thumb_func
  .weak RSV26_IRQHandler
RSV26_IRQHandler:
  b .

  .thumb_func
  .weak RSV27_IRQHandler
RSV27_IRQHandler:
  b .

  .thumb_func
  .weak RSV28_IRQHandler
RSV28_IRQHandler:
  b .

  .thumb_func
  .weak RSV29_IRQHandler
RSV29_IRQHandler:
  b .

  .thumb_func
  .weak RSV30_IRQHandler
RSV30_IRQHandler:
  b .

  .thumb_func
  .weak RSV31_IRQHandler
RSV31_IRQHandler:
  b .

  .thumb_func
  .weak RSV32_IRQHandler
RSV32_IRQHandler:
  b .

  .thumb_func
  .weak RSV33_IRQHandler
RSV33_IRQHandler:
  b .

  .thumb_func
  .weak RSV34_IRQHandler
RSV34_IRQHandler:
  b .

  .thumb_func
  .weak RSV35_IRQHandler
RSV35_IRQHandler:
  b .

  .thumb_func
  .weak GPIOWAKE_IRQHandler
GPIOWAKE_IRQHandler:
  b .

#endif

/*****************************************************************************
 * Vector Table                                                              *
 *****************************************************************************/

  .section .vectors, "ax"
  .align 2
  .global _vectors
  .extern __stack_end__
#ifdef STARTUP_FROM_RESET
  .extern Reset_Handler
#endif

_vectors:
  .word __stack_end__
#ifdef STARTUP_FROM_RESET
  .word Reset_Handler
#else
  .word Reset_Wait
#endif
  .word NMI_Handler
  .word HardFault_Handler
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word SVC_Handler
  .word 0 /* Reserved */
  .word 0 /* Reserved */
  .word PendSV_Handler
  .word SysTick_Handler
  .word PF_IRQHandler
  .word WDT0_IRQHandler
  .word RSV00_IRQHandler
  .word RTC_IRQHandler
  .word RSV01_IRQHandler
  .word TMR0_IRQHandler
  .word TMR1_IRQHandler
  .word TMR2_IRQHandler
  .word RSV02_IRQHandler
  .word RSV03_IRQHandler
  .word RSV04_IRQHandler
  .word RSV05_IRQHandler
  .word RSV06_IRQHandler
  .word I2C0_IRQHandler
  .word UART0_IRQHandler
  .word UART1_IRQHandler
  .word SPI0_IRQHandler
  .word SPI1_IRQHandler
  .word RSV07_IRQHandler
  .word RSV08_IRQHandler
  .word RSV09_IRQHandler
  .word RSV10_IRQHandler
  .word RSV11_IRQHandler
  .word FLC_IRQHandler
  .word GPIO0_IRQHandler
  .word RSV12_IRQHandler
  .word RSV13_IRQHandler
  .word RSV14_IRQHandler
  .word DMA0_IRQHandler
  .word DMA1_IRQHandler
  .word DMA2_IRQHandler
  .word DMA3_IRQHandler
  .word RSV15_IRQHandler
  .word RSV16_IRQHandler
  .word RSV17_IRQHandler
  .word RSV18_IRQHandler
  .word I2C1_IRQHandler
  .word RSV19_IRQHandler
  .word RSV20_IRQHandler
  .word RSV21_IRQHandler
  .word RSV22_IRQHandler
  .word RSV23_IRQHandler
  .word RSV24_IRQHandler
  .word RSV25_IRQHandler
  .word RSV26_IRQHandler
  .word RSV27_IRQHandler
  .word RSV28_IRQHandler
  .word RSV29_IRQHandler
  .word RSV30_IRQHandler
  .word RSV31_IRQHandler
  .word RSV32_IRQHandler
  .word RSV33_IRQHandler
  .word RSV34_IRQHandler
  .word RSV35_IRQHandler
  .word GPIOWAKE_IRQHandler
_vectors_end:

#ifdef VECTORS_IN_RAM
  .section .vectors_ram, "ax"
  .align 2
  .global _vectors_ram

_vectors_ram:
  .space _vectors_end - _vectors, 0
#endif
