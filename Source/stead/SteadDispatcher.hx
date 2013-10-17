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
		ifaceCmd("\"look\"");
		refreshInterface();
	}
	
	private static function refreshInterface()
	{
		getTitle();
		getWays();
		getInv();
	}
	
	@:expose public static function click(ref:String):Void
	{
		ref = ref.substr(1);
		if (ref.substr(0, 3) == "act")
		{
			ref = "use " + ref.substr(4); 
		}
		ifaceCmd("\"" + ref + "\"");
		refreshInterface();
        //look();
	}

    @:expose public static function get_dofile():String
    {
        return _dofile_path;
    }
	
	private static function getInv()
	{
		var invAnswer:String = Std.string(interpreter.call("instead.get_inv(true)")[0]);
		setContent("inventory", invAnswer);
	}
	
	private static function getWays()
	{
		var waysAnswer:String = Std.string(interpreter.call("instead.get_ways()")[0]);
		setContent("ways", waysAnswer);
	}
	
	private static function getTitle()
	{
		var waysAnswer:String = Std.string(interpreter.call("instead.get_title()")[0]);
		setContent("title", "<a href=\"javascript:stead.SteadDispatcher.click(\'#look\')\">" + waysAnswer + "</a>");
	}
	
	private static function ifaceCmd(command:String)
	{
		var retVal:Array<Dynamic> = interpreter.call("iface.cmd(iface, " + command + ")");
		var cmdAnswer:String = Std.string(retVal[0]);
		var rc:Bool = retVal[1];
		if (cmdAnswer != "" && rc)
		{
			setContent("text", cmdAnswer);
		}
	}
	
    private static function setContent(id:String, content:String) 
	{
        var d = Browser.document.getElementById(id);
        if( d == null )
            js.Lib.alert("Unknown element : " + id);
        d.innerHTML = "<pre>" + normalizeContent(content) + "</pre>";
    }
	
	private static function normalizeContent(input:String):String
	{
		var output:String = "";
		var r:EReg = ~/<a(:)([\w+\d+ ]+)/g;
		output = r.replace(input, "<a href=\"javascript:stead.SteadDispatcher.click(\'#$2\')\"");
		r = ~/<w:([^>]+)>/g;
		output = r.replace(output, "<span class=\"nowrap\">$1</span>");
		return output;
	}
}
