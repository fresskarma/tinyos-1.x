/* Copyright (c) 2006, Jan Flora <janflora@diku.dk>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *  - Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *  - Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *  - Neither the name of the University of Copenhagen nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
 * TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
  @author Jan Flora <janflora@diku.dk>
*/

#include <endianconv.h>
module PanDescriptorM
{
	provides 
	{
		interface IeeePanDescriptor;
	}
	uses
	{
		interface IeeeBufferManagement as BufferMng;
	}
}
implementation
{	
/*	command result_t IeeePanDescriptor.destroy( Ieee_PanDescriptor primitive )
	{
		return call BufferMng.release(sizeof(panDescriptor_t), (uint8_t*)primitive);
	}*/

	command void IeeePanDescriptor.getCoordAddr( Ieee_PanDescriptor panDescriptor,
	                                             Ieee_Address coordAddr )
	{
		memcpy(coordAddr, panDescriptor, sizeof(ieeeAddress_t));
	}
	
	command uint8_t IeeePanDescriptor.getLogicalChannel( Ieee_PanDescriptor panDescriptor )
	{
		return panDescriptor->logicalChannel;
	}
	
	command uint16_t IeeePanDescriptor.getSuperframeSpec( Ieee_PanDescriptor panDescriptor )
	{
		return panDescriptor->superFrameSpec;
	}
	
	command bool IeeePanDescriptor.getGtsPermit( Ieee_PanDescriptor panDescriptor )
	{
		return panDescriptor->gtsPermit;
	}
	
	command uint8_t IeeePanDescriptor.getLinkQuality( Ieee_PanDescriptor panDescriptor )
	{
		return panDescriptor->linkQuality;
	}
	
	command uint32_t IeeePanDescriptor.getTimeStamp( Ieee_PanDescriptor panDescriptor )
	{
		return panDescriptor->timeStamp;
	}
	
	command bool IeeePanDescriptor.getSecurityUse( Ieee_PanDescriptor panDescriptor )
	{
		return panDescriptor->securityUse;
	}
	
	command uint8_t IeeePanDescriptor.getAclEntry( Ieee_PanDescriptor panDescriptor )
	{
		return panDescriptor->ACLEntry;
	}
	
	command bool IeeePanDescriptor.getSecurityFailure( Ieee_PanDescriptor panDescriptor )
	{
		return panDescriptor->securityFailure;
	}
}