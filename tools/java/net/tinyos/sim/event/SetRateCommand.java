// $Id: SetRateCommand.java,v 1.2 2004/01/10 00:58:22 mikedemmer Exp $

/*									tab:2
 *
 * "Copyright (c) 2000 and The Regents of the University 
 * of California.  All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose, without fee, and without written
 * agreement is hereby granted, provided that the above copyright
 * notice and the following two paragraphs appear in all copies of
 * this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY
 * PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
 * DAMAGES ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS
 * DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY OF
 * CALIFORNIA HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT,
 * UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 */

package net.tinyos.sim.event;
import net.tinyos.sim.*;
import net.tinyos.message.*;
import java.util.*;

public class SetRateCommand extends net.tinyos.sim.msg.SetRateCommand
	implements TossimCommand {
	
	int rate;
	
	public SetRateCommand(int rate) {
		super();
		super.set_rate(rate);
	}
	
	public short getMoteID() {
		return 0;
	}
	
	public long getTime() {
		return 0;
	}
	
	public String toString() {
		return "SetRateCommand [rate "+super.get_rate()+"/1000]";
  }
    
}
