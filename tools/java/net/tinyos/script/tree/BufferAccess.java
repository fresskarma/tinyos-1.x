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

public class BufferAccess extends Expression {
  private String name;
  private Expression index = null;
  private Symbol symbol;
  
  public BufferAccess(int lineNumber, String name, Symbol s) {
    super(lineNumber);
    this.name = name;
    this.symbol = s;
  }
    
  public BufferAccess(int lineNumber, String name, Symbol s, Expression index) {
    super(lineNumber);
    this.name = name;
    this.symbol = s;
    this.index = index;
  }
    
  public String toString() {
    String val = name + "[";
    if (index != null) {val+= index.toString();}
    val+="]";
    return val;
  }

  public void checkStatement(SymbolTable table) throws SemanticException {
    if (!table.bufferDeclared(name)) {
      throw new SemanticException("Buffer " + name + " not declared: " + symbol.value + ".\n", lineNumber());
    }
  }

  public void generateCode(SymbolTable table, CodeWriter writer) throws IOException {
    int i = table.getBuffer(name);
    if (writer.isMicro()) {
      writer.writeInstr("bpush1 " + i);
    }
    else {
      writer.writeInstr("bpush3 " + i);
    }
    if (index != null) {
      index.generateCode(table, writer);
      writer.writeInstr("bread");
    }
    else {
      writer.writeInstr("btail");
    }	
  }
}
