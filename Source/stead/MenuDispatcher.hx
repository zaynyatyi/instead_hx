package stead;
import js.html.Element;
import js.html.Event;
import js.Browser;

/**
 * ...
 * @author gordev
 */
class MenuDispatcher
{

    public var visible:Bool;
    public var muted:Bool;
    public var save:Element;
    public var load:Element;
    public var reset:Element;
    public var mute:Element;
    private var back:Element;
    private var self:Element;
    
    private static var instance:MenuDispatcher;
    
    public function new() 
    {
        visible = false;
        muted = false;
        save = Browser.document.getElementById('save');
        load = Browser.document.getElementById('load');
        reset = Browser.document.getElementById('reset');
        mute = Browser.document.getElementById('mute');
        back = Browser.document.getElementById('back');
        self = Browser.document.getElementById('menu');
        
        back.onclick = function (e:Event) { self.style.visibility = 'hidden'; visible = false; };
        mute.onclick = function (e:Event) { Browser.getLocalStorage().setItem('mute', Std.string(!muted)); muted = !muted; SteadDispatcher.track.muted = muted; };
    }
    
    public function ShowUp():Void {
        self.style.visibility = 'visible';
        visible = true;
    }
    
    public function HideUp():Void {
        self.style.visibility = 'hidden';
        visible = false;
    }
    
    public static function Instance():MenuDispatcher {
		if (instance == null)
			instance = new MenuDispatcher();
		return instance;
	}
}