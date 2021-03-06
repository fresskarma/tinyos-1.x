/*
 * Copyright (c) 2007
 *	The President and Fellows of Harvard College.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE UNIVERSITY AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE UNIVERSITY OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include "PrintfRadio.h"
#include "PrintfUART.h"


module TestM
{                                                   
    provides interface StdControl;


    uses interface Timer;
    uses interface Leds;
    uses interface PrintfRadio;   
} 
implementation 
{    
    uint16_t cntTimerFired = 0;


    // =================== Methods ====================
    command result_t StdControl.init() 
    {
        printfUART_init();
        call Leds.init(); 
        printfUART("TestM: StdControl.init() - called\n");
        return SUCCESS;
    }

    command result_t StdControl.start() 
    {
        call Timer.start(TIMER_REPEAT, 2000);
        return SUCCESS;
    }

    command result_t StdControl.stop()  {return SUCCESS;}

    event result_t Timer.fired() 
    {
        call Leds.greenToggle();
        cntTimerFired++;
//         printfUART("\n\nTestM::Timer.fired():  cntTimerFired= %u\n", cntTimerFired);
//         printfUART("CC2420_DEF_CHANNEL= %u\n", CC2420_DEF_CHANNEL);
//         printfUART("TOSH_DATA_LENGTH= %u\n", TOSH_DATA_LENGTH);

        //#ifdef PLATFORM_SHIMMER
        //        printfRadio("It is a SHIMMER");
        //#else
        //        printfRadio("Not a SHIMMER");
        //#endif
        printfRadio("A%u abcdefghijkl", cntTimerFired);
        printfRadio("B%u abcdefghijkl", cntTimerFired);
        printfRadio("C%u abcdefghijklddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddzzz", cntTimerFired);
        printfRadio("D%u abcdefghijkl", cntTimerFired);
        printfRadio("E%u abcdefghijkl", cntTimerFired);
        printfRadio("F%u abcdefghijkl", cntTimerFired);

        return SUCCESS;
    }

}

