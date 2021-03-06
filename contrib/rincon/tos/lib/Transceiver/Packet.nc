// $Id: Packet.nc,v 1.1.2.4 2005/03/14 03:54:19 jpolastre Exp $
/*									tab:4
 * "Copyright (c) 2004-5 The Regents of the University  of California.  
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
 * Copyright (c) 2004-5 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */

/** The basic message data type accessors. Protocols may add
  * additional packet interfaces for their protocol specific
  * data/metadata.
  *
  * Modified for use in TinyOS-1.x dmm
  *
  * @author Philip Levis
  * @author David Moss
  * @date   Feb 16 2005
  */ 


interface Packet {


  /**
    * Clear out this packet.  Note that this is a deep operation and
    * total operation: calling clear() on any layer will completely
    * clear the packet for reuse.
    */

  command void clear(TOS_MsgPtr msg);

  /**
    * Return the length of the payload of msg. This value may be less
    * than what maxPayloadLength() returns, if the packet is smaller than
    * the MTU. If a communication component does not support variably
    * sized data regions, then payloadLength() will always return
    * the same value as maxPayloadLength(). 
    */

  command uint8_t payloadLength(TOS_MsgPtr msg);

 /**
   * Return the maximum payload length that this communication layer
   * can provide. Note that, depending on protocol fields, a
   * given request to send a packet may not be able to send the
   * maximum payload length (e.g., if there are variable length
   * fields). Protocols may provide specialized interfaces
   * for these circumstances.
   */
  command uint8_t maxPayloadLength();

 /**
   * Return point to a protocol's payload region in a packet.
   * If len is not NULL, getPayload will return the length of
   * the payload in it, which is the same as the return value
   * from payloadLength(). If a protocol does not support
   * variable length packets, then *len is equal to 
   * maxPayloadLength().
   */
  command void* getPayload(TOS_MsgPtr msg, uint8_t* len);

}
