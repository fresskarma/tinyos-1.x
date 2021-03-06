#-*-Makefile-*-
# Base Makefile for nesC apps.
#
# Created: 6/2002,  Philip Levis <pal@cs.berkeley.edu>
#
# Updated: 6/18/2002 Rob von Behren <jrvb@cs.berkeley.edu>
#          Multi-platform support
#
# Updated: 6/20/2002 David Gay <dgay@intel-research.net>
#          Compile via gcc, make tos.th system-wide, not app-wide
#          (still need to ponder group selection)
#
######################################################################

# User configuration:
# Specify user values in Makelocal to override the defaults here

ifndef DEFAULT_LOCAL_GROUP
DEFAULT_LOCAL_GROUP := 0x7d
endif

# this needs to be -dlpt=3 on thinkpads
# PROGRAMMER_EXTRA_FLAGS :=
# We don't actually set it here, so you can either set the 
# PROGRAMMER_EXTRA_FLAGS environment variable (recommended) or
# define it in ../Makelocal

-include ../Makelocal


# configure the base for the app dirs.  This is used to generate more
# useful package names in the documentation.
ifeq ($(BASEDIR)_x, _x)
BASEDIR := $(shell pwd | sed 's@\(.*\)/apps.*$$@\1@' )
endif

# The output directory for generated documentation
ifeq ($(DOCDIR)_x, _x)
DOCDIR := $(BASEDIR)/doc/nesdoc
endif

##################################################
#
##################################################

PLATFORMS = mica mica128 mica2 mica2dot pc rene2 motor
#PLATFORMS = rene pc mica dot

OBJCOPY        = avr-objcopy
SET_ID         = set-mote-id
PROGRAMER      = uisp
PROGRAMMER_FLAGS=-dprog=dapa -dt_sck=1 $(PROGRAMMER_EXTRA_FLAGS)

ifdef MSG_SIZE
PFLAGS := -DTOSH_DATA_LENGTH=$(MSG_SIZE) $(PFLAGS)
endif

ifdef APP_DIR
PFLAGS := -I$(APP_DIR) $(PFLAGS)
endif

PFLAGS         := $(PFLAGS) -Wall -Wshadow -DDEF_TOS_AM_GROUP=$(DEFAULT_LOCAL_GROUP) -DVERT
TINYSEC        := false # default: disable tinysec
# The tinysec keyfile to use and the default key name (this re matches the
# first key. you can explicitly list keys by: make mica KEYNAME=mykeyname
KEYFILE        := ~/.tinyos_keyfile
KEYNAME        := '\w+'

ifeq ($(TINYSEC),true)
PFLAGS         := $(PFLAGS) -DTINYSEC_KEY="$(shell mote-key -kf $(KEYFILE) -kn $(KEYNAME))" -DTINYSEC_KEYSIZE=8
endif

NCC            = ncc
LIBS	       = -lm

######################################################################
# Choose platform options, based on MAKECMDGOALS
######################################################################


# be quieter....
#ifeq ($(VERBOSE_MAKE)_x, _x)
#MAKEFLAGS += -s
#endif
#export VERBOSE_MAKE

define USAGE


Usage:   make <platform>
         make all
         make clean
         make install[.n] <platform>
         make reinstall[.n] <platform> # no rebuild of target
         make docs <platform>

         Valid platforms are: $(PLATFORMS)


endef


PLATAUX=$(PLATFORMS) all
PLATFORM := $(filter $(PLATAUX), $(MAKECMDGOALS))
PFLAGS := -target=$(PLATFORM) $(PFLAGS)
MAKECMDGOALS := $(filter-out $(PLATAUX), $(MAKECMDGOALS))


#Sensor Board Defaults
ifeq ($(SENSORBOARD),)
	ifeq ($(PLATFORM),mica)
		SENSORBOARD = micasb
	endif
	ifeq ($(PLATFORM),mica2)
		SENSORBOARD = micasb
	endif
	ifeq ($(PLATFORM),mica128)
		SENSORBOARD = micasb
	endif
	ifeq ($(PLATFORM),rene2)
		SENSORBOARD = basicsb
	endif
	ifeq ($(PLATFORM),pc)
		SENSORBOARD = micasb
	endif
endif

BUILDDIR = build/$(PLATFORM)
MAIN_EXE = $(BUILDDIR)/main.exe
MAIN_SREC = $(BUILDDIR)/main.srec

ifeq ($(PLATFORM), pc)
PFLAGS := -g -O0 -pthread $(PFLAGS) -fnesc-nido-tosnodes=1000 -fnesc-cfile=$(BUILDDIR)/app.c
MAIN_TARGET = $(MAIN_EXE)
else
PFLAGS := -Os $(PFLAGS) -finline-limit=100000 -fnesc-cfile=$(BUILDDIR)/app.c
MAIN_TARGET = $(MAIN_SREC)
endif

NCC := $(NCC) -board=$(SENSORBOARD)


######################################################################
# Rules for documentaiton generation
######################################################################

# add documentation flags to ncc, if requested
DOCS := $(filter docs, $(MAKECMDGOALS))
MAKECMDGOALS := $(filter-out docs, $(MAKECMDGOALS))
ifeq ($(DOCS)_x, docs_x)
NCC := $(NCC) -docdir=$(DOCDIR)/$(PLATFORM) -fnesc-is-app
endif

# dummy rule for 'docs' target - so make won't complain about it
docs:
	@true



######################################################################
# top-level rules.  switch based on MAKECMDGOALS
######################################################################

#
# rules for make clean
#
ifeq ($(MAKECMDGOALS)_x, clean_x)

PLATFORM=

$(PLATAUX):
	@echo ""

else

ifeq ($(PLATFORM)_x,_x)
$(error $(PLATAUX) $(MAKECMDGOALS) $(USAGE))
endif

MAKECMDGOALS := $(patsubst install.%,install,$(MAKECMDGOALS))
MAKECMDGOALS := $(patsubst reinstall.%,reinstall,$(MAKECMDGOALS))

#
# rules for make install <platform>
#
ifeq ($(MAKECMDGOALS)_x, install_x)

$(PLATAUX):
	@true

else
ifeq ($(MAKECMDGOALS)_x, reinstall_x)

$(PLATAUX):
	@true

else
all:
	for platform in $(PLATFORMS); do \
		$(MAKE) $$platform $(DOCS) || exit 1; \
	done

$(PLATFORMS): build

endif
endif
endif

######################################################################
######################################################################
##                                                                  ##
##                      Begin main rules                            ##
##                                                                  ##
######################################################################
######################################################################

build: $(MAIN_TARGET)

install: $(MAIN_SREC) FORCE
	@$(MAKE) $(PLATFORM) re$@

install.%: $(MAIN_SREC) FORCE
	$(MAKE) $(PLATFORM) re$@

reinstall: FORCE
	@echo "    installing $(PLATFORM) binary"
	$(PROGRAMER) $(PROGRAMMER_FLAGS) --erase 
	sleep 1	             
	$(PROGRAMER) $(PROGRAMMER_FLAGS) --upload if=$(MAIN_SREC)
	sleep 1	             
	$(PROGRAMER) $(PROGRAMMER_FLAGS) --verify if=$(MAIN_SREC)
#	sleep 1	             
#	$(PROGRAMER) $(PROGRAMMER_FLAGS) --upload if=inpispm2.srec
#	sleep 1	             
#	$(PROGRAMER) $(PROGRAMMER_FLAGS) --verify if=inpispm2.srec

reinstall.%: FORCE
	@echo "    installing $(PLATFORM) binary"
	@#$(SET_ID) $(MAIN_SREC) $(MAIN_SREC).out `echo $@ |sed 's:reinstall.::g'`
	$(SET_ID) $(MAIN_SREC) $(MAIN_SREC).out `echo $@ |perl -pe 's/^reinstall.//; $$_=hex if /^0x/i;'`
	$(PROGRAMER) $(PROGRAMMER_FLAGS) --erase 
	sleep 1	             
	$(PROGRAMER) $(PROGRAMMER_FLAGS) --upload if=$(MAIN_SREC).out
	sleep 1	             
	$(PROGRAMER) $(PROGRAMMER_FLAGS) --verify if=$(MAIN_SREC).out
#	sleep 1	             
#	$(PROGRAMER) $(PROGRAMMER_FLAGS) --upload if=../inpispm2.srec
#	sleep 1	             
#	$(PROGRAMER) $(PROGRAMMER_FLAGS) --verify if=../inpispm2.srec


$(MAIN_EXE): $(BUILDDIR) FORCE
	@echo "    compiling $(COMPONENT) to a $(PLATFORM) binary"
	$(NCC) -o $(MAIN_EXE) $(PFLAGS) $(CFLAGS) $(COMPONENT).nc $(LIBS) $(LDFLAGS)
	@echo "    compiled $(COMPONENT) to $@"
	@objdump -h $(MAIN_EXE) | perl -ne '$$b{$$1}=hex $$2 if /^\s*\d+\s*\.(text|data|bss)\s+(\S+)/; END { printf("%16d bytes in ROM\n%16d bytes in RAM\n",$$b{text}+$$b{data},$$b{bss}); }'

$(MAIN_SREC): $(MAIN_EXE)
	$(OBJCOPY) --output-target=srec $(MAIN_EXE) $(MAIN_SREC)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

clean: FORCE
	rm -rf $(BUILDDIR) 
	rm -f core.*
	rm -f *~

FORCE:

.phony: FORCE

