package tools;

import sys.FileSystem;
import haxe.macro.Expr;
import haxe.macro.Context;
import sys.io.File;

class DotEnv {
    public static macro function get(name : String) {
        var envLine = ~/\s*(\w+)\s*=\s*(.*)\s*/;

        var dotEnvFile = try File.getContent('.env') catch(e : Dynamic) {
            Context.error(
                '.env file not found in ' + FileSystem.absolutePath("."), Context.currentPos()
            );
        }

        var values = new Map<String, String>();
        while(envLine.match(dotEnvFile)) {
            values.set(envLine.matched(1), envLine.matched(2));
            dotEnvFile = envLine.matchedRight();
        }

        if(!values.exists(name))
            Context.error('Key not found in .env: $name', Context.currentPos());

        return macro $v{values.get(name)};
    }
}