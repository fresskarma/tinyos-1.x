/*                                                                      tab:4
 *  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.  By
 *  downloading, copying, installing or using the software you agree to
 *  this license.  If you do not agree to this license, do not download,
 *
 */
/*                                                                      tab:4
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
 */
/*                                                                      tab:4
 * Copyright (c) 2003 Intel Corporation
 * All rights reserved Contributions to the above software program by Intel
 * Corporation is program is licensed subject to the BSD License, available at
 * http://www.opensource.org/licenses/bsd-license.html
 *
 */
/*
 * Authors:	Mark Yarvis
 *
 */

#ifndef _BROADCAST_SOCKET_H
#define _BROADCAST_SOCKET_H

#include <arpa/inet.h>

#include "iostream.h"
#include "thread.h"
#include "constants.h"
#include "connectionmanager.h"


#define HOST_NAME_SIZE 32

#pragma pack(1)

struct DiscoveryPacket {
	struct in_addr addr;
	unsigned int sequenceNumber;
	char hostName[HOST_NAME_SIZE];
};

#pragma pack()



class BroadcastSocket : public ioStream, public Thread {
public:
	BroadcastSocket();
	virtual ~BroadcastSocket();
	bool init(const char* localAddr, short port);

	virtual void recieve(unsigned char *buffer, int bufferSize);
	virtual void send(unsigned char *data, int length);
	virtual void performService(ConnectionManager* conn);
	virtual const char* getName(){return "Broadcast";}

	virtual void run();

protected:
	bool retransmit;
	sockaddr_in clientSockAddr;
	sockaddr_in serverSockAddr;
	sockaddr_in sendSockAddr;
	unsigned int sequenceNumber;
	DiscoveryPacket discPacket;
	socklen_t sin_len;




};

#endif
