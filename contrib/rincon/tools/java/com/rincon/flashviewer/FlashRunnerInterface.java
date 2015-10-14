package com.rincon.flashviewer;

public interface FlashRunnerInterface {

	/**
	 * Read a block of data from flash
	 * @param address
	 * @param range
	 */
	public void read(long address, long range, int moteID);
	
	/**
	 * Write some bytes to flash
	 * @param address
	 * @param buffer
	 * @param length
	 */
	public void write(long address, short[] buffer, int length, int moteID);
	
	/**
	 * Erase the currently mounted sector in flash
	 *
	 */
	public void erase(int moteID);
	
	/**
	 * Mount BlockStorage to the given volume ID
	 * @param id
	 */
	public void mount(short id, int moteID);
	
	/**
	 * Commit changes to flash 
	 *
	 */
	public void commit(int moteID);
	
	/**
	 * Ping the FlashViewer on a mote
	 * @param moteID
	 */
	public void ping(int moteID);
}
