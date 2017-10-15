class Main extends CommandLineApp
{
	public function new() {
		super('cmdapp');

		// Your program here
		trace(Env.NODE_ENV);

		// Remember to use exit()
		exit();
	}
}