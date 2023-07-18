package mc.types;

import haxe.io.Bytes;

abstract PacketLong(Bytes) {
    inline function new(i:Float) {
        this = Bytes.alloc(8);
    }
}