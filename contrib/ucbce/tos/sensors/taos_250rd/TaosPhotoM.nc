 

/*									tab:4
 *
 *
 * "Copyright (c) 2000-2002 The Regents of the University  of California.  
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
 * CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 *
 */
/*									tab:4
 *  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.  By
 *  downloading, copying, installing or using the software you agree to
 *  this license.  If you do not agree to this license, do not download,
 *  install, copy or use the software.
 *
 *  Intel Open Source License 
 *
 *  Copyright (c) 2002 Intel Corporation 
 *  All rights reserved. 
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 * 
 *	Redistributions of source code must retain the above copyright
 *  notice, this list of conditions and the following disclaimer.
 *	Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *      Neither the name of the Intel Corporation nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE INTEL OR ITS
 *  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * 
 */
/*
 *
 * Authors:		Joe Polastre
 *
 */

includes sensorboard;

module TaosPhotoM {

   provides {
      interface ADC[uint8_t id];
      interface SplitControl;
   }

   uses {

      interface StdControl as SwitchControl;
      interface StdControl as I2CPacketControl;
      interface Switch;
      interface Timer;
      interface I2CPacket;
   }
}

implementation {

#include "SODebug.h"
#define DBG_USR2 0

   enum {IDLE, START_TAOS, SWITCH_POWER_ON, SWITCH_POWER_OFF, SWITCH_WAIT,
        READ_0, READ_1};

   norace char state;
   norace char tempvalue;

   result_t switch_write_result;

   bool power;
   char data_adc;
  

   task void DataReady_0() {
      SODbg(DBG_USR2, "TaosPhotoM.DataReady_0:, %i \r\n", (uint16_t)data_adc);
      signal ADC.dataReady[0](data_adc);
      return;
   }
  
   task void DataReady_1(){
      SODbg(DBG_USR2, "TaosPhotoM.DataReady_1:, %i \r\n", (uint16_t)data_adc);
      signal ADC.dataReady[1](data_adc);
      return;
   }
 


   command result_t SplitControl.init() {

      atomic {
         state = IDLE;
         power = FALSE;
      }

      SODbg(DBG_USR2, "TaosPhotoM.SplitControl.init \r\n"); 

      call I2CPacketControl.init();
      call SwitchControl.init();
      signal SplitControl.initDone();
      return SUCCESS;;
   }


/**
 * Start: 
 * - turn on power 
 * - if can't set switch then state = SWITCH_WAIT
 */
   command result_t SplitControl.start() {
    
      SODbg(DBG_USR2, "TaosPhotoM.SplitControl.start \r\n"); 

      atomic {
         state = SWITCH_POWER_ON;
      }
      call I2CPacketControl.start();
      call SwitchControl.start();
      if (call Switch.set(MICAWB_LIGHT_POWER,1) != SUCCESS) {
         SODbg(DBG_USR2, "TaosPhotoM.SplitControl.start SWITCH_WAIT set\r\n"); 
         state = SWITCH_WAIT;
      }
      return SUCCESS;
   }

   command result_t SplitControl.stop() {

      power = FALSE;
      // turn the sensor off
      state = SWITCH_POWER_OFF;
      return call Switch.set(MICAWB_LIGHT_POWER,0);
   }

   event result_t Switch.getDone(char value) {
      return SUCCESS;
   }



/**
 * Switch control done
 * - if state= SWITCH_POWER_ON:
 *     power just turned on, xmit cmd to start Taos
 * - if state= SWITCH_POWER_OFF:
 *     notify completion
 */
   event result_t Switch.setDone(bool result) {

      if (state == SWITCH_POWER_OFF){                    //asb
         state = IDLE;
	 return signal SplitControl.stopDone();                    
      }

      if (state == SWITCH_POWER_ON) {

         state = START_TAOS;
         TOSH_uwait(1000);                                             // wait for sensor  to power up
         atomic {
            tempvalue = 0x03;
         }
         return call I2CPacket.writePacket(1,(char*)&tempvalue,0x01);

      } else if (state == SWITCH_WAIT) {
         if (call Switch.set(MICAWB_LIGHT_POWER,1) != SUCCESS) {
            state = SWITCH_WAIT;
         } else {
            state = SWITCH_POWER_ON;
         }
      }

      return SUCCESS;
   }

   event result_t Switch.setAllDone(bool result) {
      return SUCCESS;
   }

   // no such thing
   async  command result_t ADC.getContinuousData[uint8_t id]() {
      return FAIL;
   }



   task void readChannel0() {

      tempvalue = 0x43;
      state = READ_0;
      atomic {
        switch_write_result = call I2CPacket.writePacket(1,(char*)&tempvalue,0x01);
      }
   }

   task void readChannel1() {

      tempvalue = 0x83;
      state = READ_1;
      atomic {
         switch_write_result = call I2CPacket.writePacket(1,(char*)&tempvalue,0x01);
      }
   }


  /**
   * Read Taos adc data
   * Cmd to read channel 0 + enable adc/power = 0x43
   * Cmd to read channel 1 + enable adc/power = 0x83
   */
   async command result_t ADC.getData[uint8_t id]() {

      SODbg(DBG_USR2, "TaosPhotoM.ADC.getData \r\n"); 

      if (state == IDLE) {

         if (id == 0) {
           /*
            //read channel 0
            atomic {
               tempvalue = 0x43;
               state = READ_0;
            }
	    return call I2CPacket.writePacket(1,(char*)&tempvalue,0x01);
            */
           post readChannel0();

         } else if (id == 1) {
           /*
            //read channel 1
            atomic {
               tempvalue = 0x83;
               state = READ_1;
            }
	    return call I2CPacket.writePacket(1,(char*)&tempvalue,0x01);
            */
           post readChannel1();
         }
         return switch_write_result;
      }
      state = IDLE;
      return FAIL;
   }



/******************************************************************************
 * I2C write packet complete
 *  If state = START_TAOS then fire timer to wait 800msec for conversion complete
 * 
 *****************************************************************************/
   event result_t I2CPacket.writePacketDone(bool result) {
    
      if (state == START_TAOS) {
         return call Timer.start(TIMER_ONE_SHOT, 850);
      }
   
      if (state == READ_0) {
         return call I2CPacket.readPacket(1,0x01);
      }	else if (state == READ_1) {
         return call I2CPacket.readPacket(1,0x01);
      }
      return FAIL;
   }



/******************************************************************************
 * I2C read packet complete
 *  If state = 
 * 
 *****************************************************************************/
   event result_t I2CPacket.readPacketDone(char length, char* data) {

      if (state == READ_0) {

         SODbg(DBG_USR2, "TaosPhoto:getData 0, %i \n", (int)data[0]); 
	 data_adc = data[0];
	 post DataReady_0();
         state = IDLE;
         return SUCCESS;
      } else if (state == READ_1) {
         SODbg(DBG_USR2, "TaosPhoto:getData 1, %i \n", (int)data[0]); 
	 data_adc = data[0];
	 post DataReady_1();
         state = IDLE;
	 return SUCCESS;
      }
      return SUCCESS;
   }



/******************************************************************************
 * Timer fired.
 *  Taos ready for readout
 * 
 *****************************************************************************/
   event result_t Timer.fired() {
       
      SODbg(DBG_USR2, "TaosPhotoM.Timer.fired() \r\n"); 
      atomic {
         state = IDLE;
      }
      signal SplitControl.startDone();                            // asb
      return SUCCESS;
   }

   default async event result_t ADC.dataReady[uint8_t id](uint16_t data) {
      return SUCCESS;
   }

}

