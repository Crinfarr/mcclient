package mc;

import mc.types.ServerRecord;
import haxe.Json;
import haxe.Exception;
import haxe.io.BytesBuffer;
import sys.net.Host;
import sys.net.Socket;

using mc.ByteTools;
using mc.BytesBufferTools;
using mc.InputTools;

class Server extends Socket {
	private var data:BytesBuffer;

	public function new(host:Host, port:Int = 25565) {
		super();
		this.data = new BytesBuffer();
		this.connect(host, port);
	}

	public function doHandshake() {
		var handshake = new BytesBuffer();
		handshake.writeVarInt(0x00);
		handshake.writeVarInt(47);
		handshake.writeStringVarInt(this.host().host.toString());
		handshake.writeUInt16BE(this.host().port);
		handshake.writeVarInt(0x01);

		var bytes = handshake.getBytes();
		handshake = new BytesBuffer();
		handshake.addByte(bytes.length);
		handshake.add(bytes);
		bytes = handshake.getBytes();

		this.output.write(bytes);
		this.output.flush();
	}

	public function doRequest():ServerRecord {
		var request = new BytesBuffer();
		request.addByte(0x01);
		request.addByte(0x00);
		this.output.write(request.getBytes());
		this.output.flush();
		this.waitForRead();
		final _packlen = this.input.readVarInt();
		final packid = this.input.readVarInt();
		if (packid != 0x00)
			throw new Exception('Unexpected response packet ID ${StringTools.hex(packid)}');
		final res = Json.parse(this.input.readStringVarInt());
		return res;
	}
}
