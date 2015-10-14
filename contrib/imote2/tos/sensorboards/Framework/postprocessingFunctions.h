#ifndef __POSTPROCESSINGFUNCTION_H__
#define __POSTPROCESSINGFUNCTION_H__

//constants in this file are based on the Collection Variables.xls generated by Mick Flanigan.  Otherwise, the assignments are arbitrary

//NONE is just a placeholder

#define NONE (0) 

#define SPECTRUM_CALC(_x) ((_x & 0x3)<<1)
#define GET_SPECTRUM_CALC(_x) ((_x >>1) & 0x3)
#define SPECTRUM_NONE    (0)
#define SPECTRUM_FFT     (1)
#define SPECTRUM_GSE     (2)

#define MAG_CALC         (1 << 3)
#define GET_MAG_CALC(_x) ((_x>>3) & 0x1)

#define AVG_CALC(_x) ((_x & 0x7)<<4)
#define GET_AVG_CALC(_x) ((_x >>4) & 0x7)
#define AVG_NONE         (0)
#define AVG_LINEAR       (1)
#define AVG_TIMESYNC     (2)
#define AVG_EXPONENTIAL  (3)
#define AVG_PEAKHOLD     (4)


#define WINDOW_CALC(_x)     ((_x & 0x7)<<7)
#define GET_WINDOW_CALC(_x) ((_x >>7) & 0x7)
#define WIN_NONE         (0)
#define WIN_RECTANGULAR  (1)
#define WIN_HANNING      (2)
#define WIN_FLATTOP      (3)
#define WIN_HAMMING      (4)
#define WIN_KAISERBESSEL (5)
#define WIN_COS4         (6)

#define SIGNAL_DETECTION_CALC(_x) ((_x & 0x3) <<10)
#define GET_SIGNAL_DETECTION_CALC(_x) ((_x >> 10) & 0x3)
#define SIGNAL_DETECTION_INVALID (0) //note, SIGNAL_DETECTION MUST be a value!
#define SIGNAL_DETECTION_RMS  (1)
#define SIGNAL_DETECTION_PEAK (2)
#define SIGNAL_DETECTION_PKPK (3)


#define TACHOMETER_CALC(_x)         ((_x & 0x3) <<12)
#define GET_TACHOMETER_CALC(_x)     ((_x >> 12) & 0x3)

#define TACHOMETER_NONE      (0)
#define TACHOMETER_RPM       (1)
#define TACHOMETER_PHASE     (2)


//total number of bits currently used = 1 + 2 + 1 + 3 + 3 + 2 + 2 = 14 bits
#endif