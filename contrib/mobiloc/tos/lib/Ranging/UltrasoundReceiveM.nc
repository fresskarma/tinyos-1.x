/*									tab:4
 *
 *
 * "Copyright (c) 2000-2002 The Regents of the University  of California.  
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
 * Authors:		Sarah Bergbreiter
 * Date last modified:  11/11/03
 *
 * UltrasoundReceiveC packages the receiving capabilities of the ultrasound
 * receiver.  It associates sequence numbers with distance measurements
 * and will ideally create confidence numbers based on what range I'm in
 * and past numbers.
 *
 * Currently, it provides interface Range which signals a rangeDone
 * event complete with sequence number, distance estimate, time stamp
 * (eventually) and confidence.
 *
 * I will eventually want to add my synchronized timer in here as well
 * to provide a time stamp on each distance estimate (to correlate it
 * with magnetometer estimates).
 *
 */

module UltrasoundReceiveM {
  provides {
    interface StdControl;
    interface Range;
  }
  uses {
    interface UltrasonicRangingReceiver as Receiver;
    interface StdControl as ReceiverControl; 
    interface StdControl as CommControl;
    interface Leds;
  }
}
implementation {

  uint16_t currentSeqNo;
  uint16_t currentTimeStamp;

  enum {
    SPEED_OF_SOUND = 340,  // meters/sec = microns/us
  };

  /**
   * Initializes the ultrasound receiver component.
   * @return Always returns whatever the receiver returns.
   */
  command result_t StdControl.init() {
    return rcombine( call CommControl.init(), call ReceiverControl.init());
  }

  /**
   * Starts the ultrasound receiver component.
   * @return Always returns whatever the receiver returns.
   */
  command result_t StdControl.start() {
    return rcombine( call CommControl.start(), call ReceiverControl.start());
  }

  /**
   * Stops the ultrasound receiver component.
   * @return Always returns whatever the receiver returns.
   */
  command result_t StdControl.stop() {
    return rcombine( call CommControl.stop(), call ReceiverControl.stop());
  }

  /**
   * Signaled when the receiver hears the radio message. I need to
   * correlate this receive with receiveDone below to signal
   * a rangeDone event.
   * @return Always returns SUCCESS.
   */
  event result_t Receiver.receive(uint16_t transmitterID,
				  uint16_t rangingID,
				  uint16_t rangingSequenceNumber,
				  bool initiateRangingSchedule) {
    currentSeqNo = rangingSequenceNumber;
    // Would normally get the current time here
    currentTimeStamp = 0;
    signal Range.rangeBegin(currentSeqNo);
    return SUCCESS;
  }

  /**
   * Signaled when the receiver hears the ultrasound beep.  This
   * gives me a distance measurement which I assume is calculated
   * on the ultrasound board (but still have to check on this).
   * @return Returns nothing.
   */
  event void Receiver.receiveDone(uint16_t transmitterID,
				  uint16_t receivedRangingID,
				  uint16_t distance) {
    // Determine confidence
    uint8_t confidence = 0;
    // Calculate actual range in millimeters  340*time   1
    //                                        --------  ----
    //             each clock tick is 2us -->    2      10^3 <-- for mm
    //uint16_t d = distance;
    uint16_t d = distance >> 5;
    d = d*87;
    d = d >> 4;
    call Leds.redToggle();
    signal Range.rangeDone(currentSeqNo, d, 
			   currentTimeStamp, confidence);
    return;
  }

  /**
   * Default event for rangeDone.
   * @return Always returns SUCCESS.
   */
  default event result_t Range.rangeDone(uint16_t seqNum,
					 uint16_t range,
					 uint16_t ts,
					 uint8_t confidence) 
    {return SUCCESS;}

  /**
   * Default event for rangeBegin.
   * @return Always returns SUCCESS.
   */
  default event result_t Range.rangeBegin(uint16_t seqNum)
    {return SUCCESS;}

}
