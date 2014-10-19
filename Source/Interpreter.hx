package;

extern class Interpreter {
	public function new():Void;
	public function call(command:String):Array<Dynamic>;
	public function load(path:String):Void;
	public function clear():Void;
}
