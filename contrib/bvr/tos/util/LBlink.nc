/**
 * Used to make the leds blink a speficied number of times,
 * to easily increase the number of feedback messages one can
 * get from the leds.
 *
 * @author Rodrigo Fonseca
 */
interface LBlink {
  /** Should be called at least once before using */
  command result_t setRate(uint16_t rate);

  command result_t yellowBlink(uint8_t times);
 
  command result_t redBlink(uint8_t times);

  command result_t greenBlink(uint8_t times);
}
