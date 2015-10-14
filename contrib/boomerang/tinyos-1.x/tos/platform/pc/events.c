// $Id: events.c,v 1.1.1.1 2007/11/05 19:10:17 jpolastre Exp $

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
 * Authors:             Philip Levis
 *
 */

/*
 *   FILE: events.c
 * AUTHOR: pal
 *   DESC: Implementation of default event behaviors.
 */

void event_default_cleanup(event_t* event) {
  free(event->data);
  dbg(DBG_MEM, "event_default_cleanup: freeing event: 0x%x\n", (unsigned int)event);
}

void event_total_cleanup(event_t* event) {
  free(event->data);
  dbg(DBG_MEM, "event_total_cleanup: freeing event data: 0x%x\n", (unsigned int)event->data);
  event->data = NULL;
  free(event);
  dbg(DBG_MEM, "event_total_cleanup: freeing event: 0x%x\n", (unsigned int)event);
}

void event_cleanup(event_t *fevent)
{
  dbg(DBG_MEM, "event_cleanup: freeing event: 0x%x\n", (unsigned int)fevent);
  fevent->cleanup(fevent);
}
