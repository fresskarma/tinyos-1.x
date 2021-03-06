// $Id: MultiHopRouteSelect.nc,v 1.1.1.1 2007/07/06 03:44:07 ahngang Exp $

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
 *
 * Authors:		Philip Levis
 * Date last modified:  8/12/02
 *
 */

/**
 * @author Philip Levis
 */


module MultiHopRouteSelect {
  
  provides {
    interface StdControl as Control;
    // The interface are as parameterised by the active message id
    interface RouteSelect as RouteSelect;
    interface ActiveNotify as ActiveNotify;
  }

  uses {
    interface StdControl as SubControl;
  }
}

implementation {

  command result_t Control.init() {return SUCCESS;}
  command result_t Control.start() {
    signal ActiveNotify.activated();
    signal ActiveNotify.deactivated();
    return SUCCESS;
  }
  command result_t Control.stop() {
    signal ActiveNotify.deactivated();
    return SUCCESS;
  }

  command bool RouteSelect.isActive() {
    return FALSE;
  }
  
  command result_t RouteSelect.selectRoute(TOS_MsgPtr msg, uint8_t id) {
    return FAIL;
  }

  command result_t RouteSelect.initializeFields(TOS_MsgPtr msg, uint8_t id) {
    return SUCCESS;
  }

  command uint8_t* RouteSelect.getBuffer(TOS_MsgPtr msg, uint16_t* len) {
    *len = DATA_LENGTH;
    return (uint8_t*)msg->data;
  }
  
  default void event ActiveNotify.activated() {return;}
  default void event ActiveNotify.deactivated() {return;}
  
}
