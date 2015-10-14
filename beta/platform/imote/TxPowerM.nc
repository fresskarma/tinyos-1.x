/*
 * Copyright (c) 2004, Intel Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * Neither the name of the Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

module TxPowerM {

  provides interface TxPower;

  uses {
     interface NetworkCommand;
    interface Timer;
 }
}

implementation
{
  uint32  ThisNodeID;


/*
 * Start of StdControl interface.
 */
  command result_t TxPower.Initialize() {
   call NetworkCommand.DisableLowPower();
    call NetworkCommand.GetMoteID(&ThisNodeID);
    call Timer.start(TIMER_REPEAT, 1000); // 10 sec 
    return SUCCESS;
  }

 
/*
 * Start of NetworkCommand interface.
 */

   event result_t NetworkCommand.CommandResult( uint32 Command, uint32 value) {
    switch (Command) {
      case COMMAND_TRANSMIT_POWER_LEVEL: call NetworkCommand.SetTxpower(ThisNodeID, value);
      break;
      default:
    }

    return SUCCESS;
  }


/*
 * Start of Timer interface.
 */
  event result_t Timer.fired() {
     if ((call NetworkCommand.GetTransmitPower(ThisNodeID, 0x00)) == SUCCESS) {
   }
   return SUCCESS;
  }
  
  command result_t TxPower.UpdateTxPower() {
    if ((call NetworkCommand.GetTransmitPower(ThisNodeID, 0x00)) == SUCCESS) {
      }
   return SUCCESS;
  }


}


