// $Id: NetProgM.nc,v 1.1.1.1 2007/01/10 21:10:50 lhuang2 Exp $

/*									tab:2
 *
 *
 * "Copyright (c) 2000-2005 The Regents of the University  of California.  
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

/**
 * @author Jonathan Hui <jwhui@cs.berkeley.edu>
 */

includes NetProg;
includes TOSBoot;

module NetProgM {
  provides {
    interface NetProg;
    interface StdControl;
  }
  uses {
    interface Crc;
    interface InternalFlash as IFlash;
  }
}

implementation {

  uint16_t computeTosInfoCrc(NetProg_TOSInfo* tosInfo) {
    return call Crc.crc16(tosInfo, sizeof(NetProg_TOSInfo)-2);
  }

  void writeTOSinfo() {
    NetProg_TOSInfo tosInfo;
    uint16_t crc;
    call IFlash.read((uint8_t*)IFLASH_TOS_INFO_ADDR, &tosInfo, sizeof(tosInfo));
    tosInfo.addr = TOS_LOCAL_ADDRESS;
    tosInfo.groupId = TOS_AM_GROUP;
    crc = computeTosInfoCrc(&tosInfo);
    // don't write if data is already correct
    if (tosInfo.crc == crc)
      return;
    tosInfo.crc = crc;
    call IFlash.write((uint8_t*)IFLASH_TOS_INFO_ADDR, &tosInfo, sizeof(tosInfo));
  }

  command result_t StdControl.init() {

#ifndef PLATFORM_PC
    NetProg_TOSInfo tosInfo;

    call IFlash.read((uint8_t*)IFLASH_TOS_INFO_ADDR, &tosInfo, sizeof(tosInfo));

    if (tosInfo.crc == computeTosInfoCrc(&tosInfo)) {
      TOS_AM_GROUP = tosInfo.groupId;
      atomic TOS_LOCAL_ADDRESS = tosInfo.addr;
    }
    else {
      writeTOSinfo();
    }
#endif

    return SUCCESS;

  }
  
  command result_t StdControl.start() { 
    return SUCCESS;
  }

  command result_t StdControl.stop() { return SUCCESS; }
  
  command result_t NetProg.reboot() {
#ifndef PLATFORM_PC
    tosboot_args_t args;
    
    atomic {
      writeTOSinfo();
      
      args.imageAddr = TOSBOOT_GOLDEN_IMG_ADDR; //call Storage.imgNum2Addr(newImgNum);
      args.gestureCount = 0xff;
      args.noReprogram = FALSE;
      call IFlash.write((uint8_t*)TOSBOOT_ARGS_ADDR, &args, sizeof(args));
      
      // reboot
      netprog_reboot();
    }
#endif

    // couldn't reboot
    return FAIL;

  }

}
