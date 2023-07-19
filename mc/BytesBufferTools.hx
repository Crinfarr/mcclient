package mc;

import haxe.Exception;
import haxe.io.BytesBuffer;
import haxe.io.Bytes;

using mc.BytesBufferTools;
using mc.ByteTools;

/**
 * THIS CLASS SHOULD BE USED ONLY WITH `using BytesBufferTools`.
 * 
 * All methods are designed to work as BytesBuffer.(Method)
 */
class BytesBufferTools {
	/**
	 * Writes a variable length integer to the buffer
	 * @param i Any number
	 */
	public static function writeVarInt(intbuf:BytesBuffer, i:Int) {
		final buf:BytesBuffer = new BytesBuffer();
		final SEGMENT_BITS = 0x7f;
		final CONTINUE_BIT = 0x80;

		while (true) {
			if (i & ~SEGMENT_BITS == 0) {
				buf.addByte(i);
				break;
			}
			buf.addByte((i & SEGMENT_BITS) | CONTINUE_BIT);
			i >>>= 7;
		}
		intbuf.add(buf.getBytes());
	}

	/**
	 * Writes a string to the buffer as an array of utf-8 encoded bytes.
	 *  
	 * @param i the string to write
	 */
	public static function writeStringVarInt(intbuf:BytesBuffer, i:String) {
		intbuf.writeVarInt(Bytes.ofString(i, UTF8).length);
		intbuf.addString(i);
	}

	/**
	 * Writes a UInt16 to the buffer.
	 * @param i any number between 0 and 65535
	 */
	public static function writeUInt16BE(intbuf:BytesBuffer, i:Int) {
		if (i < 0 || i > 0xffff) {
			throw new Exception('Invalid UInt16');
		}
		final tmp = new BytesBuffer();
		while (i > 0) {
			tmp.addByte(i&0xff);
			i >>>= 0x08;
		}
		intbuf.add(tmp.getBytes().otherEndian());
	}
}
