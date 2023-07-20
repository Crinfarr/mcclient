import haxe.macro.Compiler;
import sys.net.Host;
import haxe.Json;
import mc.Server;

using mc.BytesBufferTools;
using mc.ByteTools;

class Test {
	static function main() {
		var server = new Server(new Host(Compiler.getDefine('SERVERIP')), Std.parseInt(Compiler.getDefine('PORT')));
		server.doHandshake();
		trace('\n' + Json.stringify(server.doRequest(), null, '\t'));
	}
}