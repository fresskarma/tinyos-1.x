$Id: README_CompileInstructions.txt,v 1.1 2005/04/15 10:00:08 hjkoerber Exp $

* To compile

To compile an application for the pic18f4620 target via "make pic18f4620", you need to 
change a couple of files in the proper tinyos tree. 

  1. In the directory "opt\tinyos-1.x\tos\platform" add a new platform directory called 
     "pic18f4620" and copy all files from 
     http://cvs.sourceforge.net/viewcvs.py/tinyos/tinyos-1.x/contrib/hsu/pic18f4620
     into the local "pic18f4620" directory.

  2. Copy the Makerules file into the local "apps" directory.

  3. Copy the "tcmsb" directory into the local "sensorboards" directory.

  4. Copy the perl script "convert_tcm.pl" into the respective apps directory.

  5. In the respective apps directory type "make pic18f4620".

  6. In the respective apps directory type ./convert_pic.pl "./build/pic184620/app.c ./build/pic184620/app_pic.c".

  7. Now open Microchip MPLAB IDE and create a new project.
	 - Microchip MPLAB IDE settings:
	   under Project ->Build options -> Project ->MPLAB C18 
		in Categories->General->Default storage class
				mark Auto		
	 	in Categories->Memory Model->Stack Model
				mark Multi-blank model
		in Categories->Optimization 
				mark Disable

  8. Copy the files "app_pic.c", "cfg.h" and "18f452i.lkr" into the MPLAB IDE project directory.	

  9. Add the files form "6." to the MPLAB project.

 10. For radio communication copy the "lib_asm_modules.lib" which handles radio 
     transmitting and receiving into the MPLAB IDE project directory. Add the lib-file to
     to the MPLAB IDE project.

 11. Use a Microchip ICD2 to program the target.