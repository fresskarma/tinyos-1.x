/*
 * Copyright (c) 2004, Intel Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * Neither the name of the Intel Corporation nor the names of its contributors
 * may be used to endorse or promote products derived from this software
 * without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

/*									tab:4
 *
 *
 * "Copyright (c) 2000-2002 The Regents of the University  of California.
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

configuration PageNetworkC
{
  provides {
    interface StdControl as Control;
    interface NetworkPacket;
    interface NetworkCommand;
  }
}

implementation
{
  components NetworkCommandM,
             PageScatternetM,
             TreeRoutingM,
             NetworkDataM,
             NetworkRelayM,
             NetworkTopologyM,
             NetworkPropertiesM,
             BTBufferM,
             MemoryM,
             TimerC,
             Leds8C,
             RandomLFSR,
             WDTControlM,
             BTLowerLayersM;

  Control = NetworkCommandM.Control;
//  NetworkPacket = NetworkDataM.DataPacket;
  NetworkPacket = NetworkDataM.NetworkPacket[0];
  NetworkCommand = NetworkCommandM;

  NetworkCommandM.BTLowerLayersControl -> BTLowerLayersM;
  NetworkCommandM.HCICommand -> BTLowerLayersM;
  NetworkCommandM.HCIEvent -> BTLowerLayersM;
//  NetworkCommandM.NetworkPacket -> NetworkDataM.CommandPacket;
  NetworkCommandM.NetworkPacket -> NetworkDataM.NetworkPacket[1];
  NetworkCommandM.NetworkTopology -> NetworkTopologyM;
  NetworkCommandM.Random -> RandomLFSR;
  NetworkCommandM.ScatternetFormationControl -> PageScatternetM;
  NetworkCommandM.RouteDiscoveryControl -> TreeRoutingM;
  NetworkCommandM.RelayControl -> NetworkRelayM;

  PageScatternetM.HCICommand -> BTLowerLayersM;
  PageScatternetM.HCIEvent -> BTLowerLayersM;
  PageScatternetM.NetworkTopology -> NetworkTopologyM;
  PageScatternetM.NetworkPacket -> NetworkCommandM.ScatternetFormationPacket;

  TreeRoutingM.Timer -> TimerC.Timer[unique("Timer")];
  TreeRoutingM.NetworkPacket -> NetworkCommandM.RouteDiscoveryPacket;
  TreeRoutingM.NetworkTopology -> NetworkTopologyM;

  TreeRoutingM.NewNetworkRoute -> NetworkCommandM.NewNetworkRoute;
  NetworkCommandM.SendRoutingBroadcast -> TreeRoutingM.SendRoutingBroadcast;
  PageScatternetM.NodeConnected -> TreeRoutingM.NodeConnected;
  PageScatternetM.NodeDisconnected -> TreeRoutingM.NodeDisconnected;

  NetworkCommandM.AddPage -> PageScatternetM;

  NetworkCommandM.GetNetworkProperties -> NetworkPropertiesM.GetNetworkProperties;
  NetworkPropertiesM.NodePropertiesReady -> NetworkCommandM.NodePropertiesReady;
  NetworkPropertiesM.NetworkTopology -> NetworkTopologyM.NetworkTopology;
  NetworkPropertiesM.NetworkPacket -> NetworkCommandM.PropertiesPacket;

//  NetworkRelayM.NetworkPacket -> NetworkDataM.RelayPacket;
  NetworkRelayM.NetworkPacket -> NetworkDataM.NetworkPacket[2];

  NetworkRelayM.Timer -> TimerC.Timer[unique("Timer")];

  NetworkDataM.BTBuffer -> BTBufferM;
  NetworkDataM.HCIData -> BTLowerLayersM;
  NetworkDataM.Timer -> TimerC.Timer[unique("Timer")];
  NetworkDataM.NetworkTopology -> NetworkTopologyM;

  BTBufferM.Memory -> MemoryM;

  TreeRoutingM.WDControl -> WDTControlM.StdControl;
  TreeRoutingM.WDTControl -> WDTControlM;
  WDTControlM.Timer -> TimerC.Timer[unique("Timer")];

}
