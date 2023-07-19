package mc;

import haxe.Json;
import haxe.Exception;
import haxe.io.BytesBuffer;
import sys.net.Host;
import sys.net.Socket;

using mc.ByteTools;
using mc.BytesBufferTools;

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

	public function doRequest() {
		var request = new BytesBuffer();
		request.addByte(0x01);
		request.addByte(0x00);
		this.output.write(request.getBytes());
		this.output.flush();
		this.waitForRead();
		var statusres = this.input.readAll();
		final packetLength = statusres.readVarInt();
		Sys.println('Got packet with length ${packetLength}');
		if (statusres.length < packetLength)
			throw new Exception('Invalid packet');

		var tmp = new BytesBuffer();
		tmp.writeVarInt(packetLength);
		Sys.println('ignoring first ${tmp.length} bytes: used by headers');
		statusres = statusres.sub(tmp.length, packetLength);
		final packetID = statusres.readVarInt();
		tmp = new BytesBuffer();
		tmp.writeVarInt(packetID);
		statusres = statusres.sub(tmp.length, statusres.length - tmp.length);
		Sys.println('ignoring next ${tmp.length} byte(s): used by ID');
		Sys.println(Json.stringify(Json.parse(statusres.readStringVarInt()), null, '\t'));
	}
}
