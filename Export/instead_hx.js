(function () { "use strict";
var Main = function() {
	this.interpreter = new Interpreter();
	this.interpreter.load("web.lua");
	this.interpreter.load("stead.lua");
	this.interpreter.load("gui.lua");
	this.interpreter.load("./gamesource/main.lua");
	this.interpreter.call("game.ini(game)");
	console.log(this.interpreter.call("iface.cmd(iface, \"look\")"));
};
Main.main = function() {
	var object = new Main();
}
Main.main();
})();
