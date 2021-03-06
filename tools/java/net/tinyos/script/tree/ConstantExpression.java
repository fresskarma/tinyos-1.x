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
package net.tinyos.script.tree;

import java.io.*;
import java.util.*;
import java_cup.runtime.Symbol;
import net.tinyos.script.*;

public class ConstantExpression extends Expression {

  private Integer value;
  private Symbol symbol;
    
  public ConstantExpression(int lineNumber, Integer val, Symbol s) {
    super(lineNumber);
    value = val;
    symbol = s;
  }
    
  public String toString() {return "" + value;}

  public int value() {return value.intValue();}
    
  public void checkStatement(SymbolTable table) throws SemanticException {
    int i = value.intValue();
    if (i >= (1 << 16)) {
      throw new SemanticException("Constants cannot be larger than " + (1 << 15) + " (e.g., " + i + ") " + symbol.value + ".\n", lineNumber());
    }
  }
    
  public void generateCode(SymbolTable table, CodeWriter writer) throws IOException {
    int iVal = value.intValue();
    if (iVal < (1 << 5)) {
      writer.writeInstr("pushc6 " + value);
    }
    else if (iVal < (1 << 10)) {
      writer.writeInstr("2pushc10 " + value);
    }
    else if (iVal < (1 << 16)) {
      writer.writeInstr("3pushc16 " + value);
    }
    
  }
}
