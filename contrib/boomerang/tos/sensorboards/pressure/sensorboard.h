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
 *
 * Copyright (c) 2005 Moteiv Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached MOTEIV-LICENSE     
 * file. If you do not find these files, copies can be found at
 * http://www.moteiv.com/MOTEIV-LICENSE.txt and by emailing info@moteiv.com.
 *
 */
/*
 *
 * Authors:		Joe Polastre
 *
 * $Id: sensorboard.h,v 1.1.1.1 2007/11/05 19:11:36 jpolastre Exp $
 */


#define PRESSURE_SET_CLOCK()           TOSH_SET_UTXD0_PIN()
#define PRESSURE_CLEAR_CLOCK()         TOSH_CLR_UTXD0_PIN()
#define PRESSURE_MAKE_CLOCK_OUTPUT()   TOSH_MAKE_UTXD0_OUTPUT()

#define PRESSURE_MAKE_IN_INPUT()       TOSH_MAKE_GIO1_INPUT()
#define PRESSURE_MAKE_OUT_OUTPUT()     TOSH_MAKE_URXD0_OUTPUT()

#define PRESSURE_READ_IN_PIN()         TOSH_READ_GIO1_PIN()
#define PRESSURE_SET_IN_PIN()          TOSH_SET_GIO1_PIN()
#define PRESSURE_CLEAR_IN_PIN()        TOSH_CLR_GIO1_PIN()

#define PRESSURE_SET_OUT_PIN()         TOSH_SET_URXD0_PIN()
#define PRESSURE_CLEAR_OUT_PIN()       TOSH_CLR_URXD0_PIN()
#define PRESSURE_TIMEOUT_TRIES         5

#if 0
  const char crctable[256] = {
    0, 49, 98, 83, 196, 245, 166, 151, 185, 136, 219, 234, 125, 76, 31, 46,
    67, 114, 33, 16,
    135, 182, 229, 212, 250, 203, 152, 169, 62, 15, 92, 109, 134, 183, 228,
    213, 66, 115, 32, 17,
    63, 14, 93, 108,251, 202,153, 168,197, 244,167, 150,1, 48, 99, 82, 124, 
    77, 30, 47,
    184, 137,218, 235,61, 12, 95, 110,249, 200,155, 170,132, 181,230, 215,
    64, 113,34, 19,
    126, 79, 28, 45, 186, 139,216, 233,199, 246,165, 148,3, 50, 97, 80, 187, 
    138,217, 232,
    127, 78, 29, 44, 2, 51, 96, 81, 198, 247,164, 149,248, 201,154, 171,60, 
    13, 94, 111,
    65, 112,35, 18, 133, 180,231, 214,122, 75, 24, 41, 190, 143,220, 237,
    195, 242,161, 144,
    7, 54, 101, 84, 57, 8, 91, 106,253, 204,159, 174,128, 177,226, 211,68, 
    117,38, 23,
    252, 205,158, 175,56, 9, 90, 107,69, 116,39, 22, 129, 176,227, 210,191,
    142,221, 236,
    123, 74, 25, 40, 6, 55, 100, 85, 194, 243,160, 145,71, 118,37, 20, 131, 
    178,225, 208,
    254, 207,156, 173,58, 11, 88, 105,4, 53, 102, 87, 192, 241,162, 147,189, 
    140,223, 238,
    121, 72, 27, 42, 193, 240,163, 146,5, 52, 103, 86, 120, 73, 26, 43, 188, 
    141,222, 239,
    130, 179,224, 209,70, 119,36, 21, 59, 10, 89, 104,255, 206,157, 172};
#endif

