package mc;

import haxe.Exception;
import haxe.io.Input;

using mc.InputTools;

class InputTools {
    public static function readVarInt(input:Input) {
        final seg = 0x7f;
        final con = 0x80;
        var val = 0;
        var pos = 0;
        var idx = 0;
        while (true) {
            final i = input.readByte();
            val |= (i & seg) << pos;

            if ((i & con) == 0)
                break;
            pos += 7;
            idx++;

            if (pos >= 32)
                throw new Exception('VarInt size max reached; value dump:\n${val}');
        }
        return val;
    }

    public static function readStringVarInt(input:Input) {
        final len = input.readVarInt();
        return input.read(len).toString();
    }
}