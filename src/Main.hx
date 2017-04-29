import js.npm.Minimist;

class Main implements Async
{
	static function start(args : Minimist, log : Log, exit : ?Dynamic -> Void) {
		// Your program here
		trace(Env.NODE_ENV);
	}

	////////// Initialization //////////

	static function main() CommandLineApp.init({
		name: '',
		argOpts: {
			string: [],
			boolean: [],
			alias: []
		},
		cb: start
	});	
}