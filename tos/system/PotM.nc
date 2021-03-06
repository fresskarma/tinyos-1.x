// $Id: PotM.nc,v 1.2 2003/10/07 21:46:37 idgay Exp $

/*									tab:4
 * "Copyright (c) 2000-2003 The Regents of the University  of California.  
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
 * Copyright (c) 2002-2003 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */
/*
 *
 * Authors:		Vladimir Bychkovskiy, David Gay, Philip Levis
 * Date last modified:  6/25/02
 *
 */

/* Potentiometer control component
 
 Functionality: Set and get poteniometer value (transmit power)

 USAGE:

  POT_INIT(char power)
      - reset the potentiometer device and set the initial value(see below)

  POT_SET(char power)
      - set new potentiometer value (see below)
      
  POT_GET()
      - get current setting of the potentiometer

  POT_INC()
  POT_DEC()
      - increment (decrement) current setting by 1

  Potentiometer setting vs. transmit power

  Valid range: 
     Mica --  0 (high power, low potentioneter resistance)
             99 (low power, high potentioneter resistance)
	     Actual range depends very much on the antenna; with the built in
	     antenna the range is from 1in to about 15 feet; with the external
	     bead antenna the range is from 1 foot to about 100 feet

     Rene -- 20 (high power, low potentiometer resistance)
             77 (low power, EXACT BOUND DEPENDS ON BATTERY VOLTAGE)
	     Again, range depends on the antenna, and can cover roughly the
	     same range as a Mica. WARNING: the low power bound is strongly
	     dependent on battery voltage, it is fairly difficult to get a
	     reliable short range over time without active control of the
	     potentiometer. 

   Note: transmit power is NOT linear w.r.t. potentiometer setting,
   see mote schematics & RFM chip manual for more information
 */

/**
 * @author Vladimir Bychkovskiy
 * @author David Gay
 * @author Philip Levis
 */

module PotM
{
  provides interface Pot;
  uses interface HPLPot;
}
implementation 
{
  uint8_t potSetting;

  void setPot(uint8_t value) {
    uint8_t i;
    for (i = 0; i < 151; i++)
      call HPLPot.decrease();

    for (i = 0; i < value; i++)
      call HPLPot.increase();

    call HPLPot.finalise();

    potSetting = value;
  }

  command result_t Pot.init(uint8_t initialSetting) {
    setPot(initialSetting);
    return SUCCESS;
  }

  command result_t Pot.set(uint8_t setting) {
    setPot(setting);
    return SUCCESS;
  }

  command result_t Pot.increase() {
    call HPLPot.increase();
    call HPLPot.finalise();
    potSetting++;
    return SUCCESS;
  }

  command result_t Pot.decrease() {
    call HPLPot.decrease();
    call HPLPot.finalise();
    potSetting--;
    return SUCCESS;
  }

  command uint8_t Pot.get() {
     return potSetting;
  }
}
