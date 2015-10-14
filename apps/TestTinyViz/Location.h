// $Id: Location.h,v 1.2 2003/10/07 21:45:24 idgay Exp $

/* Copyright (c) 2002 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704. Attention: Intel License Inquiry.  
 * 
 * Author: Matt Welsh <mdw@eecs.harvard.edu>
 */

/**
 * This is a generic location datatype. Location dimensions range 
 * from 0.0 to 1.0. 
 * @author Matt Welsh <mdw@eecs.harvard.edu>
 */
typedef struct {
  float x;
  float y;
  float z;
} location_3d_t;

