package mc.types;

import haxe.Exception;
import haxe.io.Bytes;

abstract PacketByte(Bytes) {
    inline function new(i:Int) {
        if (i > 0x7f || i < -0x80) {
            throw new Exception('${i} outside Int8 bounds');
        }
        this = Bytes.alloc(1);
        this.set(0, i);
    }

    @:to(Int)
    public function toInt() {
        return (this.get(0)-((this.get(0)&0x80)*2));
    }

    @:from(Int) 
    public static function fromInt(i):PacketByte {
        return new PacketByte(i);
    }

	public function toPacketBytes():Bytes {
		return this;
	}
}