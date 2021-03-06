/*									tab:4
 *  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.  By
 *  downloading, copying, installing or using the software you agree to
 *  this license.  If you do not agree to this license, do not download,
 *  install, copy or use the software.
 *
 *  Intel Open Source License 
 *
 *  Copyright (c) 2002 Intel Corporation 
 *  All rights reserved. 
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 * 
 *	Redistributions of source code must retain the above copyright
 *  notice, this list of conditions and the following disclaimer.
 *	Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *      Neither the name of the Intel Corporation nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE INTEL OR ITS
 *  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * 
 */

/*
 * This interface provides a reliable packet.  It is similar to NetworkPacket
 * except for the semantics of the SendDone, and the addition of another
 * event and command
 */
interface ReliablePacket {

  /*
   * The data pointer passed to Send needs to have 4 bytes for the sequence
   * number of the reliable packet protocol and another 4 bytes available before
   * the data packet for the L2CAP header plus room for the iMote header.  Also
   * the data must reside in the BRAM memory region.  Both of these condiditions
   * are enforced by the allocate/ release routines contained in this interface.
   */
 
  command result_t Initialize( );

  command result_t Send( uint32 Destination,
                         uint8  *Data,
                         uint16 Length);

  /*
   * This commands sets the number of retries that the lower layer will
   * attempt before quitting and returning a FAIL
   */
  command result_t SetNumRetries(uint8 NumRetries);

  /*
   * The SendDone passes the status to the app.  A SUCCESS indicates that the
   * packet was received and acknowledged by the destination.  A FAIL means
   * that the number of retries was reached and no response was received from
   * the destination.
   */
  event result_t SendDone(char *data, result_t status);

  event result_t Receive( uint32 Source,
                          uint8  *Data,
                          uint16 Length);

  command char *AllocateBuffer( uint16 BufferSize);

  command result_t ReleaseBuffer( char *BufferPtr);

}
