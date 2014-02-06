// Custom glue functions for INSTEAD
	
// First of all, initialize the Lua module here.
Lua.initialize();
Glue_init();

// Custom injects

// Instead object
function Interpreter() {
}
Interpreter.prototype.call = function(command) {
    return Lua.eval(command);
}
Interpreter.prototype.load = function(path) {
    RunLuaFromPath(path);
}
Interpreter.prototype.clear = function() {
    Lua.destroy();
    Lua.initialize();
    Glue_init();
}