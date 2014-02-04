package;

import stead.SteadDispatcher;
import stead.ThemeParser;
import stead.UseIndicator;
import js.Browser;
import js.html.CSSStyleSheet;
import js.html.Element;
import js.JQuery;

class Main {

    private var stead_dispatcher:SteadDispatcher;
    private var theme_parser:ThemeParser;
    public static inline var SlotName:String = "backup_01";

    public function new () {
        stead_dispatcher = new SteadDispatcher();
		UseIndicator.Instance().PowerOff();
		ApplyTheme();
    }

	private function ApplyTheme() {
		ThemeParser.Instance().Parse();
        var stead_div:Element = Browser.document.getElementById('stead');
		var win_div:Element = Browser.document.getElementById('win');
		var inv_div:Element = Browser.document.getElementById('inventory');
		var cog_div:Element = Browser.document.getElementById('cog');
		var save_div:Element = Browser.document.getElementById('save');
		var load_div:Element = Browser.document.getElementById('load');
        if(ThemeParser.Instance().theme.exists('scr.gfx.bg'))
            stead_div.style.backgroundImage = 'url(gamesource/'+ThemeParser.Instance().theme.get('scr.gfx.bg')+')';
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
		if(ThemeParser.Instance().theme.exists('cog.gfx'))
            cog_div.style.backgroundImage = 'url(gamesource/' + ThemeParser.Instance().theme.get('cog.gfx') + ')';

		if (ThemeParser.Instance().theme.exists('save.x') && ThemeParser.Instance().theme.exists('save.y')) {
			save_div.style.width = ThemeParser.Instance().theme.get('save.w') + 'px';
            save_div.style.height = ThemeParser.Instance().theme.get('save.h') + 'px';
            save_div.style.left = ThemeParser.Instance().theme.get('save.x') + 'px';
			save_div.style.top = ThemeParser.Instance().theme.get('save.y') + 'px';
		}
		if(ThemeParser.Instance().theme.exists('save.gfx'))
            save_div.style.backgroundImage = 'url(gamesource/' + ThemeParser.Instance().theme.get('save.gfx') + ')';

		if (ThemeParser.Instance().theme.exists('load.x') && ThemeParser.Instance().theme.exists('load.y')) {
			load_div.style.width = ThemeParser.Instance().theme.get('load.w') + 'px';
            load_div.style.height = ThemeParser.Instance().theme.get('load.h') + 'px';
            load_div.style.left = ThemeParser.Instance().theme.get('load.x') + 'px';
			load_div.style.top = ThemeParser.Instance().theme.get('load.y') + 'px';
		}
		if(ThemeParser.Instance().theme.exists('load.gfx'))
            load_div.style.backgroundImage = 'url(gamesource/' + ThemeParser.Instance().theme.get('load.gfx') + ')';

		
		var styleSheet:CSSStyleSheet = cast(Browser.document.styleSheets[0], CSSStyleSheet);
		styleSheet.insertRule("#win a { color: " + ThemeParser.Instance().theme.get('win.col.link') + "; }", 0);
		styleSheet.insertRule("#win { color: " + ThemeParser.Instance().theme.get('win.col.fg') + "; }", 0);
		styleSheet.insertRule("#win a:hover { color: " + ThemeParser.Instance().theme.get('win.col.alink') + "; }", 0);
		
		styleSheet.insertRule("#inventory a { color: " + ThemeParser.Instance().theme.get('inv.col.link') + "; }", 0);
		styleSheet.insertRule("#inventory { color: " + ThemeParser.Instance().theme.get('inv.col.fg') + "; }", 0);
		styleSheet.insertRule("#inventory a:hover { color: " + ThemeParser.Instance().theme.get('inv.col.alink') + "; }", 0);
	}
	
    static function main() {
        var object:Main = new Main();
    }
}
