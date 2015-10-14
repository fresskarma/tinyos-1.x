// $Id: HumidityC.nc,v 1.3 2005/06/18 01:12:59 jpolastre Exp $
/*									tab:4
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
 * Copyright (c) 2002-2003 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */
/**
 * @author Joe Polastre
 */
includes Humidity;

configuration HumidityC
{
  provides {
    interface ADC as Humidity;
    interface ADC as Temperature;
    interface ADCError as HumidityError;
    interface ADCError as TemperatureError;
    interface SplitControl;
  }
}
implementation
{
  components HumidityM, TimerC, HumidityProtocolM, HumidityInterruptC;

  SplitControl = HumidityM;
  Humidity = HumidityM.Humidity;
  Temperature = HumidityM.Temperature;
  HumidityError = HumidityM.HumidityError;
  TemperatureError = HumidityM.TemperatureError;

  HumidityM.TimerControl -> TimerC.StdControl;
  HumidityM.Timer -> TimerC.Timer[unique("Timer")];

  HumidityM.SensorControl -> HumidityProtocolM.StdControl;
  HumidityM.HumSensor -> HumidityProtocolM.HumSensor;
  HumidityM.TempSensor -> HumidityProtocolM.TempSensor;

  HumidityM.HumError -> HumidityProtocolM.HumError;
  HumidityM.TempError -> HumidityProtocolM.TempError;

  HumidityProtocolM.SensirionInterrupt -> HumidityInterruptC;

  HumidityProtocolM.Timer -> TimerC.Timer[unique("Timer")];
}
