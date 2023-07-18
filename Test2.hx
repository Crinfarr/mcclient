import haxe.Timer;
import sys.thread.Lock;

class Test2 {
	static function main() {
		final lock = new Lock();
		var custIter = new Iter();
		var loopy = 0;
		var range = 0;

		Timer.measure(() -> {
			for (_ in custIter) {
				continue;
			}
			lock.release();
		});
		Timer.measure(() -> {
			for (num in 0...500_000_000) {
				range = num;
			}
			lock.release();
		});
		Timer.measure(() -> {
			while (true) {
				if (++loopy >= 500_000_000)
					break;
			}
			lock.release();
		});
	}
}

private class Iter {
	public var i:Int;

	public function new() {
		this.i = 0;
	}

	public function hasNext():Bool {
		return this.i < 500_000_000;
	}

	public function next():Int {
		return ++this.i;
	}
}
