package mc.types;

import haxe.io.Bytes;

abstract PacketBool(Bytes) {
    inline public function new(i:Bool) {
        this = Bytes.alloc(1);
        this.set(0, i?0x01:0x00);
    }

    @:to(Bool)
    public function toBool():Bool {
        return this.get(0)==0x01;
    }
    @:from(Bool)
    public static function fromBool(i:Bool):PacketBool{
        return new PacketBool(i);
    }

	public function toPacketBytes():Bytes {
		return this;
	}
}