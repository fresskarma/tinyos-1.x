/**
 * Copyright (c) 2004-2005 Crossbow Technology, Inc.  All Rights Reserved.
 *
 * Permission to use, copy, modify and distribute, this software and 
 * documentation is granted, provided the following conditions are met:
 *   1. The above copyright notice and these conditions, along with the 
 *      following disclaimers, appear in all copies of the software.
 *   2. When the use, copying, modification or distribution is for COMMERCIAL 
 *      purposes (i.e., any use other than academic research), then the 
 *      software (including all modifications of the software) may be used 
 *      ONLY with hardware manufactured by and purchased from 
 *      Crossbow Technology, unless you obtain separate written permission 
 *      from, and pay appropriate fees to, Crossbow.  For example, no right 
 *      to copy and use the software on non-Crossbow hardware, if the use is 
 *      commercial in nature, is permitted under this license. 
 *   3. When the use, copying, modification or distribution is for 
 *      NON-COMMERCIAL PURPOSES (i.e., academic research use only), the 
 *      software may be used, whether or not with Crossbow hardware, 
 *      without any fee to Crossbow. 
 *
 * IN NO EVENT SHALL CROSSBOW TECHNOLOGY OR ANY OF ITS LICENSORS BE LIABLE TO 
 * ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL 
 * DAMAGES ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN 
 * IF CROSSBOW OR ITS LICENSOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH 
 * DAMAGE. CROSSBOW TECHNOLOGY AND ITS LICENSORS SPECIFICALLY DISCLAIM ALL 
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED 
 * HEREUNDER IS ON AN "AS IS" BASIS, AND NEITHER CROSSBOW NOR ANY LICENSOR HAS 
 * ANY OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, 
 * OR MODIFICATIONS. 
 *
 * $Id: TestSensor.nc,v 1.2 2005/04/06 04:16:35 husq Exp $
 */

#include "appFeatures.h"
includes sensorboardApp;
configuration TestSensor { 
// this module does not provide any interface
}
implementation
{
  components Main, TestSensorM, Accel, Hamamatsu, SensirionHumidity,IntSensirionHumidity,IntersemaPressure,
  			 GenericComm as Comm, Voltage, LedsC, ADCC, TimerC;

  Main.StdControl -> TimerC;
  Main.StdControl -> TestSensorM;
  
  TestSensorM.CommControl -> Comm;
  TestSensorM.Receive -> Comm.ReceiveMsg[AM_XSXMSG];
  TestSensorM.Send -> Comm.SendMsg[AM_XSXMSG];
  
  TestSensorM.Leds -> LedsC;
  TestSensorM.Timer -> TimerC.Timer[unique("Timer")];

  // Wiring for Battery Ref
  TestSensorM.BattControl -> Voltage;  
  TestSensorM.ADCBATT -> Voltage;  

  TestSensorM.AccelControl -> Accel;
  TestSensorM.AccelX -> Accel.ADC[1];
  TestSensorM.AccelY -> Accel.ADC[2];
  
  TestSensorM.PhotoControl -> Hamamatsu;
  TestSensorM.Photo1 -> Hamamatsu.ADC[1];
  TestSensorM.Photo2 -> Hamamatsu.ADC[2];
  TestSensorM.Photo3 -> Hamamatsu.ADC[3];
  TestSensorM.Photo4 -> Hamamatsu.ADC[4];
  
  TestSensorM.HumControl -> SensirionHumidity;
  TestSensorM.Humidity -> SensirionHumidity.Humidity;
  TestSensorM.Temperature -> SensirionHumidity.Temperature;
  TestSensorM.HumidityError -> SensirionHumidity.HumidityError;
  TestSensorM.TemperatureError -> SensirionHumidity.TemperatureError;

  TestSensorM.IntHumControl -> IntSensirionHumidity;
  TestSensorM.IntHumidity -> IntSensirionHumidity.Humidity;
  TestSensorM.IntTemperature -> IntSensirionHumidity.Temperature;
  TestSensorM.IntHumidityError -> IntSensirionHumidity.HumidityError;
  TestSensorM.IntTemperatureError -> IntSensirionHumidity.TemperatureError;
  
  TestSensorM.IntersemaControl -> IntersemaPressure.SplitControl;
  TestSensorM.Pressure -> IntersemaPressure.Pressure;
  TestSensorM.IntersemaTemperature -> IntersemaPressure.Temperature;
  TestSensorM.PressureError -> IntersemaPressure.PressureError;
  TestSensorM.IntersemaTemperatureError -> IntersemaPressure.TemperatureError;
  TestSensorM.Calibration -> IntersemaPressure;   
  
}

