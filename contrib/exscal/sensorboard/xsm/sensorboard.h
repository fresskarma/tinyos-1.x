/**
 * @author Mike Grimmer
 */
#define TOS_MAG_POT_ADDR  0
#define TOS_MIC_POT_ADDR  1
#define TOS_PIR_POT_ADDR  1
#define TOS_LPF_POT_ADDR  3
#define TOS_HPF_POT_ADDR  2


enum {
  TOSH_ACTUAL_PHOTO_PORT = 1,
  TOSH_ACTUAL_MIC_PORT = 2, 
  TOSH_ACTUAL_ACCEL_X_PORT = 3, 
  TOSH_ACTUAL_ACCEL_Y_PORT = 4,
  TOSH_ACTUAL_MAG_X_PORT = 5, 
  TOSH_ACTUAL_MAG_Y_PORT = 6,  
  TOSH_ACTUAL_PIR_PORT = 7
};

enum {
  TOS_ADC_PHOTO_PORT = 1,
  TOS_ADC_MIC_PORT = 2,
  TOS_ADC_ACCEL_X_PORT = 3,
  TOS_ADC_ACCEL_Y_PORT = 4,
  TOS_ADC_MAG_X_PORT = 5,
  TOS_ADC_MAG_Y_PORT = 6,
  TOS_ADC_PIR_PORT = 7
};

enum {
  GRENADE_1SEC = 0,
  GRENADE_4SEC = 1,
  GRENADE_32SEC = 2,
  GRENADE_1MIN = 3,
  GRENADE_34MIN = 4,
  GRENADE_1HOUR = 5,
  GRENADE_18HOUR = 6,
  GRENADE_36HOUR = 7
};


TOSH_ALIAS_PIN(PHOTO_CTL, PW0);
TOSH_ALIAS_PIN(ACCEL_CTL, PW4);
TOSH_ALIAS_OUTPUT_ONLY_PIN(MIC_CTL, PW3);
TOSH_ALIAS_OUTPUT_ONLY_PIN(SOUNDER_CTL, PW2)
TOSH_ALIAS_PIN(MAG_CTL, PW5);
TOSH_ALIAS_OUTPUT_ONLY_PIN(PIR_CTL, PW6);
TOSH_ALIAS_PIN(I2C_MUX, ALE);
TOSH_ALIAS_PIN(PIR_DETECT, INT2);
TOSH_ALIAS_PIN(AUDIO_DETECT, INT1);
TOSH_ALIAS_PIN(IRQUAD1, PWM0);
TOSH_ALIAS_PIN(IRQUAD2, PWM1A);
TOSH_ALIAS_PIN(IRQUAD3, UART_XCK0);
TOSH_ALIAS_PIN(IRQUAD4, AC_N);
