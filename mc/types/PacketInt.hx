package mc.types;

import haxe.io.Bytes;
import haxe.Exception;

abstract PacketInt(Bytes) {
	inline function new(i:Int) {
		if (i < -0x80000000 || i > 0x7fffffff) {
			throw new Exception('${i} outside Int32 bounds');
		}
		this = Bytes.alloc(4);
		this.set(0, (i & 0xff000000) >> 0x18);
		this.set(1, (i & 0x00ff0000) >> 0x10);
		this.set(2, (i & 0x0000ff00) >> 0x08);
		this.set(3, (i & 0x000000ff));
	}

	@:to(Int)
	public function toInt():Int {
		var num = (this.get(0) << 0x18) + (this.get(1) << 0x10) + (this.get(2) << 0x08) + this.get(3);
		return num - ((num & 0x80000000) * 2);
	}

	@:from(Int)
	public static function fromInt(i:Int) {
		return new PacketInt(i);
	}

	public function toPacketBytes():Bytes {
		return this;
	}
}
