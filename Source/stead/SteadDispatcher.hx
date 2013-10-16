package stead;

import js.Browser;
import js.JQuery;
import js.Lib;

/**
 * ...
 * @author gordev
 */
class SteadDispatcher
{
	private static var interpreter:Interpreter = new Interpreter();
	
	public function new() 
	{
        interpreter.load("web.lua");
        interpreter.load("stead.lua");
        interpreter.load("gui.lua");
        interpreter.load("./gamesource/main.lua");

        interpreter.call("game.ini(game)");
		
		look();
	}
	
	public function look()
	{
		setContent("text", Std.string(interpreter.call("iface.cmd(iface, \"look\")")[0]));
	}
	
	@:expose public static function click(ref:String):Void
	{
		interpreter.call("iface.cmd(iface, \"" + ref.substr(1) + "\")");
	}
	
    private function setContent(id:String, content:String) 
	{
        var d = Browser.document.getElementById(id);
        if( d == null )
            js.Lib.alert("Unknown element : " + id);
        d.innerHTML = "<pre>" + normalizeLinks(content) + "</pre>";
    }
	
	private function normalizeLinks(input:String):String
	{
		var r:EReg = ~/<a(:)(\d+)/g;
		return r.replace(input, "<a href=\"javascript:stead.SteadDispatcher.click(\'#$2\')\"");
	}
}