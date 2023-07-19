package mc;

import haxe.Exception;
import haxe.io.BytesBuffer;
import haxe.io.Bytes;

using mc.BytesBufferTools;
using mc.ByteTools;

class ByteTools {
	public static function otherEndian(b:Bytes):Bytes {
		var iter = b.length - 1;
		var out:BytesBuffer = new BytesBuffer();
		while (iter >= 0) {
			out.addByte(b.get(iter--));
		}
        return out.getBytes();
	}

    public static function readVarInt(b:Bytes) {
		final SEGMENT_BITS = 0x7f;
		final CONTINUE_BIT = 0x80;
        var value = 0;
        var position = 0;
        var index = 0;
        while (true) {
            value |= (b.get(index) & SEGMENT_BITS) << position;
            
            if ((b.get(index) & CONTINUE_BIT) == 0)
                break;

            position += 7;
            index++;
            
            if (position >= 32)
                throw new Exception('VarInt size maximum reached, value dump:\n ${StringTools.hex(value)}');
        }
        return value;
    }
    public static function readStringVarInt(b:Bytes) {
        final len = b.readVarInt();
        var _tmp = new BytesBuffer();
        _tmp.writeVarInt(len);
        b = b.sub(_tmp.length, len);
        return b.toString();
    }
}
