package;

import js.Browser;
import js.html.CSSStyleSheet;
import js.html.Element;
import js.html.Event;
import js.html.ImageElement;
import stead.MenuDispatcher;
import stead.SteadDispatcher;
import stead.ThemeParser;
import stead.UseIndicator;

class Main
{

	private var stead_dispatcher:SteadDispatcher;
	private var theme_parser:ThemeParser;
	public static inline var SlotName:String = "backup_01";
	private static inline var DEFAULT_MENU_BTN:String = "gamesource/theme/menu.png";

	public function new ()
	{
		MenuDispatcher.Instance().muted = Browser.getLocalStorage().getItem('mute') == 'true' ? true : false;
		stead_dispatcher = new SteadDispatcher();
		UseIndicator.Instance().PowerOff();
		ApplyTheme();
	}

	private function ApplyTheme():Void
	{
		ThemeParser.Instance().Parse();
		var stead_div:Element = Browser.document.getElementById('stead');
		var win_div:Element = Browser.document.getElementById('win');
		var inv_div:Element = Browser.document.getElementById('inventory');
		var cog_div:Element = Browser.document.getElementById('cog');
		var menu_button:Element = Browser.document.getElementById('menu_button');
		var menu_image:ImageElement = cast Browser.document.getElementById('menu_image');
		if(ThemeParser.Instance().theme.exists('scr.gfx.bg')) {
			stead_div.style.backgroundImage = 'url(gamesource/' + ThemeParser.Instance().theme.get('scr.gfx.bg') + ')';
		}
		if(ThemeParser.Instance().theme.exists('scr.w') && ThemeParser.Instance().theme.exists('scr.h')) {
			stead_div.style.width = ThemeParser.Instance().theme.get('scr.w') + 'px';
			stead_div.style.height = ThemeParser.Instance().theme.get('scr.h') + 'px';
			stead_div.style.left = ThemeParser.Instance().theme.get('scr.x') + 'px';
			stead_div.style.top = ThemeParser.Instance().theme.get('scr.y') + 'px';
		}
		if (ThemeParser.Instance().theme.exists('win.w') && ThemeParser.Instance().theme.exists('win.h')) {
			win_div.style.width = ThemeParser.Instance().theme.get('win.w') + 'px';
			win_div.style.height = ThemeParser.Instance().theme.get('win.h') + 'px';
			win_div.style.left = ThemeParser.Instance().theme.get('win.x') + 'px';
			win_div.style.top = ThemeParser.Instance().theme.get('win.y') + 'px';
		}
		if (ThemeParser.Instance().theme.exists('inv.w') && ThemeParser.Instance().theme.exists('inv.h')) {
			inv_div.style.width = ThemeParser.Instance().theme.get('inv.w') + 'px';
			inv_div.style.height = ThemeParser.Instance().theme.get('inv.h') + 'px';
			inv_div.style.left = ThemeParser.Instance().theme.get('inv.x') + 'px';
			inv_div.style.top = ThemeParser.Instance().theme.get('inv.y') + 'px';
		}
		if (ThemeParser.Instance().theme.exists('cog.x') && ThemeParser.Instance().theme.exists('cog.y')) {
			cog_div.style.width = ThemeParser.Instance().theme.get('cog.w') + 'px';
			cog_div.style.height = ThemeParser.Instance().theme.get('cog.h') + 'px';
			cog_div.style.left = ThemeParser.Instance().theme.get('cog.x') + 'px';
			cog_div.style.top = ThemeParser.Instance().theme.get('cog.y') + 'px';
		}
		if(ThemeParser.Instance().theme.exists('cog.gfx')) {
			cog_div.style.backgroundImage = 'url(gamesource/' + ThemeParser.Instance().theme.get('cog.gfx') + ')';
		}

		menu_button.style.left = ThemeParser.Instance().theme.get('menu.button.x') + 'px';
		menu_button.style.top = ThemeParser.Instance().theme.get('menu.button.y') + 'px';
		if (ThemeParser.Instance().theme.exists('menu.gfx.button')) {
			menu_image.src = 'gamesource/' + ThemeParser.Instance().theme.get('menu.gfx.button');
		}else {
			menu_image.src = DEFAULT_MENU_BTN;
		}
		
		var styleSheet:CSSStyleSheet = cast(Browser.document.styleSheets[0], CSSStyleSheet);
		styleSheet.insertRule("#win a { color: " + ThemeParser.Instance().theme.get('win.col.link') + "; }", 0);
		styleSheet.insertRule("#win { color: " + ThemeParser.Instance().theme.get('win.col.fg') + "; }", 0);
		styleSheet.insertRule("#win a:hover { color: " + ThemeParser.Instance().theme.get('win.col.alink') + "; }", 0);
		
		styleSheet.insertRule("#inventory a { color: " + ThemeParser.Instance().theme.get('inv.col.link') + "; }", 0);
		styleSheet.insertRule("#inventory { color: " + ThemeParser.Instance().theme.get('inv.col.fg') + "; }", 0);
		styleSheet.insertRule("#inventory a:hover { color: " + ThemeParser.Instance().theme.get('inv.col.alink') + "; }", 0);
		
		menu_button.onclick = function (e:Event):Void
		{
			MenuDispatcher.Instance().ShowUp();
		};
	}
	
	static function main()
	{
		var object:Main = new Main();
	}
}
