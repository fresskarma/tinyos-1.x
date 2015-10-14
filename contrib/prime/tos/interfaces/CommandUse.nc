/*									tab:4
 *  IMPORTANT: READ BEFORE DOWNLOADING, COPYING, INSTALLING OR USING.  By
 *  downloading, copying, installing or using the software you agree to
 *  this license.  If you do not agree to this license, do not download,
 *  install, copy or use the software.
 *
 *  Intel Open Source License 
 *
 *  Copyright (c) 2002 Intel Corporation 
 *  All rights reserved. 
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 * 
 *	Redistributions of source code must retain the above copyright
 *  notice, this list of conditions and the following disclaimer.
 *	Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *      Neither the name of the Intel Corporation nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE INTEL OR ITS
 *  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * 
 */
/* 
 * Authors:  Wei Hong
 *           Intel Research Berkeley Lab
 * Date:     6/27/2002
 *
 */

includes SchemaType;
includes Command;

/** Interface for using Commands.  Commands provide a generic mechanism for registering
    and executing named commands via AM messages or a local interface.
    <p>
    See lib/Commands/... for examples of components that register commands.
    <p>
    See interfaces/Command.h for the data structures used in this interface 
    <p>
    Implemented by lib/Command.td
    <p>
    @author Wei Hong (wei.hong@intel-research.net)
*/
interface CommandUse
{
  /** Get a descriptor for the specified command
      @param name The (8 byte or shorted, null-terminated) name for the command of interest.
      @return A pointer to the command descriptior, or NULL if no such command exists.
  */
  command CommandDescPtr getCommand(char *name);
  /** Get a descriptor for a specified command id
      @param idx The (0-based) index of the command of interest
      @return A pointer to the command descriptor, or NULL if no such command exists.
  */
  command CommandDescPtr getCommandById(uint8_t idx);
  
  /** @return The number of commands currently registered with the system */
  command uint8_t numCommands();

  /** @return A list of all the commands in the system */
  command CommandDescsPtr getCommands();

  /** Invoke the specified command by name, with the specified parameters.
     Write the results into the specified buffer.
     @param commandName The command to invoke.
     @param resultBuf The buffer to write results into (must be at least sizeOf(CommandDesc.retType) bytes long)
     @param errorNo (on return) The result code (may signal a split-phase invocation, for which a commandDone event will be fired later)
                    See SchemaType.h for a list of possible result codes
     @param params The parameters to this funtion.
  */
  command result_t invoke(char *commandName, char *resultBuf, SchemaErrorNo *errorNo, ParamVals *params);

  command result_t invokeById(uint8_t commandId, char *resultBuf, SchemaErrorNo *errorNo, ParamVals *params);

  /** Given a msg represent a command invocation, invoke the appropriate command, writing results to
      resultBuf. See invoke(...) above
      @param msg The command message.  The format of this message is a packed array representing the name of
                 the command, followed by a packed list of parameters.  See java/net/tinyos/tinydb/CommandMsgs.java
		 for an example of a Java program that invokes a command.
      @param resultBuf The result buffer to write results into 
      @param errorNo (on return)The result code
  */
  command result_t invokeMsg(TOS_MsgPtr msg, char *resultBuf, SchemaErrorNo *errorNo);

  /** Given a buffer represent a command invocation (in the format used inside
      command messages), invoke the appropriate command, writing results to
      resultBuf. See invoke(...) above
      @param buffer The command description.  The format of this buffer is a packed array representing the name of
                 the command, followed by a packed list of parameters.  See java/net/tinyos/tinydb/CommandMsgs.java
		 for an example of a Java program that fills this buffer.
		 This buffer must remain valid for the duration of command execution.
      @param resultBuf The result buffer to write results into 
      @param errorNo (on return)The result code
  */
  command result_t invokeBuffer(char *buffer, char *resultBuf, SchemaErrorNo *errorNo);
  
  /** Signalled when a command invocation is complete 
      @param commandName The command that was completed
      @param resultBuf The buffer where the results were written
      @param errorNo The return code from the invocation.
  */
  event result_t commandDone(char *commandName, char *resultBuf, SchemaErrorNo errorNo);
}
