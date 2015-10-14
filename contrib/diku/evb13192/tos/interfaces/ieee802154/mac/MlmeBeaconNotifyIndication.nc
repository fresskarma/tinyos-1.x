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

interface MlmeBeaconNotifyIndication
{
/*	command result_t create( char* buffer,
	                         uint8_t bufferLen,
	                         Ieee_Msdu sdu,
	                         Mlme_BeaconNotifyIndication *primitive );
	                         
	command char* getBuffer( Mlme_BeaconNotifyIndication primitive );*/
	
	command result_t destroy( Mlme_BeaconNotifyIndication primitive );
		
	command uint8_t getBsn( Mlme_BeaconNotifyIndication indication );
	
	command void getPanDescriptor( Mlme_BeaconNotifyIndication indication,
	                               Ieee_PanDescriptor panDesc );
	
	command uint8_t getShortAddrCount( Mlme_BeaconNotifyIndication indication );
	
	command uint16_t getShortAddr( Mlme_BeaconNotifyIndication indication, uint8_t index );
	
	command uint8_t getLongAddrCount(Mlme_BeaconNotifyIndication indication);
	
	command void getLongAddr( Mlme_BeaconNotifyIndication indication, uint8_t index, uint8_t *addr );
	
	command void getSdu(Mlme_BeaconNotifyIndication indication, Ieee_Msdu msdu);
}
