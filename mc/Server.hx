import sys.net.Host;
import sys.net.Socket;

class Server {
    private var state:Int;

    private var host:Host;
    private var port:Int;
    function new(ip:String, port:String) {
        this.host = new Host(ip);
        this.port = Std.parseInt(port);
    }
    function getStatus() {
        final socket = new Socket();
        socket.connect(host, port);
        
    }
}