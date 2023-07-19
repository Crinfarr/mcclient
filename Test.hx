import sys.net.Host;
import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import mc.Server;

using mc.BytesBufferTools;
using mc.ByteTools;

class Test {
	static function main() {
		var server = new Server(new Host('node1.crinfarr.zip'), 13862);
		server.doHandshake();
		server.doRequest();
	}
}