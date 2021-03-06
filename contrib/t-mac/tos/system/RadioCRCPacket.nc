/*
 * Copyright (c) 2002-2004 the University of Southern California
 * Copyright (c) 2004 TU Delft/TNO
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement 
 * is hereby granted, provided that the above copyright notice and the
 * following two paragraphs appear in all copies of this software.
 *
 * IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE TO ANY
 * PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE
 * COPYRIGHT HOLDERS HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * THE COPYRIGHT HOLDERS SPECIFICALLY DISCLAIM ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER
 * IS ON AN "AS IS" BASIS, AND THE COPYRIGHT HOLDERS HAVE NO
 * OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR
 * MODIFICATIONS.
 *
 * Authors: 
 * Jerry Zhao, Wei Ye - S-MAC version
 * Tom Parker - T-MAC modifications
 * 
 * This is a Wrapper for T-MAC to provide standard tinyos Send/Receive
 *   interface, so that AMStandard can run over T-MAC.
 *
 * This component is to provide compatibilty to Berkeley's comm stack and 
 *   enable applications developed on Berkeley's stack to run over T-MAC 
 *   without modification. 
 */

/**
 * @author Jerry Zhao
 * @author Wei Ye
 * @author Tom Parker
 */



configuration RadioCRCPacket
{
  provides {
    interface StdControl as Control;
    interface BareSendMsg as Send;
    interface ReceiveMsg as Receive;
  }
}

implementation
{
  components 
	TMACWrapper,
	TMAC;

  Control= TMACWrapper;
  Send = TMACWrapper; 
  Receive = TMACWrapper;

  TMACWrapper.MACControl -> TMAC;
  TMACWrapper.MACComm -> TMAC;
  TMACWrapper.MyHelpers -> TMAC;
}
