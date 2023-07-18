import mc.types.PacketInt;
import haxe.Exception;
import mc.types.PacketShort;
import haxe.io.Bytes;

class Test {
	static function main() {
		for (i in 0...0x7fffffff) {
			final num:PacketInt = i;
			final inum:PacketInt = -i;
			Sys.stdout().writeString('${num.toPacketBytes().toHex()}\t${num.toInt()}\r');
			if (num.toInt() + inum.toInt() != 0) {
				throw new Exception('Math breaks when i=${i}');
			}
		}
	}
}
