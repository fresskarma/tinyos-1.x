/*									tab:4
 *
 *
 * "Copyright (c) 2000-2002 The Regents of the University  of Virginia.  
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF VIRGINIA BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
 * VIRGINIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF VIRGINIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF VIRGINIA HAS NO OBLIGATION TO
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
 * Authors:		Lin Gu
 * Date last modified:  6/12/03
 *
 */

/*  OS component abstraction of the MIR sensor and */
/*  associated A/D support.  It provides an asynchronous interface */
/*  to the MIR sensor. */

/*  MIR_INIT command initializes the device */
/*  MIR_GET_DATA command initiates acquiring a sensor reading. */
/*  It returns immediately.   */
/*  MIR_DATA_READY is signaled, providing data, when it becomes */
/*  available. */
/*  Access to the sensor is performed in the background by a separate */
/* TOS task. */

includes sensorboard;
includes extra_sensorboard;

module MirBoardM {
  provides interface StdControl as MirStdControl;
  provides interface ADC as MirADC;

  uses {
    interface ADCControl;
    interface ADC as InternalMirADC;
  }
}

implementation {
  enum{
    IDLE = 1,
    BUSY = 2,
    CONTINUOUS = 3
  };
  int state;

  command result_t MirStdControl.init() {
    call ADCControl.bindPort(TOS_ADC_MIR_PORT, TOSH_ACTUAL_MIR_PORT);
    state = IDLE;
    dbg(DBG_BOOT, "MIR initialized.\n");    
    return call ADCControl.init();
  }

  command result_t MirStdControl.start() {
    // call MirStdControl.stop();
    TOSH_CLR_TEMP_CTL_PIN();
    TOSH_MAKE_TEMP_CTL_INPUT();
    // /////// TOSH_SET_MIR_CTL_PIN();
    // /////// TOSH_MAKE_MIR_CTL_OUTPUT();
    
    return SUCCESS;
  }

  command result_t MirStdControl.stop() {
    // /////// TOSH_CLR_MIR_CTL_PIN();
    // /////// TOSH_MAKE_MIR_CTL_INPUT();
    TOSH_CLR_TEMP_CTL_PIN();
    TOSH_MAKE_TEMP_CTL_INPUT();

    return SUCCESS;
  }

  command result_t MirADC.getData(){
    if (state == IDLE){
      /* TOSH_CLR_TEMP_CTL_PIN();
	 TOSH_MAKE_TEMP_CTL_INPUT(); */
      // /////// TOSH_SET_MIR_CTL_PIN();
      // /////// TOSH_MAKE_MIR_CTL_OUTPUT();
      state = BUSY;
      return call InternalMirADC.getData();
    }
    return FAIL;
  }


  command result_t MirADC.getContinuousData(){
    if (state == IDLE){
      TOSH_CLR_TEMP_CTL_PIN();
      TOSH_MAKE_TEMP_CTL_INPUT();
      // /////// TOSH_SET_MIR_CTL_PIN();
      // /////// TOSH_MAKE_MIR_CTL_OUTPUT();
      state = CONTINUOUS;
      return call InternalMirADC.getContinuousData();     
    }
    return FAIL;
  }

  default event result_t MirADC.dataReady(uint16_t data) {
    return SUCCESS;
  }

  event result_t InternalMirADC.dataReady(uint16_t data){
    if (state == BUSY){
	// /////// TOSH_CLR_MIR_CTL_PIN();
	// /////// TOSH_MAKE_MIR_CTL_INPUT();
      state = IDLE;
      return signal MirADC.dataReady(data);
    }else if (state == CONTINUOUS){
      int ret;
      ret = signal MirADC.dataReady(data);
      if (ret == FAIL){
	  // /////// TOSH_CLR_MIR_CTL_PIN();
	  // /////// TOSH_MAKE_MIR_CTL_INPUT();
	state = IDLE;
      }
      return ret;
    }
    return FAIL;
  }


}
