/*
 * Copyright (c) 2005 Arched Rock Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the Arched Rock Corporation nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * ARCHED ROCK OR ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE
 *
 */

/**
 * The GetSet interface is intended for synchronous reading and
 * writing of small values. The type of the value is given as a
 * template argument. Generally, these values are backed by memory or
 * computation. Because no error code is included, both calls must be
 * guaranteed to succeed. This interface should be used when a single
 * logical unit supports both getting and setting.
 *
 * <p>
 * See TEP114 - SIDs: Source and Sink Independent Drivers for details.
 * Modified by Joe Polastre, Moteiv Corporation, to support async
 * access.
 * 
 * @param val_t the type of the object that will be stored
 *
 * @author Gilman Tolle <gtolle@archedrock.com>
 * @version $Revision: 1.1.1.1 $ $Date: 2007/11/05 19:11:23 $
 */

interface GetSet<val_t> {
  /**
   * Retrieves a value of type val_t.
   *
   * @return the value itself
   */
  async command val_t get();

  /**
   * Stores a value of type val_t.
   *
   * @param val the value to be stored
   */
  async command void set( val_t val );
}
