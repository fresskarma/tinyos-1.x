//$Id: TimerJiffyAsyncM.nc,v 1.2 2004/06/08 22:41:40 jdprabhu Exp $
// @author Joe Polastre

/*****************************************************************************
Provides a highresolution (32uSec interval) timer for CC2420Radio stack
Uses ATMega128 Timer2 via HPLTimer2
*****************************************************************************/
module TimerJiffyAsyncM
{
  provides interface StdControl;
  provides interface TimerJiffyAsync;
  uses interface Clock as Timer;
}
implementation
{
#define  JIFFY_SCALE 0x4 //cpu clk/256 ~ 32uSec
#define  JIFFY_INTERVAL 2
  uint32_t jiffy;
  bool bSet;


  command result_t StdControl.init()
  {
//    call Alarm.setControlAsTimer();
    return SUCCESS;
  }

  command result_t StdControl.start()
  {
    atomic bSet = FALSE;
    return SUCCESS;
  }

  command result_t StdControl.stop()
  {
    atomic {
      bSet = FALSE;
	  call Timer.intDisable();
    }
    return SUCCESS;
  }

//  async event void Alarm.fired()
async event result_t Timer.fire() {
	uint16_t localjiffy;
	atomic localjiffy = jiffy;
	if (localjiffy < 0xFF) {
		call Timer.intDisable();
		atomic bSet = FALSE;
		signal TimerJiffyAsync.fired();  //finished!
		}
	else {

      localjiffy = localjiffy >> 8;
      atomic jiffy = localjiffy;
      call Timer.setIntervalAndScale(localjiffy, JIFFY_SCALE  );  //sets timer,starts and enables interrupt
    }
	return(SUCCESS);
  }

  async command result_t TimerJiffyAsync.setOneShot( uint32_t _jiffy )
  {
    atomic {
      jiffy = _jiffy;
      bSet = TRUE;
    }
    if (_jiffy > 0xFF) {
      call Timer.setIntervalAndScale(0xFF, JIFFY_SCALE  );  //sets timer,starts and enables interrupt
    }
    else {
      call Timer.setIntervalAndScale(_jiffy, JIFFY_SCALE  );  // enables timer interrupt
    }
    return SUCCESS;
  }

  async command bool TimerJiffyAsync.isSet( )
  {
    return bSet;
  }

  async command result_t TimerJiffyAsync.stop()
  {
    atomic { 
      bSet = FALSE;
      call Timer.intDisable();
    }
    return SUCCESS;
  }
}//TimerJiffyAsync

