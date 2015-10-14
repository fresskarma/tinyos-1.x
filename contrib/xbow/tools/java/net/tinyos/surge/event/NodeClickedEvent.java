// $Id: NodeClickedEvent.java,v 1.1 2003/11/05 22:35:12 jlhill Exp $

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
 * @author Wei Hong
 */

package net.tinyos.surge.event;

import net.tinyos.surge.*;
import java.util.*;

              //this event is triggered every time a node is clicked in the GUI
public class NodeClickedEvent extends java.util.EventObject
{
	protected Integer nodeNumber;//these events carry a reference to the node that was clicked
	protected Date time;//and the time the event was generated
	
	          //*****---CONSTRUCTOR---******//
	public NodeClickedEvent(Object source, Integer pNodeNumber, Date pTime)
	{
		super(source);
		nodeNumber = pNodeNumber;
		time = pTime;
	}
	          //*****---CONSTRUCTOR---******//
	
	
	
	          //*****---Get Functions---******//
	public Integer GetNodeNumber()
	{
		return nodeNumber;
	}
	
	public Date GetTime()
	{
		return time;
	}
	          //*****---Get Functions---******//

}