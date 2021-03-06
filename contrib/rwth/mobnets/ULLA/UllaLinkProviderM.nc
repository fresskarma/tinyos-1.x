/*
 * Copyright (c) 2007, RWTH Aachen University
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice, the following
 * two paragraphs and the author appear in all copies of this software.
 * 
 * IN NO EVENT SHALL RWTH AACHEN UNIVERSITY BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF RWTH AACHEN
 * UNIVERSITY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * RWTH AACHEN UNIVERSITY SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND RWTH AACHEN UNIVERSITY HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 */
 
 /**
 * @author Krisakorn Rerkrai <kre@mobnets.rwth-aachen.de>
 **/
 
includes UQLCmdMsg;
includes UllaQuery;
includes Attribute;
includes AMTypes;

module UllaLinkProviderM {

  provides 	{
    //interface StdControl;
    interface LinkProviderIf[uint8_t id];  // replacement of RequestUpdate
   }
  uses {
    interface Leds;
#ifndef MAKE_PC_PLATFORM
    interface CC2420Control;
	//interface MacControl; 
#endif
  }

}

/* 
 *  Module Implementation
 */

implementation 
{


	command uint8_t LinkProviderIf.execCmd[uint8_t id](CmdDescr_t* cmddescr) {
	
		return 1;
	}
	
  command uint8_t LinkProviderIf.requestUpdate[uint8_t id](RuId_t ruId, RuDescr_t* ruDescr, AttrDescr_t* attrDescr) {
	
		return 1;
	}

	command uint8_t LinkProviderIf.cancelUpdate[uint8_t id](RuId_t ruId) {
	
	  return 1;
	}
	
	command uint8_t LinkProviderIf.getAttribute[uint8_t id](AttrDescr_t* attrDescr) {
		elseHorizontalTuple tuple;
		
		switch (attrDescr->attribute) {
			
			case TYPE:
				tuple.u.value16 = IEEE_802_15_4_TYPE;
			break;
			
			case LP_ID:
				tuple.u.value16 = TOS_LOCAL_ADDRESS;
			break;
			
			case RF_POWER:
				tuple.u.value16 = call CC2420Control.GetRFPower();
			break;
			
			case FREQUENCY:
				tuple.u.value16 = call CC2420Control.GetFrequency();
			break;
			
			default:

			break;
		}
		
		tuple.attr = attrDescr->attribute;
		signal LinkProviderIf.getAttributeDone[LOCAL_QUERY](attrDescr, (uint8_t *) &tuple);

		return 1;
	}
	
	command uint8_t LinkProviderIf.setAttribute[uint8_t id](AttrDescr_t* attrDescr) {
		
		return 1;
	}

  command void LinkProviderIf.freeAttribute[uint8_t id](AttrDescr_t* attrDescr) {
		
	}


}
