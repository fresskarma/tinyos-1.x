// $Id: VoltageC.nc,v 1.2 2005/03/16 05:12:40 jwhui Exp $

/*									tab:4
 *
 *
 * "Copyright (c) 2000-2005 The Regents of the University  of California.  
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

/**
 * Platform independent component for measuring supply voltage
 * (Vcc). Value returned by dataReady() is in millivolts.
 *
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 */

includes Voltage;

configuration VoltageC {
  provides {
    interface ADC as Voltage;
    interface StdControl;
  }
}

implementation {

  components ADCC, VoltageM;

  StdControl = VoltageM;

  Voltage = VoltageM;

  VoltageM.ADC -> ADCC.ADC[TOS_ADC_VOLTAGE_PORT];
  VoltageM.ADCControl -> ADCC;

}
