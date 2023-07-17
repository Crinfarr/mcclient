package mc.types;

import haxe.io.Bytes;
import haxe.Exception;

abstract PacketInt(Bytes) {
	inline function new(i:Int) {
		if (i < -0x80000000 || i > 0x7fffffff) {
			throw new Exception('${i} outside Int32 bounds');
		}
		this = Bytes.alloc(4);
		for (idx in 0...4) {
			final bitmask = 0xff000000 >> (0x08 * idx);
			this.set(idx, (i & bitmask) >> (0x08 * (idx + 1)));
		}
	}

    @:to(Int)
    public function toInt():Int {
        var num = 0;
        for (idx in 0...4) {
            num += this.get(idx) << (0x08 * idx);
        }
        return num - ((num&0x80000000)*2);
    }
    @:from(Int)
    public static function fromInt(i:Int) {
        return new PacketInt(i);
    }

	public function toPacketBytes():Bytes {
		return this;
	}
}
