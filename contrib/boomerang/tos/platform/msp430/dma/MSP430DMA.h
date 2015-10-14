/* "Copyright (c) 2000-2003 The Regents of the University of California.  
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement
 * is hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY
 * OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 */

//@author Ben Greenstein <ben@cs.ucla.edu>

#ifndef MSP430DMA_H
#define MSP430DMA_H

enum {
  DMA_CHANNELS = 3
};
enum {
  DMA_CHANNEL0 = 0,
  DMA_CHANNEL1 = 1,
  DMA_CHANNEL2 = 2,
  DMA_CHANNEL_UNKNOWN = 3
};
enum { 
  DMA_CHANNEL_AVAILABLE = 0,
  DMA_CHANNEL_IN_USE = 1
};

// HPL constants

enum {
  DMA0TSEL_SHIFT = (0),
  DMA1TSEL_SHIFT = (4),
  DMA2TSEL_SHIFT = (8),
  DMATSEL_MASK   = (0xF)
};
enum {
  DMASRCINCR_SHIFT = (8),
  DMADSTINCR_SHIFT = (10),
  DMAINCR_MASK = (0x3)
};
enum {
  DMADT_SHIFT = (12),
  DMADT_MASK = (0x3)
};
typedef enum {
    DMA_TRIGGER_DMAREQ =          0x0, // software trigger
    DMA_TRIGGER_TACCR2 =          0x1,            
    DMA_TRIGGER_TBCCR2 =          0x2,
    DMA_TRIGGER_USARTRX =         0x3, // URXIFG0 (UART/SPI), data received (I2C)
    DMA_TRIGGER_USARTTX =         0x4, // UTXIFG0 (UART/SPI), transmit ready (I2C)
    DMA_TRIGGER_DAC12IFG =        0x5, // DAC12_0CTL DAC12IFG bit
    DMA_TRIGGER_ADC12IFGx =       0x6, 
    DMA_TRIGGER_TACCR0 =          0x7, // CCIFG bit
    DMA_TRIGGER_TBCCR0 =          0x8, // CCIFG bit
    DMA_TRIGGER_URXIFG1 =         0x9,            
    DMA_TRIGGER_UTXIFG1 =         0xa,
    DMA_TRIGGER_MULT =            0xb, // Hardware Multiplier Ready
    DMA_TRIGGER_DMAxIFG =         0xe, // DMA0IFG triggers DMA channel 1
                                       // DMA1IFG triggers DMA channel 2
                                       // DMA2IFG triggers DMA channel 0
    DMA_TRIGGER_DMAE0 =           0xf  // External Trigger DMAE0
} dma_trigger_t;


enum {
  DISABLE_NMI = 0,
  ENABLE_NMI = 1
};
enum {
  NOT_ROUND_ROBIN = 0,
  ROUND_ROBIN = 1,
};
enum {
  NOT_ON_FETCH = 0,
  ON_FETCH = 1
};
typedef enum {
  DMA_EDGE_SENSITIVE = 0x0,
  DMA_LEVEL_SENSITIVE = 0x1
} dma_level_t;
typedef enum {
  DMA_WORD = 0x0,
  DMA_BYTE = 0x1
} dma_byte_t;
typedef enum {
  DMA_ADDRESS_UNCHANGED = 0x0,
  DMA_ADDRESS_DECREMENTED = 0x2,
  DMA_ADDRESS_INCREMENTED = 0x3
} dma_incr_t;
typedef enum {
  DMA_SINGLE_TRANSFER = 0x0,
  DMA_BLOCK_TRANSFER = 0x1,
  DMA_BURST_BLOCK_TRANSFER = 0x2,
  DMA_REPEATED_SINGLE_TRANSFER = 0x4,
  DMA_REPEATED_BLOCK_TRANSFER = 0x5,
  DMA_REPEATED_BURST_BLOCK_TRANSFER = 0x7
} dma_transfer_mode_t;

typedef struct dma_state_s {
  unsigned int enableNMI : 1;
  unsigned int roundRobin : 1;
  unsigned int onFetch : 1;
  unsigned int reserved : 13;
} __attribute__ ((packed)) dma_state_t;

typedef struct dma_channel_trigger_s {
  unsigned int trigger : 4; 
  unsigned int reserved : 12;
} __attribute__ ((packed)) dma_channel_trigger_t;

typedef struct dma_channel_state_s {
  unsigned int request : 1;
  unsigned int abort : 1;
  unsigned int interruptEnable : 1;
  unsigned int interruptFlag : 1;
  unsigned int enable : 1;
  unsigned int level : 1;            /* or edge- triggered */
  unsigned int srcByte : 1;          /* or word */
  unsigned int dstByte : 1;
  unsigned int srcIncrement : 2;     /* or no-increment, decrement */
  unsigned int dstIncrement : 2;
  unsigned int transferMode : 3;
  unsigned int reserved2 : 1;
} __attribute__ ((packed)) dma_channel_state_t;

#endif
