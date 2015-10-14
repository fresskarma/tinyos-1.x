// $Id: ErrorDialog.java,v 1.4 2003/10/07 21:46:10 idgay Exp $

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
/* Authors:		Phil Levis
 * Date:        Aug 2 2001
 * Desc:        Template for classes.
 *
 */

/**
 * @author Phil Levis
 */


package net.tinyos.vm_asm;

import java.awt.*;
import javax.swing.*;


public class ErrorDialog extends JDialog {
    private JLabel context;
    private JLabel cause;
    private JLabel capsule;
    private JLabel instruction;
    
    public ErrorDialog(String context, String cause, String capsule, String instruction) {
	super();
	getContentPane().setLayout(new BoxLayout(this.getContentPane(), BoxLayout.Y_AXIS));

	this.context = new JLabel(    "Context: " + context);
	this.cause = new JLabel(      "Cause: " + cause);
	this.capsule = new JLabel(    "Capsule: " + capsule);
	this.instruction = new JLabel("Instruction: " + instruction);

	getContentPane().add(this.context);
	getContentPane().add(this.cause);
	getContentPane().add(this.capsule);
	getContentPane().add(this.instruction);
	pack();
	setVisible(true);
    }

}

