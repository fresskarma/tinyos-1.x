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
 * Authors:		Joe Polastre
 *
 * $Id: TaosPhoto.nc,v 1.3 2003/10/07 21:46:35 idgay Exp $
 */

includes sensorboard;

configuration TaosPhoto
{
  provides {
    interface ADC[uint8_t id];
    interface StdControl;
  }
}
implementation
{
  components TaosPhotoM, I2CPacketC, TimerC, MicaWbSwitch;

  StdControl = TaosPhotoM;
  ADC = TaosPhotoM;

  TaosPhotoM.I2CPacketControl -> I2CPacketC.StdControl;
  TaosPhotoM.I2CPacket -> I2CPacketC.I2CPacket[TOSH_PHOTO_ADDR];

  TaosPhotoM.Timer -> TimerC.Timer[unique("Timer")];

  TaosPhotoM.SwitchControl -> MicaWbSwitch.StdControl;
  TaosPhotoM.Switch -> MicaWbSwitch.Switch[0];
}
