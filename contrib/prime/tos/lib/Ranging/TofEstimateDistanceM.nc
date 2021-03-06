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
 * Authors:  Kamin Whitehouse
 *           Intel Research Berkeley Lab
 * 	     UC Berkeley
 * Date:     8/20/2002
 *
 */

includes Ranging;
includes TofRanging;

//the module that estimates distance when it hears a chirp
module TofEstimateDistanceM
{
	provides
	{
		interface StdControl;
		interface Ranging;
	}
	uses
	{
		interface StdControl as Mic;
		interface StdControl as TimerControl;
		interface StdControl as CommControl;
		interface StdControl as AttrControl;
		interface AttrRegister as MicCalibration;
		interface AttrUse as Attributes;
		interface ReceiveMsg as TofChirp;
		interface SendMsg as TofData;
		interface Timer as Clock1;
		interface TofListenControl;
		interface Leds;
	}
}
implementation
{
	TOS_Msg tosMsg;
	struct TofRangingDataMsg *distanceData;
	struct CalibrationCoefficients* micCoefficients;
	uint8_t enabled;
	uint16_t tofFilterBuffer[TOF_FILTER_BUFFER_SIZE];
	uint8_t  currentBufferIndex;
	uint8_t  currentFilterTransmitter;

	result_t processTof(uint16_t tof, uint16_t receiverAction);
	result_t filterTof(uint16_t *tof, uint16_t transmitterId);
	result_t calibrateDistance();

	command result_t StdControl.init()
	{
//		call Leds.yellowOn();
//		call Leds.greenOn();
		call Leds.redOn();
		call TimerControl.init();
		call CommControl.init();
		call AttrControl.init();
		enabled=TRUE;
		currentBufferIndex=0;
		memset((char*)&tosMsg, 0, sizeof(tosMsg));
		distanceData=(struct TofRangingDataMsg*)&tosMsg.data;
		micCoefficients = (struct CalibrationCoefficients*)&(distanceData->micOffset);
		micCoefficients->a=0;
		micCoefficients->b=1;
		call Mic.init();
		if (call MicCalibration.registerAttr("TofMcCfs", UINT8, 1) != SUCCESS)
			return FAIL;
		return SUCCESS;
	}

	command result_t StdControl.start()
	{
		call AttrControl.start();
		call TimerControl.start();
		call CommControl.start();
		enabled==TRUE;
//		call Leds.yellowOff();
//		call Leds.greenOff();
		call Clock1.start(TIMER_ONE_SHOT, 200);
		call TofListenControl.enable();
		return SUCCESS;
	}

	command result_t StdControl.stop()
        {
		enabled=FALSE;
		call TofListenControl.disable();
		return(call Clock1.stop());
	}

	event result_t MicCalibration.getAttr(char *name, char *resultBuf, SchemaErrorNo *errorNo)
	{
		((struct CalibrationCoefficients*)resultBuf)->a = micCoefficients->a;
		((struct CalibrationCoefficients*)resultBuf)->b = micCoefficients->b;
		*errorNo = SCHEMA_RESULT_READY;
		return SUCCESS;
	}

	event result_t MicCalibration.setAttr(char *name, char *attrVal)
	{
		micCoefficients->a = ((struct CalibrationCoefficients*)attrVal)->a;
		micCoefficients->b = ((struct CalibrationCoefficients*)attrVal)->b;
		return SUCCESS;
	}

	event TOS_MsgPtr TofChirp.receive(TOS_MsgPtr chirpMsg)
	{
		SchemaErrorNo errorNo;
		
		call Leds.greenToggle();

		if(enabled==FALSE)
			return FAIL;
		
		distanceData->transmitterId=((struct TofChirpMsg*)chirpMsg->data)->transmitterId;
		distanceData->sounderOffset=((struct TofChirpMsg*)chirpMsg->data)->sounderOffset;
		distanceData->sounderScale=((struct TofChirpMsg*)chirpMsg->data)->sounderScale;
		distanceData->receiverId = TOS_LOCAL_ADDRESS;

 		if(chirpMsg->toneTime>0){
			call Leds.yellowToggle();
			processTof(chirpMsg->toneTime-chirpMsg->time, ((struct TofChirpMsg*)chirpMsg->data)->receiverAction);
		}
		call TofListenControl.disable();
		call Clock1.start(TIMER_ONE_SHOT, 40);
 		return chirpMsg;
	}

	event result_t Clock1.fired()
	{	
		call Leds.redOff();
		call TofListenControl.enable();
		return SUCCESS;
	}

	result_t processTof(uint16_t tof, uint16_t receiverAction)
	{
		if(filterTof(&tof, distanceData->transmitterId))
		{
			distanceData->distance=tof>>4;
			distanceData->distance*=9;
			distanceData->distance>>=6;

//			calibrateDistance();

			if(receiverAction==SIGNAL_RANGING_INTERRUPT){
				return(signal Ranging.rangingDataReady((RangingData*)&distanceData));
			}
			else{ 
				return(call TofData.send(receiverAction, LEN_TOFRANGINGDATAMSG, &tosMsg));
			}

		}
		return SUCCESS;

	}

	result_t filterTof(uint16_t *tof, uint16_t transmitterId)
	{
		uint16_t lower_bound;
		uint8_t min1Index;
		uint16_t min1;
		uint16_t min2;
		uint16_t i;
		
		if(TOF_FILTER_BUFFER_SIZE<2)
			return TRUE;

		if(currentBufferIndex==0)
			currentFilterTransmitter =transmitterId;
		else if(currentFilterTransmitter!=transmitterId)
			return FAIL;

		tofFilterBuffer[currentBufferIndex] = *tof;
		currentBufferIndex+=1;

		if(currentBufferIndex<TOF_FILTER_BUFFER_SIZE)
			return FALSE;

		//first, filter the readings: choose the min unless it is too far from the second min.  this accounts for up to one false positive
		min1=65535;//max value for a unsigned short
		for(i=0;i<TOF_FILTER_BUFFER_SIZE;i++){
			if(tofFilterBuffer[i]<min1){
				min1Index=i;
				min1=tofFilterBuffer[i];
			}
		}
  
		min2=65535;//max value for a unsigned short
		for(i=0;i<TOF_FILTER_BUFFER_SIZE;i++){
			if( (tofFilterBuffer[i]<min2) && (i!=min1Index) ){
				min2=tofFilterBuffer[i];
			}
		}
  
		lower_bound = (min2>>4)*13-3776; //effectively, lowerBound=.8125*min2-3776
		*tof=min1<lower_bound ? min2 : min1; // choose the min over lower_bound
		return TRUE;
	}

	result_t calibrateDistance()
	{
//		distanceData->distance=distanceData->distance*distanceData->sounderScale + distanceData->distance*distanceData->micScale + distanceData->sounderOffset + distanceData->micOffset;
	}

	event result_t TofData.sendDone(TOS_MsgPtr msg, result_t success) 
	{
		return SUCCESS;
	}
  
	event result_t Attributes.getAttrDone(char *name, char *resultBuf, SchemaErrorNo errorNo)
	{
		return SUCCESS;
	}

	default event result_t Ranging.rangingDataReady(RangingData* data)
	{
		return SUCCESS;
	}
}





