/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'BaseTOSMsg'
 * message type.
 */

package net.tinyos.message.eyesIFX;

public class BaseTOSMsg extends net.tinyos.message.TOSMsg {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 50;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = -1;

    /** Create a new BaseTOSMsg of size 50. */
    public BaseTOSMsg() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new BaseTOSMsg of the given data_length. */
    public BaseTOSMsg(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new BaseTOSMsg with the given data_length
     * and base offset.
     */
    public BaseTOSMsg(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new BaseTOSMsg using the given byte array
     * as backing store.
     */
    public BaseTOSMsg(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new BaseTOSMsg using the given byte array
     * as backing store, with the given base offset.
     */
    public BaseTOSMsg(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new BaseTOSMsg using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public BaseTOSMsg(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new BaseTOSMsg embedded in the given message
     * at the given base offset.
     */
    public BaseTOSMsg(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new BaseTOSMsg embedded in the given message
     * at the given base offset and length.
     */
    public BaseTOSMsg(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <BaseTOSMsg> \n";
      try {
        s += "  [length=0x"+Long.toHexString(get_length())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [group=0x"+Long.toHexString(get_group())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [type=0x"+Long.toHexString(get_type())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [seq_num=0x"+Long.toHexString(get_seq_num())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [addr=0x"+Long.toHexString(get_addr())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [s_addr=0x"+Long.toHexString(get_s_addr())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [data=";
        for (int i = 0; i < 28; i++) {
          s += "0x"+Long.toHexString(getElement_data(i) & 0xff)+" ";
        }
        s += "]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [crc=0x"+Long.toHexString(get_crc())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [strength=0x"+Long.toHexString(get_strength())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [ack=0x"+Long.toHexString(get_ack())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [time_s=0x"+Long.toHexString(get_time_s())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [time_ms=0x"+Long.toHexString(get_time_ms())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: length
    //   Field type: short, unsigned
    //   Offset (bits): 0
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'length' is signed (false).
     */
    public static boolean isSigned_length() {
        return false;
    }

    /**
     * Return whether the field 'length' is an array (false).
     */
    public static boolean isArray_length() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'length'
     */
    public int offset_length() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'length'
     */
    public static int offsetBits_length() {
        return 0;
    }

    /**
     * Return the value (as a short) of the field 'length'
     */
    public short get_length() {
        return (short)getUIntElement(offsetBits_length(), 8);
    }

    /**
     * Set the value of the field 'length'
     */
    public void set_length(short value) {
        setUIntElement(offsetBits_length(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'length'
     */
    public static int size_length() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'length'
     */
    public static int sizeBits_length() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: group
    //   Field type: short, unsigned
    //   Offset (bits): 8
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'group' is signed (false).
     */
    public static boolean isSigned_group() {
        return false;
    }

    /**
     * Return whether the field 'group' is an array (false).
     */
    public static boolean isArray_group() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'group'
     */
    public static int offset_group() {
        return (8 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'group'
     */
    public static int offsetBits_group() {
        return 8;
    }

    /**
     * Return the value (as a short) of the field 'group'
     */
    public short get_group() {
        return (short)getUIntElement(offsetBits_group(), 8);
    }

    /**
     * Set the value of the field 'group'
     */
    public void set_group(short value) {
        setUIntElement(offsetBits_group(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'group'
     */
    public static int size_group() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'group'
     */
    public static int sizeBits_group() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: type
    //   Field type: short, unsigned
    //   Offset (bits): 16
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'type' is signed (false).
     */
    public static boolean isSigned_type() {
        return false;
    }

    /**
     * Return whether the field 'type' is an array (false).
     */
    public static boolean isArray_type() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'type'
     */
    public static int offset_type() {
        return (16 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'type'
     */
    public static int offsetBits_type() {
        return 16;
    }

    /**
     * Return the value (as a short) of the field 'type'
     */
    public short get_type() {
        return (short)getUIntElement(offsetBits_type(), 8);
    }

    /**
     * Set the value of the field 'type'
     */
    public void set_type(short value) {
        setUIntElement(offsetBits_type(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'type'
     */
    public static int size_type() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'type'
     */
    public static int sizeBits_type() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: seq_num
    //   Field type: short, unsigned
    //   Offset (bits): 24
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'seq_num' is signed (false).
     */
    public static boolean isSigned_seq_num() {
        return false;
    }

    /**
     * Return whether the field 'seq_num' is an array (false).
     */
    public static boolean isArray_seq_num() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'seq_num'
     */
    public static int offset_seq_num() {
        return (24 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'seq_num'
     */
    public static int offsetBits_seq_num() {
        return 24;
    }

    /**
     * Return the value (as a short) of the field 'seq_num'
     */
    public short get_seq_num() {
        return (short)getUIntElement(offsetBits_seq_num(), 8);
    }

    /**
     * Set the value of the field 'seq_num'
     */
    public void set_seq_num(short value) {
        setUIntElement(offsetBits_seq_num(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'seq_num'
     */
    public static int size_seq_num() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'seq_num'
     */
    public static int sizeBits_seq_num() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: addr
    //   Field type: int, unsigned
    //   Offset (bits): 32
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'addr' is signed (false).
     */
    public static boolean isSigned_addr() {
        return false;
    }

    /**
     * Return whether the field 'addr' is an array (false).
     */
    public static boolean isArray_addr() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'addr'
     */
    public static int offset_addr() {
        return (32 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'addr'
     */
    public static int offsetBits_addr() {
        return 32;
    }

    /**
     * Return the value (as a int) of the field 'addr'
     */
    public int get_addr() {
        return (int)getUIntElement(offsetBits_addr(), 16);
    }

    /**
     * Set the value of the field 'addr'
     */
    public void set_addr(int value) {
        setUIntElement(offsetBits_addr(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'addr'
     */
    public static int size_addr() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'addr'
     */
    public static int sizeBits_addr() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: s_addr
    //   Field type: int, unsigned
    //   Offset (bits): 48
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 's_addr' is signed (false).
     */
    public static boolean isSigned_s_addr() {
        return false;
    }

    /**
     * Return whether the field 's_addr' is an array (false).
     */
    public static boolean isArray_s_addr() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 's_addr'
     */
    public static int offset_s_addr() {
        return (48 / 8);
    }

    /**
     * Return the offset (in bits) of the field 's_addr'
     */
    public static int offsetBits_s_addr() {
        return 48;
    }

    /**
     * Return the value (as a int) of the field 's_addr'
     */
    public int get_s_addr() {
        return (int)getUIntElement(offsetBits_s_addr(), 16);
    }

    /**
     * Set the value of the field 's_addr'
     */
    public void set_s_addr(int value) {
        setUIntElement(offsetBits_s_addr(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 's_addr'
     */
    public static int size_s_addr() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 's_addr'
     */
    public static int sizeBits_s_addr() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: data
    //   Field type: byte[], unsigned
    //   Offset (bits): 64
    //   Size of each element (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'data' is signed (false).
     */
    public static boolean isSigned_data() {
        return false;
    }

    /**
     * Return whether the field 'data' is an array (true).
     */
    public static boolean isArray_data() {
        return true;
    }

    /**
     * Return the offset (in bytes) of the field 'data'
     */
    public int offset_data(int index1) {
        int offset = 64;
        if (index1 < 0 || index1 >= 28) throw new ArrayIndexOutOfBoundsException();
        offset += 0 + index1 * 8;
        return (offset / 8);
    }

    /**
     * Return the offset (in bits) of the field 'data'
     */
    public static int offsetBits_data(int index1) {
        int offset = 64;
        if (index1 < 0 || index1 >= 28) throw new ArrayIndexOutOfBoundsException();
        offset += 0 + index1 * 8;
        return offset;
    }

    /**
     * Return the entire array 'data' as a byte[]
     */
    public byte[] get_data() {
        byte[] tmp = new byte[28];
        for (int index0 = 0; index0 < numElements_data(0); index0++) {
            tmp[index0] = getElement_data(index0);
        }
        return tmp;
    }

    /**
     * Set the contents of the array 'data' from the given byte[]
     */
    public void set_data(byte[] value) {
        for (int index0 = 0; index0 < value.length; index0++) {
            setElement_data(index0, value[index0]);
        }
    }

    /**
     * Return an element (as a byte) of the array 'data'
     */
    public byte getElement_data(int index1) {
        return (byte)getSIntElement(offsetBits_data(index1), 8);
    }

    /**
     * Set an element of the array 'data'
     */
    public void setElement_data(int index1, byte value) {
        setSIntElement(offsetBits_data(index1), 8, value);
    }

    /**
     * Return the total size, in bytes, of the array 'data'
     */
    public int totalSize_data() {
        return (224 / 8);
    }

    /**
     * Return the total size, in bits, of the array 'data'
     */
    public int totalSizeBits_data() {
        return 224;
    }

    /**
     * Return the size, in bytes, of each element of the array 'data'
     */
    public static int elementSize_data() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of each element of the array 'data'
     */
    public static int elementSizeBits_data() {
        return 8;
    }

    /**
     * Return the number of dimensions in the array 'data'
     */
    public static int numDimensions_data() {
        return 1;
    }

    /**
     * Return the number of elements in the array 'data'
     */
    public int numElements_data() {
        return 28;
    }

    /**
     * Return the number of elements in the array 'data'
     * for the given dimension.
     */
    public int numElements_data(int dimension) {
      int array_dims[] = { 28,  };
        if (dimension < 0 || dimension >= 1) throw new ArrayIndexOutOfBoundsException();
        if (array_dims[dimension] == 0) throw new IllegalArgumentException("Array dimension "+dimension+" has unknown size");
        return array_dims[dimension];
    }

    /**
     * Fill in the array 'data' with a String
     */
    public void setString_data(String s) { 
         int len = s.length();
         int i;
         for (i = 0; i < len; i++) {
             setElement_data(i, (byte)s.charAt(i));
         }
         setElement_data(i, (byte)0); //null terminate
    }

    /**
     * Read the array 'data' as a String
     */
    public String getString_data() { 
         char carr[] = new char[Math.min(net.tinyos.message.Message.MAX_CONVERTED_STRING_LENGTH,28)];
         int i;
         for (i = 0; i < carr.length; i++) {
             if ((char)getElement_data(i) == (char)0) break;
             carr[i] = (char)getElement_data(i);
         }
         return new String(carr,0,i);
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: crc
    //   Field type: int, unsigned
    //   Offset (bits): 288
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'crc' is signed (false).
     */
    public static boolean isSigned_crc() {
        return false;
    }

    /**
     * Return whether the field 'crc' is an array (false).
     */
    public static boolean isArray_crc() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'crc'
     */
    public int offset_crc() {
        return (288 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'crc'
     */
    public int offsetBits_crc() {
        return 288;
    }

    /**
     * Return the value (as a int) of the field 'crc'
     */
    public int get_crc() {
        return (int)getUIntElement(offsetBits_crc(), 16);
    }

    /**
     * Set the value of the field 'crc'
     */
    public void set_crc(int value) {
        setUIntElement(offsetBits_crc(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'crc'
     */
    public static int size_crc() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'crc'
     */
    public static int sizeBits_crc() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: strength
    //   Field type: int, unsigned
    //   Offset (bits): 304
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'strength' is signed (false).
     */
    public static boolean isSigned_strength() {
        return false;
    }

    /**
     * Return whether the field 'strength' is an array (false).
     */
    public static boolean isArray_strength() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'strength'
     */
    public static int offset_strength() {
        return (304 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'strength'
     */
    public static int offsetBits_strength() {
        return 304;
    }

    /**
     * Return the value (as a int) of the field 'strength'
     */
    public int get_strength() {
        return (int)getUIntElement(offsetBits_strength(), 16);
    }

    /**
     * Set the value of the field 'strength'
     */
    public void set_strength(int value) {
        setUIntElement(offsetBits_strength(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'strength'
     */
    public static int size_strength() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'strength'
     */
    public static int sizeBits_strength() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: ack
    //   Field type: short, unsigned
    //   Offset (bits): 320
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'ack' is signed (false).
     */
    public static boolean isSigned_ack() {
        return false;
    }

    /**
     * Return whether the field 'ack' is an array (false).
     */
    public static boolean isArray_ack() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'ack'
     */
    public static int offset_ack() {
        return (320 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'ack'
     */
    public static int offsetBits_ack() {
        return 320;
    }

    /**
     * Return the value (as a short) of the field 'ack'
     */
    public short get_ack() {
        return (short)getUIntElement(offsetBits_ack(), 8);
    }

    /**
     * Set the value of the field 'ack'
     */
    public void set_ack(short value) {
        setUIntElement(offsetBits_ack(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'ack'
     */
    public static int size_ack() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'ack'
     */
    public static int sizeBits_ack() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: time_s
    //   Field type: long, unsigned
    //   Offset (bits): 336
    //   Size (bits): 32
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'time_s' is signed (false).
     */
    public static boolean isSigned_time_s() {
        return false;
    }

    /**
     * Return whether the field 'time_s' is an array (false).
     */
    public static boolean isArray_time_s() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'time_s'
     */
    public static int offset_time_s() {
        return (336 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'time_s'
     */
    public static int offsetBits_time_s() {
        return 336;
    }

    /**
     * Return the value (as a long) of the field 'time_s'
     */
    public long get_time_s() {
        return (long)getUIntElement(offsetBits_time_s(), 32);
    }

    /**
     * Set the value of the field 'time_s'
     */
    public void set_time_s(long value) {
        setUIntElement(offsetBits_time_s(), 32, value);
    }

    /**
     * Return the size, in bytes, of the field 'time_s'
     */
    public static int size_time_s() {
        return (32 / 8);
    }

    /**
     * Return the size, in bits, of the field 'time_s'
     */
    public static int sizeBits_time_s() {
        return 32;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: time_ms
    //   Field type: long, unsigned
    //   Offset (bits): 368
    //   Size (bits): 32
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'time_ms' is signed (false).
     */
    public static boolean isSigned_time_ms() {
        return false;
    }

    /**
     * Return whether the field 'time_ms' is an array (false).
     */
    public static boolean isArray_time_ms() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'time_ms'
     */
    public static int offset_time_ms() {
        return (368 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'time_ms'
     */
    public static int offsetBits_time_ms() {
        return 368;
    }

    /**
     * Return the value (as a long) of the field 'time_ms'
     */
    public long get_time_ms() {
        return (long)getUIntElement(offsetBits_time_ms(), 32);
    }

    /**
     * Set the value of the field 'time_ms'
     */
    public void set_time_ms(long value) {
        setUIntElement(offsetBits_time_ms(), 32, value);
    }

    /**
     * Return the size, in bytes, of the field 'time_ms'
     */
    public static int size_time_ms() {
        return (32 / 8);
    }

    /**
     * Return the size, in bits, of the field 'time_ms'
     */
    public static int sizeBits_time_ms() {
        return 32;
    }

}
