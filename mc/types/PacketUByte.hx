package mc.types;

import haxe.Exception;
import haxe.io.Bytes;

abstract PacketUByte(Bytes) {
    inline function new(i:Int) {
        if (i < 0x00 || i > 0xff) {
            throw new Exception('${i} outside UInt8 bounds');
        }
        this = Bytes.alloc(1);
        this.set(0, i);
    }

    @:to(Int)
    public function toInt() {
        return this.get(0);
    }

    @:from(Int)
    public static function fromInt(i:Int) {
        return new PacketUByte(i);
    }

	public function toPacketBytes():Bytes {
		return this;
	}
}