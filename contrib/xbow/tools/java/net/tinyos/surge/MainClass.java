// $Id: MainClass.java,v 1.9 2004/05/15 23:16:37 jlhill Exp $

/*									tab:4
 * "Copyright (c) 2000-2003 The Regents of the University  of California.  
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
 * Copyright (c) 2002-2003 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */


/**
 * @author Wei Hong
 * @author adapted for tinydb
 */

//***********************************************************************
//***********************************************************************
//this is the main class that holds all global variables
//and from where "main" is run.
//the global variables can be accessed as: MainClass.MainFrame for example.
//***********************************************************************
//***********************************************************************

package net.tinyos.surge;

import java.util.*;
import net.tinyos.util.*;
import net.tinyos.message.*;
import net.tinyos.surge.event.*;
import net.tinyos.surge.util.*;
import net.tinyos.surge.stats.*;
import net.tinyos.surge.PacketAnalyzer.*;
import net.tinyos.surge.Dialog.*;
import javax.swing.event.*;
import java.beans.*;
import java.awt.*;
import java.io.*;
import javax.swing.*;


public class MainClass {

  public static MoteIF mote;
  public static MainFrame mainFrame;
  public static TextFrame stats;
  public static DisplayManager displayManager;
  public static ObjectMaintainer objectMaintainer;
  public static FlowAnalyzer flowAnalyzer;
  public static SensorAnalyzer sensorAnalyzer;
  public static LocationAnalyzer locationAnalyzer;
  public static Vector packetAnalyzers;

  private static void usage() {
    System.err.println("Usage: java net.tinyos.surge.MainClass <group_id>");
    System.exit(-1);
  }

  public static void main(String args[]) {
    try {
      if (args.length != 1) usage();
      int groupID;
      if (args[0].startsWith("0x") || args[0].startsWith("0X")) {
	groupID = Integer.parseInt(args[0].substring(2), 16);
      } else {
	groupID = Integer.parseInt(args[0]);
      }
      //System.err.println("Using AM group ID "+groupID+" (0x"+Integer.toHexString(groupID)+")");
      MainClass mc = new MainClass(groupID);
    } catch (Exception e) {
      System.err.println("main() got exception: "+e);
      e.printStackTrace();
      System.exit(-1);
    }

  }

	// this is for a non-Frame based version....

  public MainClass() throws Exception {
    new Splash();
    System.err.println("Creating mainFrame...");
    mainFrame = new MainFrame("Sensor Network Topology");
    displayManager = new DisplayManager(mainFrame);


    packetAnalyzers = new Vector();	

    System.err.println("Creating ObjectMaintainer...");
    objectMaintainer = new ObjectMaintainer();
    objectMaintainer.AddEdgeEventListener(displayManager);
    objectMaintainer.AddNodeEventListener(displayManager);

    System.err.println("Creating SensorAnalyzer...");
    sensorAnalyzer = new SensorAnalyzer();
    System.err.println("Creating LocationAnalyzer...");
    locationAnalyzer = new LocationAnalyzer();

    packetAnalyzers.add(sensorAnalyzer);

    mainFrame.setVisible(true);

  }


  public MainClass(int groupID ) throws Exception {


    new Splash();

    try{Thread.sleep(2000);} catch (Exception e){}


    //System.err.println("Starting mote listener...");
    mote = new MoteIF(PrintStreamMessenger.err, groupID);

    //System.err.println("Creating mainFrame...");
    mainFrame = new MainFrame("Sensor Network Topology");
    displayManager = new DisplayManager((MainFrame)mainFrame);

    packetAnalyzers = new Vector();	

    //System.err.println("Creating ObjectMaintainer...");
    objectMaintainer = new ObjectMaintainer();
    objectMaintainer.AddEdgeEventListener(displayManager);
    objectMaintainer.AddNodeEventListener(displayManager);

    //System.err.println("Creating LocationAnalyzer...");
    locationAnalyzer = new LocationAnalyzer();
    //System.err.println("Creating SensorAnalyzer...");
    sensorAnalyzer = new SensorAnalyzer();
    flowAnalyzer = new FlowAnalyzer();

    packetAnalyzers.add(objectMaintainer);
    packetAnalyzers.add(flowAnalyzer);
    packetAnalyzers.add(sensorAnalyzer);

    //System.err.println("Making MainFrame visible...");
    //make the MainFrame visible as the last thing
    mainFrame.setVisible(true);
    //System.err.println("Ready.");

    String log = "node Number#";
    log += "Message Count" + "#";
    log += "String Date" + "#";
    log += "Time" + "#";
    log += "interval" + "#";
    log += "parent" + "#";
    log += "Message Rate" + "#";
    log += "Sequence Number" + "#";
    log += "hopcount" + "#";
    log += "mAm" + "#";
    log += "Batt" + "#";
    for(int i = 0; i < 5;i ++){
        log += "id " + i + "#";
        log += "hopount " + i + "#";
        log += "quality " + i + "#";
    }
    log += "Temp" + "#";
    log += "Light" + "#";


    //System.err.println("Creating stats...");
    stats = new TextFrame();
	

   System.out.println(log);
  }

  public static MoteIF getMoteIF() {
    return mote;
  }

}
