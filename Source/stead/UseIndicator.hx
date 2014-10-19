package stead;
import js.Browser;
import js.html.Element;

/**
 * ...
 * @author gordev
 */
class UseIndicator
{
	private static var instance:UseIndicator;
	private var cog:Element;
	
	private function new()
	{
		cog = Browser.document.getElementById('cog');
	}
	
	public function PowerOn():Void
	{
		cog.style.visibility = "visible";
	}
	
	public function PowerOff():Void
	{
		cog.style.visibility = "hidden";
	}
	
	public static function Instance():UseIndicator
	{
		if (instance == null) {
			instance = new UseIndicator();
		}
		return instance;
	}
}