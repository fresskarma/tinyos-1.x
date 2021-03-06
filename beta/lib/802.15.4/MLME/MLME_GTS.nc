// $Id: MLME_GTS.nc,v 1.3 2004/03/09 01:10:34 jpolastre Exp $

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
 * The MLME-SAP GTS management primitives define how GTSs are requested
 * and maintained.  Devcies wishing to use these primitives and GTSs in 
 * general will already be tracking the beacons of their PAN coordinators.
 * These GTS management primitives are optional for an RFD.
 *
 * @author Joe Polastre
 */

interface MLME_GTS {

  /**
   * Request allocation of a new GTS or deallocation from the PAN
   * coordinator.
   * See page 79 of the IEEE 802.15.4 specification.
   * 
   * @param GTSCharacteristics The characteristics of the GTS request
   * @param SecurityEnable TRUE if security is enabled for this transfer
   */
  command void request  (
                          uint8_t GTSCharacteristics,
                          bool SecurityEnable
                        );

  /**
   * Reports the results of a request to allocated a new GTS or
   * deallocate an existing GTS
   *
   * @param GTSCharacteristics The characteristics of the GTS request
   * @param status The status of the GTS request
   */
  event void confirm    (
                          uint8_t GTSCharacteristics,
                          IEEE_status status
                        );

  /**
   * Indicates that a GTS has been allocated or that a previous allocated
   * GTS has been deallocated
   *
   * @param DevAddress Short address of the device that has been allocated
   *                   or deallocated a GTS
   * @param GTSCharacteristics The characteristics of the GTS request
   * @param SecurityUse TRUE if security is enabled for this transfer
   * @param ACLEntry The macSecurityMode parameter value from the ACL entry
   *                 associated with the sender of the data frame
   */   
  event void indication (
                          uint16_t DevAddress,
                          uint8_t GTSCharacteristics,
                          bool SecurityUse,
                          uint8_t ACLEntry
                        );

}
