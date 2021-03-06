// $Id: MLME_ASSOCIATE.nc,v 1.3 2004/03/09 01:10:34 jpolastre Exp $

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
 * Authors:		Joe Polastre
 */

includes IEEE802154;

/**
 * The MLME-SAP association primitives define how a devices becomes associated
 * with a PAN.
 *
 * @author Joe Polastre
 */

interface MLME_ASSOCIATE {

  /**
   * Request to associate with a PAN.
   * See page 64 of the IEEE 802.15.4 specification.
   * 
   * @param LogicalChannel The logical channel on which to attempt
   *                       association
   * @param CoordAddrMode The coordinator addressing mode
   * @param CoordPANId The 16 bit PAN identifier of the coordinator
   * @param CoordAddress Individual device address of the coordinator as
   *                     per the CoordAddrMode
   * @param CapabilityInformation Specifies the operational capabilities
   *                              of the associating device
   * @param SecurityEnable TRUE if security is enabled for this transfer
   */
  command void request  (
                          uint8_t LogicalChannel,
                          uint8_t CoordAddrMode,
                          uint16_t CoordPANId,
                          uint8_t* CoordAddress,
                          uint8_t CapabilityInformation,
                          bool SecurityEnable
                        );

  /**
   * Provide notification that a device has requested to associate with
   * a PAN identifier.
   *
   * @param DeviceAddress the 64-bit address of the requesting device
   * @param CapabilityInformation Specifies the operational capabilities
   *                              of the associating device
   * @param SecurityUse TRUE if security was enabled for the request
   * @param ACLEntry The macSecurityMode parameter value from the ACL
   *                 entry associated with the sender of the data frame.
   *                 This value is set to 0x08 if the sender of the data
   *                 frame was not found in the ACL.
   */
  event void indication (
                          uint64_t DeviceAddress,
                          uint8_t CapabilityInformation,
                          bool SecurityUse,
                          uint8_t ACLEntry
                        );

  /**
   * Send a response to a device's request to associate
   *
   * @param DeviceAddress the 64-bit address of the device to respond to
   * @param AssocShortAddress The short device address allocated by the
   *                          coordinator on successful allocation.
   * @param status The status of the association attempt
   * @param SecurityEnable TRUE if security is enabled for this transfer
   */
  command void response (
                          uint64_t DeviceAddress,
                          uint16_t AssocShortAddress,
                          IEEE_status status,
                          bool SecurityEnable
                        );

  /**
   * Confirmation of the association attempt
   *
   * @param AssocShortAddress The short device address allocated by the
   *                          coordinator on successful association
   * @param status The status of the association attempt
   */
  event void confirm    (
                          uint16_t AssocShortAddress,
                          IEEE_status status
                        );

}
