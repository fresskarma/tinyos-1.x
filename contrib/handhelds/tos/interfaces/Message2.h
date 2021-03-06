/**
 * Copyright (c) 2005 Hewlett-Packard Company
 * All rights reserved
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:

 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of the Hewlett-Packard Company nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.

 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Message2 connections return a 'sendDone' event with a status code.
 * These status codes reflect if the message was successful and whether or 
 * not an ACK was generated.
 *
 * Cases we care about:
 *
 * (1) Message does not request ACK
 *     FAIL                  if we never sent it
 *     SUCCESS               if we sent it
 *
 * (2) Message requests ACK
 *     FAIL                  if we never sent it or we didn't get an ACK.
 *     SUCCESS               if we send it and get an ACK
 * 
 * Andrew Christian <andrew.christian@hp.com>
 * May 2005
 */

#ifndef __MESSAGE2_H
#define __MESSAGE2_H

enum {
  MESSAGE2_CHANNEL_BUSY  = 0x01,    // Never was sent
  MESSAGE2_ACK           = 0x02,    // An ACK was received
  MESSAGE2_DATA_PENDING  = 0x04,    // ACK received, data is pending
};

#endif
