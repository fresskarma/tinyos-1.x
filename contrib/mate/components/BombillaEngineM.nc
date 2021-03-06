/*									tab:4
 *
 *
 * "Copyright (c) 2000-2002 The Regents of the University  of California.  
 * All rights reserved.
 *
 * Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose, without fee, and without written
 * agreement is hereby granted, provided that the above copyright
 * notice, the following two paragraphs and the author appear in all
 * copies of this software.
 * 
 * IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY
 * PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
 * DAMAGES ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS
 * DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY OF
 * CALIFORNIA HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT,
 * UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 *
 */
/*									tab:4
 *									
 *  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.
 *  By downloading, copying, installing or using the software you
 *  agree to this license.  If you do not agree to this license, do
 *  not download, install, copy or use the software.
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
 * Authors:   Philip Levis <pal@cs.berkeley.edu>
 *            Neil Patel
 * History:   Apr 11, 2003         Inception.
 *
 */

includes AM;
includes Bombilla;
includes BombillaMsgs;

module BombillaEngineM {
  provides {
    interface StdControl;
    command result_t computeInstruction(BombillaContext* context);
    command result_t executeContext(BombillaContext* context);
    
    interface BombillaContextComm as Comm;
    
  }
  
  uses {
    interface Leds;
    interface Random;

    interface BombillaContextSynch as Synch;
    interface BombillaQueue as Queue;
                
    interface BombillaBytecode as Bytecode[uint8_t bytecode] ;

  }
}


implementation {
  BombillaState state;
  BombillaQueue runQueue;
  
  command result_t StdControl.init() {
    uint16_t i;
    int pc=0;

    dbg(DBG_BOOT, "VM: Bombilla initializing.\n");
    call Leds.init();
    call Random.init();
    
    call Queue.init(&state.readyQueue);
    call Queue.init(&runQueue);
    
    state.capsules[BOMB_CAPSULE_SEND_INDEX].capsule.code[pc++] = OPpushc;
    state.capsules[BOMB_CAPSULE_SEND_INDEX].capsule.code[pc++] = OPlnot;
    state.capsules[BOMB_CAPSULE_SEND_INDEX].capsule.code[pc++] = OPsendr;
    state.capsules[BOMB_CAPSULE_SEND_INDEX].capsule.code[pc++] = OPhalt;
    state.capsules[BOMB_CAPSULE_SEND_INDEX].capsule.options = 0;
    state.capsules[BOMB_CAPSULE_SEND_INDEX].capsule.version = 0;

    pc = 0;
    state.capsules[BOMB_CAPSULE_RECV_INDEX].capsule.code[pc++] = OPbhead;
    state.capsules[BOMB_CAPSULE_RECV_INDEX].capsule.code[pc++] = OPpushc | 7;
    state.capsules[BOMB_CAPSULE_RECV_INDEX].capsule.code[pc++] = OPland;
    state.capsules[BOMB_CAPSULE_RECV_INDEX].capsule.code[pc++] = OPputled;
    state.capsules[BOMB_CAPSULE_RECV_INDEX].capsule.code[pc++] = OPhalt;
    state.capsules[BOMB_CAPSULE_RECV_INDEX].capsule.options = 0;
    state.capsules[BOMB_CAPSULE_RECV_INDEX].capsule.version = 0;

    pc = 0;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPpushc | 1;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPgetvar | 0;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPadd;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPcopy;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPcopy;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPsetvar | 0;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPpushc | 7;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPland;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPputled;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPbpush0;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPbclear;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPadd;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPsendr;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.code[pc++] = OPhalt;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.options = 0;
    state.capsules[BOMB_CAPSULE_CLOCK_INDEX].capsule.version = 0;

    pc = 0;
    state.capsules[BOMB_CAPSULE_ONCE_INDEX].capsule.code[pc++] = OPgetvar | 2;
    state.capsules[BOMB_CAPSULE_ONCE_INDEX].capsule.code[pc++] = OPcall0;
    state.capsules[BOMB_CAPSULE_ONCE_INDEX].capsule.code[pc++] = OPhalt;
    state.capsules[BOMB_CAPSULE_ONCE_INDEX].capsule.options = 0;
    state.capsules[BOMB_CAPSULE_ONCE_INDEX].capsule.version = 0;
    
    pc = 0;
    state.capsules[BOMB_CAPSULE_SUB0].capsule.code[pc++] = OPgetvar | 4;
    state.capsules[BOMB_CAPSULE_SUB0].capsule.code[pc++] = OPcall1;
    state.capsules[BOMB_CAPSULE_SUB0].capsule.code[pc++] = OPret;
    state.capsules[BOMB_CAPSULE_SUB0].capsule.options = 0;
    state.capsules[BOMB_CAPSULE_SUB0].capsule.version = 0;

    pc = 0;
    state.capsules[BOMB_CAPSULE_SUB1].capsule.code[pc++] = OPgetvar | 12;
    state.capsules[BOMB_CAPSULE_SUB1].capsule.code[pc++] = OPcall2;
    state.capsules[BOMB_CAPSULE_SUB1].capsule.code[pc++] = OPcall3;
    state.capsules[BOMB_CAPSULE_SUB1].capsule.code[pc++] = OPret;
    state.capsules[BOMB_CAPSULE_SUB1].capsule.options = 0;
    state.capsules[BOMB_CAPSULE_SUB1].capsule.version = 0;

    pc = 0;
    state.capsules[BOMB_CAPSULE_SUB2].capsule.code[pc++] = OPgetvar | 10;
    //state.capsules[BOMB_CAPSULE_SUB2].capsule.code[pc++] = OPcall0;
    state.capsules[BOMB_CAPSULE_SUB2].capsule.code[pc++] = OPret;
    state.capsules[BOMB_CAPSULE_SUB2].capsule.options = 0;
    state.capsules[BOMB_CAPSULE_SUB2].capsule.version = 0;

    pc = 0;
    state.capsules[BOMB_CAPSULE_SUB3].capsule.code[pc++] = OPgetvar | 2;
    state.capsules[BOMB_CAPSULE_SUB3].capsule.code[pc++] = OPret;
    state.capsules[BOMB_CAPSULE_SUB3].capsule.options = 0;
    state.capsules[BOMB_CAPSULE_SUB3].capsule.version = 0;

    signal Comm.registerCapsule(&state); 
    signal Comm.analyzeLockSets(&state);
      
    state.inErrorState = FALSE;

    for (i = 0; i < BOMB_BUF_NUM; i++) {
      state.buffers[i].type = BOMB_DATA_NONE;
      state.buffers[i].size = 0;
    }
    
    for (i = 0; i < BOMB_HEAPSIZE; i++) {
      state.heap[(int)i].type = BOMB_TYPE_VALUE;
      state.heap[(int)i].value.var = 0;
    }
    
    return SUCCESS;
  }
  
  command result_t StdControl.start() {
    dbg(DBG_BOOT, "VM: Starting.\n");
    return SUCCESS;
  }

  command result_t StdControl.stop() {
    dbg(DBG_BOOT, "VM: Stopping.\n");
    return SUCCESS;
  }
  
  task void RunTask() {
    int i;
    // FIFO style policy
    if (!state.inErrorState) {
      BombillaContext* context = call Queue.dequeue(NULL, &runQueue);
      for (i=0; i < 4; i++) { // this is an arbitrary number of instructions
        call computeInstruction(context);
        if (context->state != BOMB_STATE_RUN) {
          return;
        }
      }
      if (context->queue != &runQueue) {
        call Queue.enqueue(context, &runQueue, context);
        post RunTask();
      }
    }
  }
  
  command result_t executeContext(BombillaContext* context) {
    if (context->state != BOMB_STATE_RUN) {return FAIL;}
    call Queue.enqueue(context, &runQueue, context);
    post RunTask();
    return SUCCESS;
  }

  command result_t computeInstruction(BombillaContext* context) {
    uint8_t instr = context->capsule->capsule.code[(int)context->pc];
    //	dbg(DBG_USR1, "VM (%hhi): Issuing instruction 0x%hhx.\n", context->which, instr);
    if (context->state != BOMB_STATE_RUN) {
      dbg(DBG_ERROR, "VM: (%hhi) Tried to execute instruction in non-run state: %hhi\n", context->which, context->state);
      return FAIL;
    }
    context->pc++;
    call Bytecode.execute[instr](instr, context, &state);
    return SUCCESS;  
  }

  default command result_t Bytecode.execute[uint8_t opcode](uint8_t instr,
							    BombillaContext* context,
							    BombillaState* vmState) {
    dbg(DBG_ERROR|DBG_USR1, "VM: Executing default instruction: halt!\n");
    context->state = BOMB_STATE_HALT;
    return FAIL;
  }
  
  command void Comm.reboot() {
    int i;
    dbg(DBG_USR1, "VM: Bombilla rebooting.\n");
    call Queue.init(&state.readyQueue);
    call Queue.init(&runQueue);

    for (i = 0; i < BOMB_CAPSULE_NUM; i++) {
      state.capsules[i].haveSeen = 0;
      state.capsules[i].usedVars = 0;
    }

    for (i = 0; i < BOMB_HEAPSIZE; i++) {
      state.locks[i].holder = NULL;
    }

    signal Comm.registerCapsule(&state); 
    signal Comm.analyzeLockSets(&state);
      
    state.inErrorState = FALSE;

    for (i = 0; i < BOMB_BUF_NUM; i++) {
      state.buffers[i].type = BOMB_DATA_NONE;
      state.buffers[i].size = 0;
    }
    
    for (i = 0; i < BOMB_HEAPSIZE; i++) {
      state.heap[(int)i].type = BOMB_TYPE_VALUE;
      state.heap[(int)i].value.var = 0;
    }

    state.errorContext = NULL;
    state.sendingContext = NULL;

    state.sendrBuffer.type = BOMB_DATA_NONE;
    state.sendrBuffer.size = 0;
    state.recvBuffer.type = BOMB_DATA_NONE;
    state.sendrBuffer.size = 0;
  }
  
  event result_t Synch.makeRunnable(BombillaContext* context) {
    context->state = BOMB_STATE_RUN;
    return call executeContext(context);
  }

}
