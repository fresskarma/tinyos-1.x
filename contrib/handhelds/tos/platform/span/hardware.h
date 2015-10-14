/*
 * Copyright (c) 2009, Shimmer Research, Ltd.
 * All rights reserved
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:

 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of Shimmer Research, Ltd. nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.

 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Author:  Steve Ayer
 *           May, 2009
 */

#ifndef _H_hardware_h
#define _H_hardware_h

#include "msp430hardware.h"
//#include "MSP430ADC12.h"

#include "CC2420Const.h"

TOSH_ASSIGN_PIN(GREEN_LED,  4, 3);

// CC2420 RADIO #defines
TOSH_ASSIGN_PIN(RADIO_FIFOP,     2, 3);
TOSH_ASSIGN_PIN(RADIO_FIFO,      2, 4);
TOSH_ASSIGN_PIN(RADIO_CCA,       2, 6);
TOSH_ASSIGN_PIN(RADIO_SFD,       2, 7);

TOSH_ASSIGN_PIN(RADIO_VREF,      5, 5);   

TOSH_ASSIGN_PIN(RADIO_SIMO1,     5, 1);
TOSH_ASSIGN_PIN(RADIO_SOMI1,     5, 2);
TOSH_ASSIGN_PIN(RADIO_CSN,       5, 4);
TOSH_ASSIGN_PIN(RADIO_RESET,     3, 3);

// UART pins
// SPI1 attached to cc2420
TOSH_ASSIGN_PIN(UCLK1, 5, 3);
TOSH_ASSIGN_PIN(SOMI1, 5, 2);
TOSH_ASSIGN_PIN(SIMO1, 5, 1);

// 1-Wire
TOSH_ASSIGN_PIN(ONEWIRE, 5, 6);

//BSL Pins
TOSH_ASSIGN_PIN(PROG_OUT,  1, 1);
TOSH_ASSIGN_PIN(PROG_IN,   2, 2);

// ADC lines on the testpoints
TOSH_ASSIGN_PIN(ADC_7,   6, 7);
TOSH_ASSIGN_PIN(DAC1_AN, 6, 7);

// connected to external UART 
TOSH_ASSIGN_PIN(UTXD0, 3, 4);
TOSH_ASSIGN_PIN(URXD0, 3, 5);
TOSH_ASSIGN_PIN(UTXD1, 3, 6);
TOSH_ASSIGN_PIN(URXD1, 3, 7);

// GIO pins
TOSH_ASSIGN_PIN(SER0_RTS, 1, 3);
TOSH_ASSIGN_PIN(SER0_CTS, 1, 4);

TOSH_ASSIGN_PIN(ROSC, 2, 5);

TOSH_ASSIGN_PIN(GIO0, 1, 0);
TOSH_ASSIGN_PIN(GIO1, 1, 5);
TOSH_ASSIGN_PIN(GIO2, 1, 6);

TOSH_ASSIGN_PIN(FTDI_ADBUS_7, 1, 2);
TOSH_ASSIGN_PIN(FTDI_ADBUS_3, 2, 0);

/*
 * NC Pins below
 */
TOSH_ASSIGN_PIN(NC_GIO0,     1, 7);
TOSH_ASSIGN_PIN(NC_GIO1,     2, 1);
TOSH_ASSIGN_PIN(NC_CS,       3, 0);
TOSH_ASSIGN_PIN(SIMO0,       3, 1);
TOSH_ASSIGN_PIN(SOMI0,       3, 2);
TOSH_ASSIGN_PIN(UCLK0,       3, 3);
TOSH_ASSIGN_PIN(NC_LED0,     4, 0);
TOSH_ASSIGN_PIN(NC_LED1,     4, 1);
TOSH_ASSIGN_PIN(NC_LED2,     4, 2);
TOSH_ASSIGN_PIN(NC_ACCEL0,   4, 4);
TOSH_ASSIGN_PIN(NC_ACCEL1,   4, 5);
TOSH_ASSIGN_PIN(NC_ACCELS,   4, 6);
TOSH_ASSIGN_PIN(NC_TB0,      4, 7);
TOSH_ASSIGN_PIN(NC_GIO2,     5, 0);
TOSH_ASSIGN_PIN(NC_SVS,      5, 7);
TOSH_ASSIGN_PIN(NC_ADC_0,    6, 0);
TOSH_ASSIGN_PIN(NC_ADC_1,    6, 1);
TOSH_ASSIGN_PIN(NC_ADC_2,    6, 2);
TOSH_ASSIGN_PIN(NC_ADC_3,    6, 3);
TOSH_ASSIGN_PIN(NC_ADC_4,    6, 4);
TOSH_ASSIGN_PIN(NC_ADC_5,    6, 5);
TOSH_ASSIGN_PIN(NC_ADC_6,     6, 6);


void TOSH_SET_PIN_DIRECTIONS(void)
{
  //LEDS
  TOSH_MAKE_GREEN_LED_OUTPUT();
  TOSH_SEL_GREEN_LED_IOFUNC();

    //RADIO PINS
  //CC2420 pins
  TOSH_MAKE_RADIO_CSN_OUTPUT();
  TOSH_SEL_RADIO_CSN_IOFUNC();
  TOSH_SET_RADIO_CSN_PIN();

  // should be reset_n
  TOSH_MAKE_RADIO_RESET_OUTPUT();
  TOSH_SEL_RADIO_RESET_IOFUNC();
  TOSH_CLR_RADIO_RESET_PIN();

  TOSH_MAKE_RADIO_CCA_INPUT();
  TOSH_MAKE_RADIO_FIFO_INPUT();
  TOSH_MAKE_RADIO_FIFOP_INPUT();
  TOSH_MAKE_RADIO_SFD_INPUT();
  TOSH_SEL_RADIO_CCA_IOFUNC();
  TOSH_SEL_RADIO_FIFO_IOFUNC();
  TOSH_SEL_RADIO_FIFOP_IOFUNC();
  TOSH_SEL_RADIO_SFD_IOFUNC();

  TOSH_MAKE_RADIO_VREF_OUTPUT();
  TOSH_SEL_RADIO_VREF_IOFUNC();

  // BSL Prog Pins tristate em
  TOSH_MAKE_PROG_IN_OUTPUT();
  TOSH_MAKE_PROG_OUT_OUTPUT();
  TOSH_SEL_PROG_IN_IOFUNC();
  TOSH_SEL_PROG_OUT_IOFUNC();

  // USART lines, attached to a pullup and cc2420
  TOSH_SEL_UCLK1_IOFUNC();
  TOSH_MAKE_UCLK1_OUTPUT();
  TOSH_SET_UCLK1_PIN();

  TOSH_SEL_SIMO1_IOFUNC();
  TOSH_MAKE_SIMO1_OUTPUT();
  TOSH_SET_SIMO1_PIN();
  TOSH_SEL_SOMI1_IOFUNC();
  TOSH_MAKE_SOMI1_INPUT();

  TOSH_SEL_ROSC_IOFUNC();
  TOSH_MAKE_ROSC_INPUT();

  // 1-wire function
  TOSH_MAKE_ONEWIRE_INPUT();
  TOSH_SEL_ONEWIRE_IOFUNC();

  TOSH_MAKE_ADC_7_OUTPUT();
  TOSH_SEL_ADC_7_IOFUNC();

  TOSH_SEL_GIO0_IOFUNC();
  TOSH_MAKE_GIO0_OUTPUT();
  TOSH_SEL_GIO1_IOFUNC();
  TOSH_MAKE_GIO1_OUTPUT();
  TOSH_SEL_GIO2_IOFUNC();
  TOSH_MAKE_GIO2_OUTPUT();

  TOSH_SEL_FTDI_ADBUS_7_IOFUNC();
  TOSH_MAKE_FTDI_ADBUS_7_OUTPUT();
  TOSH_SEL_FTDI_ADBUS_3_IOFUNC();
  TOSH_MAKE_FTDI_ADBUS_3_OUTPUT();

  // idle expansion header pins
  TOSH_MAKE_SER0_CTS_INPUT();
  TOSH_SEL_SER0_CTS_IOFUNC();
  TOSH_MAKE_SER0_RTS_OUTPUT();
  TOSH_SEL_SER0_RTS_IOFUNC();

  TOSH_MAKE_UTXD0_OUTPUT();
  TOSH_SEL_UTXD0_IOFUNC();
  TOSH_MAKE_URXD0_OUTPUT();
  TOSH_SEL_URXD0_IOFUNC();

  /*
   * assignments for nc pins
   */
  TOSH_MAKE_NC_GIO0_OUTPUT();
  TOSH_SEL_NC_GIO0_IOFUNC();
  TOSH_MAKE_NC_GIO1_OUTPUT();
  TOSH_SEL_NC_GIO1_IOFUNC();
  TOSH_MAKE_NC_CS_OUTPUT();
  TOSH_SEL_NC_CS_IOFUNC();
  TOSH_MAKE_SIMO0_INPUT();
  TOSH_SEL_SIMO0_IOFUNC();
  TOSH_MAKE_SOMI0_INPUT();
  TOSH_SEL_SOMI0_IOFUNC();
  TOSH_MAKE_UTXD1_OUTPUT();
  TOSH_SEL_UTXD1_IOFUNC();
  TOSH_MAKE_URXD1_OUTPUT();
  TOSH_SEL_URXD1_IOFUNC();
  TOSH_MAKE_NC_LED0_OUTPUT();
  TOSH_SEL_NC_LED0_IOFUNC();
  TOSH_MAKE_NC_LED1_OUTPUT();
  TOSH_SEL_NC_LED1_IOFUNC();
  TOSH_MAKE_NC_LED2_OUTPUT();
  TOSH_SEL_NC_LED2_IOFUNC();
  TOSH_MAKE_NC_ACCEL0_OUTPUT();
  TOSH_SEL_NC_ACCEL0_IOFUNC();
  TOSH_MAKE_NC_ACCEL1_OUTPUT();
  TOSH_SEL_NC_ACCEL1_IOFUNC();
  TOSH_MAKE_NC_ACCELS_OUTPUT();
  TOSH_SEL_NC_ACCELS_IOFUNC();
  TOSH_MAKE_NC_TB0_OUTPUT();
  TOSH_SEL_NC_TB0_IOFUNC();
  TOSH_MAKE_NC_GIO2_OUTPUT();
  TOSH_SEL_NC_GIO2_IOFUNC();
  TOSH_MAKE_NC_SVS_OUTPUT();
  TOSH_SEL_NC_SVS_IOFUNC();
  TOSH_MAKE_NC_ADC_0_OUTPUT();
  TOSH_SEL_NC_ADC_0_IOFUNC();
  TOSH_MAKE_NC_ADC_1_OUTPUT();
  TOSH_SEL_NC_ADC_1_IOFUNC();
  TOSH_MAKE_NC_ADC_2_OUTPUT();
  TOSH_SEL_NC_ADC_2_IOFUNC();
  TOSH_MAKE_NC_ADC_3_OUTPUT();
  TOSH_SEL_NC_ADC_3_IOFUNC();
  TOSH_MAKE_NC_ADC_4_OUTPUT();
  TOSH_SEL_NC_ADC_4_IOFUNC();
  TOSH_MAKE_NC_ADC_5_OUTPUT();
  TOSH_SEL_NC_ADC_5_IOFUNC();
  TOSH_MAKE_NC_ADC_6_OUTPUT();
  TOSH_SEL_NC_ADC_6_IOFUNC();
}
#endif // _H_hardware_h
