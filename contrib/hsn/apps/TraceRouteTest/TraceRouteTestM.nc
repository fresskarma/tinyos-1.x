/*                                                                      tab:4
 *  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.  By
 *  downloading, copying, installing or using the software you agree to
 *  this license.  If you do not agree to this license, do not download,
 *
 */
/*                                                                      tab:4
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
 */
/*                                                                      tab:4
 * Copyright (c) 2003 Intel Corporation
 * All rights reserved Contributions to the above software program by Intel
 * Corporation is program is licensed subject to the BSD License, available at
 * http://www.opensource.org/licenses/bsd-license.html
 *
 */
/*
 * Authors:	Mark Yarvis
 *
 */

includes WSN;

module TraceRouteTestM {
   provides {
      interface StdControl as Control;
   }
   uses {
      interface StdControl as TRControl;
      interface StdControl as TimerControl;
      interface StdControl as SettingsControl;
   }
}

implementation {
   command result_t Control.init() {
      call TimerControl.init();
      call TRControl.init();
      call SettingsControl.init();
      return SUCCESS;
   }

   command result_t Control.start() {
      call TimerControl.start();
      call TRControl.start();
      call SettingsControl.start();
      return SUCCESS;
   }

   command result_t Control.stop() {
      call TimerControl.stop();
      call TRControl.stop();
      call SettingsControl.stop();
      return SUCCESS;
   }
}
