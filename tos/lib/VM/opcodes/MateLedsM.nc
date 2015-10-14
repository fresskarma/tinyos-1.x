/*									tab:4
 *
 *
 * "Copyright (c) 2000-2002 The Regents of the University  of California.  
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose, without fee, and without written
 * agreement is hereby granted, provided that the above copyright
 * notice, the following two paragraphs and the author appear in all
 * copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY
 * PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
 * DAMAGES ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS
 * DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY OF
 * CALIFORNIA HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT,
 * UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 *
 */
/*									tab:4
 *									
 *  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.
 *  By downloading, copying, installing or using the software you
 *  agree to this license.  If you do not agree to this license, do
 *  not download, install, copy or use the software.
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
 * Authors:   Philip Levis <pal@cs.berkeley.edu>
 * History:   Feb 20, 2005         Inception.
 *
 */

/**
 * @author Philip Levis <pal@cs.berkeley.edu>
 */


includes Mate;

module MateLedsM {
  provides {
    interface MateBytecode as RedOn;
    interface MateBytecode as RedOff;
    interface MateBytecode as RedToggle;

    interface MateBytecode as YellowOn;
    interface MateBytecode as YellowOff;
    interface MateBytecode as YellowToggle;
    
    interface MateBytecode as GreenOn;
    interface MateBytecode as GreenOff;
    interface MateBytecode as GreenToggle;
  }
  
  uses interface Leds;
}

implementation {

  command result_t RedOn.execute(uint8_t instr, MateContext* context) {
    call Leds.redOn();
    return SUCCESS;
  }
  command result_t RedOff.execute(uint8_t instr, MateContext* context) {
    call Leds.redOff();
    return SUCCESS;
  }
  command result_t RedToggle.execute(uint8_t instr, MateContext* context) {
    call Leds.redToggle();
    return SUCCESS;
  }

  command result_t YellowOn.execute(uint8_t instr, MateContext* context) {
    call Leds.yellowOn();
    return SUCCESS;
  }
  command result_t YellowOff.execute(uint8_t instr, MateContext* context) {
    call Leds.yellowOff();
    return SUCCESS;
  }
  command result_t YellowToggle.execute(uint8_t instr, MateContext* context) {
    call Leds.yellowToggle();
    return SUCCESS;
  }

  command result_t GreenOn.execute(uint8_t instr, MateContext* context) {
    call Leds.greenOn();
    return SUCCESS;
  }
  command result_t GreenOff.execute(uint8_t instr, MateContext* context) {
    call Leds.greenOff();
    return SUCCESS;
  }
  command result_t GreenToggle.execute(uint8_t instr, MateContext* context) {
    call Leds.greenToggle();
    return SUCCESS;
  }


  command uint8_t RedOn.byteLength() {return 1;}
  command uint8_t RedOff.byteLength() {return 1;}
  command uint8_t RedToggle.byteLength() {return 1;}
  
  command uint8_t YellowOn.byteLength() {return 1;}
  command uint8_t YellowOff.byteLength() {return 1;}
  command uint8_t YellowToggle.byteLength() {return 1;}
  
  command uint8_t GreenOn.byteLength() {return 1;}
  command uint8_t GreenOff.byteLength() {return 1;}
  command uint8_t GreenToggle.byteLength() {return 1;}

}