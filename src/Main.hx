class Main extends CommandLineApp
{
	public function new() {
		super('app');

		// Your program here
		trace(Env.NODE_ENV);

		// Remember to use exit()
		exit();
	}
}