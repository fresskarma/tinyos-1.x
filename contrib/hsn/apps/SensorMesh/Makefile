COMPONENT=SoIMesh
TXRES_VAL=72
PROGVER=10
NEIGHBOR_AGE_CACHE_TIMEOUT=60
DSDV_BI_DIR_QUALITY=1
DSDV_PASSIVE_ACK=1
HOPCOUNT_METRIC=0
ADJUVANT_STATUS_DEFAULT=1

LOCAL_DEFINES += -DTR_PIGGYBACK_LEN=1 -DTR_PLUGIN_LEN=2

ifdef MEASURE_METRIC
   LOCAL_DEFINES += -DMEASURE_METRIC=$(MEASURE_METRIC)
endif

ifdef USE_UART_QUEUE
   LOCAL_DEFINES += -DUSE_UART_QUEUE=$(USE_UART_QUEUE)
endif

include ../MakeHSN

