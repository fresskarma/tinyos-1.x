/**
 * This class is automatically generated by mig. DO NOT EDIT THIS FILE.
 * This class implements a Java interface to the 'PongMsg'
 * message type.
 */

public class PongMsg extends net.tinyos.message.Message {

    /** The default size of this message type in bytes. */
    public static final int DEFAULT_MESSAGE_SIZE = 8;

    /** The Active Message type associated with this message. */
    public static final int AM_TYPE = 8;

    /** Create a new PongMsg of size 8. */
    public PongMsg() {
        super(DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /** Create a new PongMsg of the given data_length. */
    public PongMsg(int data_length) {
        super(data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new PongMsg with the given data_length
     * and base offset.
     */
    public PongMsg(int data_length, int base_offset) {
        super(data_length, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new PongMsg using the given byte array
     * as backing store.
     */
    public PongMsg(byte[] data) {
        super(data);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new PongMsg using the given byte array
     * as backing store, with the given base offset.
     */
    public PongMsg(byte[] data, int base_offset) {
        super(data, base_offset);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new PongMsg using the given byte array
     * as backing store, with the given base offset and data length.
     */
    public PongMsg(byte[] data, int base_offset, int data_length) {
        super(data, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new PongMsg embedded in the given message
     * at the given base offset.
     */
    public PongMsg(net.tinyos.message.Message msg, int base_offset) {
        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);
        amTypeSet(AM_TYPE);
    }

    /**
     * Create a new PongMsg embedded in the given message
     * at the given base offset and length.
     */
    public PongMsg(net.tinyos.message.Message msg, int base_offset, int data_length) {
        super(msg, base_offset, data_length);
        amTypeSet(AM_TYPE);
    }

    /**
    /* Return a String representation of this message. Includes the
     * message type name and the non-indexed field values.
     */
    public String toString() {
      String s = "Message <PongMsg> \n";
      try {
        s += "  [src=0x"+Long.toHexString(get_src())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [src_rssi=0x"+Long.toHexString(get_src_rssi())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [src_lqi=0x"+Long.toHexString(get_src_lqi())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [dest=0x"+Long.toHexString(get_dest())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [dest_rssi=0x"+Long.toHexString(get_dest_rssi())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      try {
        s += "  [dest_lqi=0x"+Long.toHexString(get_dest_lqi())+"]\n";
      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }
      return s;
    }

    // Message-type-specific access methods appear below.

    /////////////////////////////////////////////////////////
    // Accessor methods for field: src
    //   Field type: int, unsigned
    //   Offset (bits): 0
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'src' is signed (false).
     */
    public static boolean isSigned_src() {
        return false;
    }

    /**
     * Return whether the field 'src' is an array (false).
     */
    public static boolean isArray_src() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'src'
     */
    public static int offset_src() {
        return (0 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'src'
     */
    public static int offsetBits_src() {
        return 0;
    }

    /**
     * Return the value (as a int) of the field 'src'
     */
    public int get_src() {
        return (int)getUIntElement(offsetBits_src(), 16);
    }

    /**
     * Set the value of the field 'src'
     */
    public void set_src(int value) {
        setUIntElement(offsetBits_src(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'src'
     */
    public static int size_src() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'src'
     */
    public static int sizeBits_src() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: src_rssi
    //   Field type: short, unsigned
    //   Offset (bits): 16
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'src_rssi' is signed (false).
     */
    public static boolean isSigned_src_rssi() {
        return false;
    }

    /**
     * Return whether the field 'src_rssi' is an array (false).
     */
    public static boolean isArray_src_rssi() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'src_rssi'
     */
    public static int offset_src_rssi() {
        return (16 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'src_rssi'
     */
    public static int offsetBits_src_rssi() {
        return 16;
    }

    /**
     * Return the value (as a short) of the field 'src_rssi'
     */
    public short get_src_rssi() {
        return (short)getUIntElement(offsetBits_src_rssi(), 8);
    }

    /**
     * Set the value of the field 'src_rssi'
     */
    public void set_src_rssi(short value) {
        setUIntElement(offsetBits_src_rssi(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'src_rssi'
     */
    public static int size_src_rssi() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'src_rssi'
     */
    public static int sizeBits_src_rssi() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: src_lqi
    //   Field type: short, unsigned
    //   Offset (bits): 24
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'src_lqi' is signed (false).
     */
    public static boolean isSigned_src_lqi() {
        return false;
    }

    /**
     * Return whether the field 'src_lqi' is an array (false).
     */
    public static boolean isArray_src_lqi() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'src_lqi'
     */
    public static int offset_src_lqi() {
        return (24 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'src_lqi'
     */
    public static int offsetBits_src_lqi() {
        return 24;
    }

    /**
     * Return the value (as a short) of the field 'src_lqi'
     */
    public short get_src_lqi() {
        return (short)getUIntElement(offsetBits_src_lqi(), 8);
    }

    /**
     * Set the value of the field 'src_lqi'
     */
    public void set_src_lqi(short value) {
        setUIntElement(offsetBits_src_lqi(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'src_lqi'
     */
    public static int size_src_lqi() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'src_lqi'
     */
    public static int sizeBits_src_lqi() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: dest
    //   Field type: int, unsigned
    //   Offset (bits): 32
    //   Size (bits): 16
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'dest' is signed (false).
     */
    public static boolean isSigned_dest() {
        return false;
    }

    /**
     * Return whether the field 'dest' is an array (false).
     */
    public static boolean isArray_dest() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'dest'
     */
    public static int offset_dest() {
        return (32 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'dest'
     */
    public static int offsetBits_dest() {
        return 32;
    }

    /**
     * Return the value (as a int) of the field 'dest'
     */
    public int get_dest() {
        return (int)getUIntElement(offsetBits_dest(), 16);
    }

    /**
     * Set the value of the field 'dest'
     */
    public void set_dest(int value) {
        setUIntElement(offsetBits_dest(), 16, value);
    }

    /**
     * Return the size, in bytes, of the field 'dest'
     */
    public static int size_dest() {
        return (16 / 8);
    }

    /**
     * Return the size, in bits, of the field 'dest'
     */
    public static int sizeBits_dest() {
        return 16;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: dest_rssi
    //   Field type: short, unsigned
    //   Offset (bits): 48
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'dest_rssi' is signed (false).
     */
    public static boolean isSigned_dest_rssi() {
        return false;
    }

    /**
     * Return whether the field 'dest_rssi' is an array (false).
     */
    public static boolean isArray_dest_rssi() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'dest_rssi'
     */
    public static int offset_dest_rssi() {
        return (48 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'dest_rssi'
     */
    public static int offsetBits_dest_rssi() {
        return 48;
    }

    /**
     * Return the value (as a short) of the field 'dest_rssi'
     */
    public short get_dest_rssi() {
        return (short)getUIntElement(offsetBits_dest_rssi(), 8);
    }

    /**
     * Set the value of the field 'dest_rssi'
     */
    public void set_dest_rssi(short value) {
        setUIntElement(offsetBits_dest_rssi(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'dest_rssi'
     */
    public static int size_dest_rssi() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'dest_rssi'
     */
    public static int sizeBits_dest_rssi() {
        return 8;
    }

    /////////////////////////////////////////////////////////
    // Accessor methods for field: dest_lqi
    //   Field type: short, unsigned
    //   Offset (bits): 56
    //   Size (bits): 8
    /////////////////////////////////////////////////////////

    /**
     * Return whether the field 'dest_lqi' is signed (false).
     */
    public static boolean isSigned_dest_lqi() {
        return false;
    }

    /**
     * Return whether the field 'dest_lqi' is an array (false).
     */
    public static boolean isArray_dest_lqi() {
        return false;
    }

    /**
     * Return the offset (in bytes) of the field 'dest_lqi'
     */
    public static int offset_dest_lqi() {
        return (56 / 8);
    }

    /**
     * Return the offset (in bits) of the field 'dest_lqi'
     */
    public static int offsetBits_dest_lqi() {
        return 56;
    }

    /**
     * Return the value (as a short) of the field 'dest_lqi'
     */
    public short get_dest_lqi() {
        return (short)getUIntElement(offsetBits_dest_lqi(), 8);
    }

    /**
     * Set the value of the field 'dest_lqi'
     */
    public void set_dest_lqi(short value) {
        setUIntElement(offsetBits_dest_lqi(), 8, value);
    }

    /**
     * Return the size, in bytes, of the field 'dest_lqi'
     */
    public static int size_dest_lqi() {
        return (8 / 8);
    }

    /**
     * Return the size, in bits, of the field 'dest_lqi'
     */
    public static int sizeBits_dest_lqi() {
        return 8;
    }

}
