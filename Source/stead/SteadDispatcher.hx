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
    private static var _dofile_path:String = "";
	private static var interpreter:Interpreter = new Interpreter();
	
	public function new() 
	{
        interpreter.load("web.lua");
        interpreter.load("stead.lua");
        interpreter.load("gui.lua");
        _dofile_path = "./gamesource/";
        interpreter.load(_dofile_path + "main.lua");

        interpreter.call("game.ini(game)");
		
		look();
	}
	
	public static function look()
	{
		setContent("text", Std.string(interpreter.call("iface.cmd(iface, \"look\")")[0]));
	}
	
	@:expose public static function click(ref:String):Void
	{
		interpreter.call("iface.cmd(iface, \"" + ref.substr(1) + "\")");
        look();
	}

    @:expose public static function get_dofile():String
    {
        return _dofile_path;
    }
	
    private static function setContent(id:String, content:String) 
	{
        var d = Browser.document.getElementById(id);
        if( d == null )
            js.Lib.alert("Unknown element : " + id);
        d.innerHTML = "<pre>" + normalizeLinks(content) + "</pre>";
    }
	
	private static function normalizeLinks(input:String):String
	{
		var r:EReg = ~/<a(:)(\d+)/g;
		return r.replace(input, "<a href=\"javascript:stead.SteadDispatcher.click(\'#$2\')\"");
	}
}
