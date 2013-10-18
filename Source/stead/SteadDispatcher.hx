package stead;

import js.Browser;
import js.JQuery;
import js.Lib;

/**
 * ...
 * @author gordev
 */
enum EField 
{
	Text;
	Ways;
	Title;
	Inv;
}

class SteadDispatcher
{
    private static var _dofile_path:String = "";
	private static var interpreter:Interpreter = new Interpreter();
	private static var act:Bool = false;
	private static var thing:String = "";
	
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
	
	@:expose public static function click(ref:String, field:Int):Void
	{
		if (act || field == Inv.getIndex())
		{
			ref = ref.substr(1);
			if (ref.substr(0, 3) == "act")
			{
				ref = "use " + ref.substr(4);
				ifaceCmd("\"" + ref + "\"");
				refreshInterface();
				return;
			}
			
			if (act)
			{
				if (field != Ways.getIndex() && field != Title.getIndex())
				{
					if (ref == thing)
					{
						ifaceCmd("\"use " + ref + "\"");
					}else {
						ifaceCmd("\"use " + thing + ',' + ref + "\"");
					}
					act = false;
					thing = "";
					refreshInterface();
				}
			}else {
				act = true;
				thing = ref;
			}
			//ifaceCmd("\"" + ref + "\"");
			//refreshInterface();
		}else {
			ifaceCmd("\"" + ref + "\"");
			refreshInterface();
		}
	}

    @:expose public static function get_dofile():String
    {
        return _dofile_path;
    }
	
	private static function getInv()
	{
		var invAnswer:String = Std.string(interpreter.call("instead.get_inv(true)")[0]);
		setContent("inventory", invAnswer, Inv);
	}
	
	private static function getWays()
	{
		var waysAnswer:String = Std.string(interpreter.call("instead.get_ways()")[0]);
		setContent("ways", waysAnswer, Ways);
	}
	
	private static function getTitle()
	{
		var waysAnswer:String = Std.string(interpreter.call("instead.get_title()")[0]);
		setContent("title", "<a href=\"javascript:stead.SteadDispatcher.click(\'#look\', " + Title.getIndex() + ")\">" + waysAnswer + "</a>", Title);
	}
	
	private static function ifaceCmd(command:String)
	{
		var retVal:Array<Dynamic> = interpreter.call("iface.cmd(iface, " + command + ")");
		var cmdAnswer:String = Std.string(retVal[0]);
		var rc:Bool = retVal[1];
		if (cmdAnswer != "" && rc)
		{
			setContent("text", cmdAnswer, Text);
		}
	}
	
    private static function setContent(id:String, content:String, field:EField) 
	{
        var d = Browser.document.getElementById(id);
        if( d == null )
            js.Lib.alert("Unknown element : " + id);
        d.innerHTML = "<pre>" + normalizeContent(content, field) + "</pre>";
    }
	
	private static function normalizeContent(input:String, field:EField):String
	{
		var output:String = "";
		var r:EReg = ~/<a(:)([\w+\d+ ]+)/g;
		output = r.replace(input, "<a href=\"javascript:stead.SteadDispatcher.click(\'#$2\', " + field.getIndex() + ")\"");
		r = ~/<w:([^>]+)>/g;
		output = r.replace(output, "<span class=\"nowrap\">$1</span>");
		return output;
	}
}
