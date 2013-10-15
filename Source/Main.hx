package;


class Main {
	
    private var interpreter:Interpreter;	
	public function new () {
        interpreter = new Interpreter();
        interpreter.load("web.lua");
        interpreter.load("stead.lua");
        interpreter.load("gui.lua");
        interpreter.load("./gamesource/main.lua");

        interpreter.call("game.ini(game)");

        trace(interpreter.call("iface.cmd(iface, \"look\")"));
	}
	
    static function main() {
        var object:Main = new Main();
    }
}
