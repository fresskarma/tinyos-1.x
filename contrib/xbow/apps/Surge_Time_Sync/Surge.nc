// $Id: Surge.nc,v 1.1 2004/09/13 17:19:07 jdprabhu Exp $

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
/**
 * 
 **/
includes Surge;
includes SurgeCmd;
includes MultiHop;


configuration Surge {
}
implementation {
  components Main, SurgeM, TimerC, LedsC, NoLeds, ADCC, RandomLFSR, PhotoTemp,
    GenericCommPromiscuous as Comm, Bcast, EWMAMultiHopRouter as multihopM , QueuedSend, 
    Sounder, 
    // DelugeC, 
    CC1000RadioIntM;

  // Main.StdControl -> DelugeC;
  Main.StdControl -> SurgeM.StdControl;
  Main.StdControl -> Bcast.StdControl;
  Main.StdControl -> multihopM.StdControl;
  Main.StdControl -> QueuedSend.StdControl;
  Main.StdControl -> TimerC;
  Main.StdControl -> Comm;
  //  multihopM.CommControl -> Comm; 

  SurgeM.ADCControl -> ADCC;
  SurgeM.Batt   -> ADCC.ADC[TOS_ADC_BANDGAP_PORT];
  SurgeM.Temp   -> PhotoTemp.ExternalTempADC;
  SurgeM.Light   -> PhotoTemp.ExternalPhotoADC;
  SurgeM.TempStdControl   -> PhotoTemp.TempStdControl;
  SurgeM.LightStdControl   -> PhotoTemp.PhotoStdControl;
  SurgeM.Timer -> TimerC.Timer[unique("Timer")];
  SurgeM.Leds  -> LedsC; // NoLeds;
  SurgeM.Sounder -> Sounder;
  SurgeM.GetPower -> CC1000RadioIntM.GetPower;
  SurgeM.GetPower_send -> CC1000RadioIntM.GetPower_send;
  SurgeM.GetPower_receive -> CC1000RadioIntM.GetPower_receive;
  SurgeM.GetPower_check -> CC1000RadioIntM.GetPower_check;
  SurgeM.GetPower_total_sum -> CC1000RadioIntM.GetPower_total_sum;
  SurgeM.GetSendCount -> CC1000RadioIntM.GetSendCount;

  SurgeM.Bcast -> Bcast.Receive[AM_SURGECMDMSG];
  Bcast.ReceiveMsg[AM_SURGECMDMSG] -> Comm.ReceiveMsg[AM_SURGECMDMSG];

  SurgeM.RouteControl -> multihopM;
  SurgeM.Send -> multihopM.Send[AM_SURGEMSG];
  multihopM.ReceiveMsg[AM_SURGEMSG] -> Comm.ReceiveMsg[AM_SURGEMSG];
  //multihopM.ReceiveMsg[AM_MULTIHOPMSG] -> Comm.ReceiveMsg[AM_MULTIHOPMSG];
}



