import mc.types.PacketInt;
import haxe.Exception;
import mc.types.PacketShort;
import haxe.io.Bytes;

class Test {
    static function main() {
        for (i in 0...0x7fffffff) {
            final num:PacketInt = i;
            final inum:PacketInt = -i;
            trace(num.toInt());
            trace(num.toPacketBytes().toHex());
            trace(inum.toInt());
            trace(num.toPacketBytes().toHex());
            if (num.toInt() + inum.toInt() != 0) {
                throw new Exception('Math breaks when i=${i}');
            }
            Sys.stdout().writeString('${i}\r');
        }
    }
}