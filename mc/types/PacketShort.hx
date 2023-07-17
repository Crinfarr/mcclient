package mc.types;

import haxe.Exception;
import haxe.io.Bytes;

abstract PacketShort(Bytes) {
	inline function new(i:Int) {
		if (i < -0x8000 || i > 0x7fff) {
            throw new Exception('${i} outside Int16 range');
        }
		this = Bytes.alloc(2);
		this.set(0, (i & 0xff00) >> 0x8);
		this.set(1, i & 0x00ff);
	}

    @:to(Int)
    public function toInt() {
		var val = (this.get(0) << 0x8) + this.get(1);
        return val-((val&0x8000)*2);
    }

    @:from(Int)
    public static function fromInt(i) {
        return new PacketShort(i);
    }

	public function toPacketBytes():Bytes {
		return this;
	}
}
