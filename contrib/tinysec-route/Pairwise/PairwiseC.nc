/*									
 * "Copyright (c) 2003 The Regents of the University  of California.  
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
 * Authors: Naveen Sastry (nks@cs)
 * Date:    Nov 29, 2003
 */

configuration PairwiseC {
}
implementation {
  components PairwiseM, Main, TimerC, GenericComm, LedsC, TinySecC;

  Main.StdControl -> PairwiseM.StdControl;
  Main.StdControl -> TimerC.StdControl;
  Main.StdControl -> GenericComm;

  PairwiseM.Leds -> LedsC;
  PairwiseM.TinySecMode -> TinySecC.TinySecMode;
  PairwiseM.TimerSend -> TimerC.Timer[unique("timer")];
  PairwiseM.TimerTestInterval -> TimerC.Timer[unique("timer")];
  PairwiseM.ReceiveCmdMsg -> GenericComm.ReceiveMsg[200];
  PairwiseM.SendCmdMsg    -> GenericComm.SendMsg[200];  
  PairwiseM.ReceiveTstMsg ->GenericComm.ReceiveMsg[201];
  PairwiseM.SendTstMsg    -> GenericComm.SendMsg[201];
  PairwiseM.ReceiveTSModeMsg -> GenericComm.ReceiveMsg[202];
}
