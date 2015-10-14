// $Id: Query.nc,v 1.1 2004/07/14 21:46:26 jhellerstein Exp $

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
module Query {
  provides {
    interface QueryIntf;
  }
}

implementation {
  command short QueryIntf.size(QueryPtr q) {
    return sizeof(Query) + (q->numFields-1)*sizeof(Field) + q->numExprs * sizeof(Expr);
  }

  command Field QueryIntf.getField(QueryPtr q, uint8_t idx) {
    return q->fields[idx];
  }

  command Field *QueryIntf.getFieldPtr(QueryPtr q, uint8_t idx) {
    return &q->fields[idx];
  }
  
  command result_t QueryIntf.setField(QueryPtr q, uint8_t idx, Field f) {
    q->fields[idx] = f;
    return SUCCESS;
  }

  command Expr QueryIntf.getExpr(QueryPtr q, uint8_t idx) {
    return *(Expr *)((char *)((char *)q + sizeof(Query) + 
			      (q->numFields-1)*sizeof(Field) + 
			      idx * sizeof(Expr)));
  }

  command result_t QueryIntf.setExpr(QueryPtr q, uint8_t idx, Expr e) {
    *(Expr *)((char *)((char *)q + sizeof(Query) + 
		       (q->numFields-1)*sizeof(Field) + 
		       idx * sizeof(Expr))) = e;
    return SUCCESS;
  }

  command bool QueryIntf.fieldsComplete(Query q) {
    return (q.knownFields & 0xFFFF) == 0xFFFF;
  }

  command bool QueryIntf.exprsComplete(Query q) {
    return (q.knownExprs & 0xFFFF) == 0xFFFF;
  }  
  
}

