/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'ResultPkt'
 * message type.
 */

public class ResultPkt extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 16;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 217;

    /** Create a new ResultPkt of size 16. */
    public ResultPkt() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new ResultPkt of the given data_length. */
    public ResultPkt(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new ResultPkt with the given data_length
     * and base offset.
     */
    public ResultPkt(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new ResultPkt using the given byte array
     * as backing store.
     */
    public ResultPkt(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new ResultPkt using the given byte array
     * as backing store, with the given base offset.
     */
    public ResultPkt(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new ResultPkt using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public ResultPkt(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new ResultPkt embedded in the given message
     * at the given base offset.
     */
    public ResultPkt(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new ResultPkt embedded in the given message
     * at the given base offset and length.
     */
    public ResultPkt(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <ResultPkt> \n";
      try {
        s += "  [numFailedNodes=0x"+Long.toHexString(get_numFailedNodes())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [bytesSent=0x"+Long.toHexString(get_bytesSent())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [numRounds=0x"+Long.toHexString(get_numRounds())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [parentAddr=0x"+Long.toHexString(get_parentAddr())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [numFullUpd=0x"+Long.toHexString(get_numFullUpd())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [numDiscUpd=0x"+Long.toHexString(get_numDiscUpd())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [numFailUpd=0x"+Long.toHexString(get_numFailUpd())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: numFailedNodes
    //   Field type: int, unsigned
    //   Offset (bits): 0
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'numFailedNodes' is signed (false).
     */
    public static boolean isSigned_numFailedNodes() {
        return false;
    }

    /**
     * Return whether the field 'numFailedNodes' is an array (false).
     */
    public static boolean isArray_numFailedNodes() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'numFailedNodes'
     */
    public static int offset_numFailedNodes() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'numFailedNodes'
     */
    public static int offsetBits_numFailedNodes() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'numFailedNodes'
     */
    public int get_numFailedNodes() {
        return (int)getUIntElement(offsetBits_numFailedNodes(), 16);
    }

    /**
     * Set the value of the field 'numFailedNodes'
     */
    public void set_numFailedNodes(int value) {
        setUIntElement(offsetBits_numFailedNodes(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'numFailedNodes'
     */
    public static int size_numFailedNodes() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'numFailedNodes'
     */
    public static int sizeBits_numFailedNodes() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: bytesSent
    //   Field type: long, unsigned
    //   Offset (bits): 16
    //   Size (bits): 32
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'bytesSent' is signed (false).
     */
    public static boolean isSigned_bytesSent() {
        return false;
    }

    /**
     * Return whether the field 'bytesSent' is an array (false).
     */
    public static boolean isArray_bytesSent() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'bytesSent'
     */
    public static int offset_bytesSent() {
        return (16 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'bytesSent'
     */
    public static int offsetBits_bytesSent() {
        return 16;
    }

    /**
     * Return the value (as a long) of the field 'bytesSent'
     */
    public long get_bytesSent() {
        return (long)getUIntElement(offsetBits_bytesSent(), 32);
    }

    /**
     * Set the value of the field 'bytesSent'
     */
    public void set_bytesSent(long value) {
        setUIntElement(offsetBits_bytesSent(), 32, value);
    }

    /**
     * Return the size, in bytes, of the field 'bytesSent'
     */
    public static int size_bytesSent() {
        return (32 / 8);
    }

    /**
     * Return the size, in bits, of the field 'bytesSent'
     */
    public static int sizeBits_bytesSent() {
        return 32;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: numRounds
    //   Field type: int, unsigned
    //   Offset (bits): 48
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'numRounds' is signed (false).
     */
    public static boolean isSigned_numRounds() {
        return false;
    }

    /**
     * Return whether the field 'numRounds' is an array (false).
     */
    public static boolean isArray_numRounds() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'numRounds'
     */
    public static int offset_numRounds() {
        return (48 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'numRounds'
     */
    public static int offsetBits_numRounds() {
        return 48;
    }

    /**
     * Return the value (as a int) of the field 'numRounds'
     */
    public int get_numRounds() {
        return (int)getUIntElement(offsetBits_numRounds(), 16);
    }

    /**
     * Set the value of the field 'numRounds'
     */
    public void set_numRounds(int value) {
        setUIntElement(offsetBits_numRounds(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'numRounds'
     */
    public static int size_numRounds() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'numRounds'
     */
    public static int sizeBits_numRounds() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: parentAddr
    //   Field type: int, unsigned
    //   Offset (bits): 64
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'parentAddr' is signed (false).
     */
    public static boolean isSigned_parentAddr() {
        return false;
    }

    /**
     * Return whether the field 'parentAddr' is an array (false).
     */
    public static boolean isArray_parentAddr() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'parentAddr'
     */
    public static int offset_parentAddr() {
        return (64 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'parentAddr'
     */
    public static int offsetBits_parentAddr() {
        return 64;
    }

    /**
     * Return the value (as a int) of the field 'parentAddr'
     */
    public int get_parentAddr() {
        return (int)getUIntElement(offsetBits_parentAddr(), 16);
    }

    /**
     * Set the value of the field 'parentAddr'
     */
    public void set_parentAddr(int value) {
        setUIntElement(offsetBits_parentAddr(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'parentAddr'
     */
    public static int size_parentAddr() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'parentAddr'
     */
    public static int sizeBits_parentAddr() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: numFullUpd
    //   Field type: int, unsigned
    //   Offset (bits): 80
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'numFullUpd' is signed (false).
     */
    public static boolean isSigned_numFullUpd() {
        return false;
    }

    /**
     * Return whether the field 'numFullUpd' is an array (false).
     */
    public static boolean isArray_numFullUpd() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'numFullUpd'
     */
    public static int offset_numFullUpd() {
        return (80 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'numFullUpd'
     */
    public static int offsetBits_numFullUpd() {
        return 80;
    }

    /**
     * Return the value (as a int) of the field 'numFullUpd'
     */
    public int get_numFullUpd() {
        return (int)getUIntElement(offsetBits_numFullUpd(), 16);
    }

    /**
     * Set the value of the field 'numFullUpd'
     */
    public void set_numFullUpd(int value) {
        setUIntElement(offsetBits_numFullUpd(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'numFullUpd'
     */
    public static int size_numFullUpd() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'numFullUpd'
     */
    public static int sizeBits_numFullUpd() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: numDiscUpd
    //   Field type: int, unsigned
    //   Offset (bits): 96
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'numDiscUpd' is signed (false).
     */
    public static boolean isSigned_numDiscUpd() {
        return false;
    }

    /**
     * Return whether the field 'numDiscUpd' is an array (false).
     */
    public static boolean isArray_numDiscUpd() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'numDiscUpd'
     */
    public static int offset_numDiscUpd() {
        return (96 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'numDiscUpd'
     */
    public static int offsetBits_numDiscUpd() {
        return 96;
    }

    /**
     * Return the value (as a int) of the field 'numDiscUpd'
     */
    public int get_numDiscUpd() {
        return (int)getUIntElement(offsetBits_numDiscUpd(), 16);
    }

    /**
     * Set the value of the field 'numDiscUpd'
     */
    public void set_numDiscUpd(int value) {
        setUIntElement(offsetBits_numDiscUpd(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'numDiscUpd'
     */
    public static int size_numDiscUpd() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'numDiscUpd'
     */
    public static int sizeBits_numDiscUpd() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: numFailUpd
    //   Field type: int, unsigned
    //   Offset (bits): 112
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'numFailUpd' is signed (false).
     */
    public static boolean isSigned_numFailUpd() {
        return false;
    }

    /**
     * Return whether the field 'numFailUpd' is an array (false).
     */
    public static boolean isArray_numFailUpd() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'numFailUpd'
     */
    public static int offset_numFailUpd() {
        return (112 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'numFailUpd'
     */
    public static int offsetBits_numFailUpd() {
        return 112;
    }

    /**
     * Return the value (as a int) of the field 'numFailUpd'
     */
    public int get_numFailUpd() {
        return (int)getUIntElement(offsetBits_numFailUpd(), 16);
    }

    /**
     * Set the value of the field 'numFailUpd'
     */
    public void set_numFailUpd(int value) {
        setUIntElement(offsetBits_numFailUpd(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'numFailUpd'
     */
    public static int size_numFailUpd() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'numFailUpd'
     */
    public static int sizeBits_numFailUpd() {
        return 16;
    }

}
