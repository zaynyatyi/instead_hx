package stead;

import js.Browser;
import js.html.AnchorElement;
import js.html.CanvasElement;
import js.html.Element;
import js.html.Event;
import js.html.Image;
import js.html.SpanElement;
import js.JQuery;
import js.Lib;

import stead.ThemeParser;

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
    private static var canvas:CanvasElement;

    public function new()
    {
        interpreter.load("web.lua");
        interpreter.load("stead.lua");
        interpreter.load("gui.lua");
        _dofile_path = "./" + ThemeParser.game_folder + "/";
        interpreter.load(_dofile_path + "main.lua");
        interpreter.call("game.ini(game)");

        canvas = cast Browser.document.getElementById("canvas");
		var stead_div:Element = Browser.document.getElementById("stead");
		stead_div.onclick = OnSteadClick;
        look();
    }

	private function OnSteadClick(e:Event):Void {
		if(!Std.is(e.target, AnchorElement) && !Std.is(e.target, SpanElement)) {
			click("", 0, true);
			var i = 0;
		}
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
        getPicture();
        getMusic();
    }

    @:expose public static function click(ref:String, field:Int, onstead:Bool = false):Void
    {
        if (!onstead && (act || field == Inv.getIndex())) {
            ref = ref.substr(1);
            if (ref.substr(0, 3) == "act") {
                ref = "use " + ref.substr(4);
                ifaceCmd("\"" + ref + "\"");
                refreshInterface();
                return;
            }

            if (act) {
                if (field != Ways.getIndex() && field != Title.getIndex())
                {
                    if (ref == thing)
                    {
                        ifaceCmd("\"use " + ref + "\"");
                    }else {
                        ifaceCmd("\"use " + thing + ',' + ref + "\"");
                    }
                    act = false;
					UseIndicator.Instance().PowerOff();
                    thing = "";
                    refreshInterface();
                }
            }else {
                act = true;
                thing = ref;
				UseIndicator.Instance().PowerOn();
            }
        }else {
			if (act = true) {
				act = false;
				UseIndicator.Instance().PowerOff();
				thing = "";
			}
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
        var retVal:Array<Dynamic> = interpreter.call("instead.get_inv(" + Std.string(ThemeParser.horizontal_inventory)
		+ ")");
        if (retVal[0] != null)
        {
            var invAnswer:String = Std.string(retVal[0]);
            setContent("inventory", invAnswer, Inv);
        }
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

    private static function getPicture()
    {
        var retVal:Array<Dynamic> = interpreter.call("instead.get_picture()");
        if (retVal[0] != null)
        {
            var picture_path:String = Std.string(retVal[0]);
            showPicture(picture_path);
        }
    }

    private static function getMusic()
    {
        var retVal:Array<Dynamic> = interpreter.call("instead.get_music()");
        if (retVal[0] != null)
        {
            var music_path:String = Std.string(retVal[0]);
            playMusic(music_path);
        }
    }

    private static function showPicture(path:String)
    {
        trace(path);
        //TODO: parse here how many images we have and positions
        var image = new Image();
        image.style.left = '0px';
        image.style.top = '0px';

        // add call back for when image is loaded.
        image.onload = copyAccross;

        image.style.position = "absolute";
        image.src = _dofile_path + path;
    }

    private static function copyAccross(e:Event)
    {
        //TODO: add multi pics support
        var image:Image = cast e.currentTarget;
        canvas.getContext2d().clearRect(0, 0, canvas.width, canvas.height);
        canvas.width = image.width;
        canvas.height = image.height;
        canvas.getContext2d().drawImage(image, 0, 0, image.width, image.height);
    }

    private static function playMusic(path:String)
    {
        trace(path);
    }

    private static function ifaceCmd(command:String)
    {
        var retVal:Array<Dynamic> = interpreter.call("iface.cmd(iface, " + command + ")");
        if (retVal[0] != null)
        {
            var cmdAnswer:String = Std.string(retVal[0]);
            var rc:Bool = retVal[1];
            if (cmdAnswer != "" && rc)
            {
                setContent("text", cmdAnswer, Text);
            }
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
