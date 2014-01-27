package;

import stead.SteadDispatcher;
import js.Browser;
import js.html.CSSStyleSheet;
import js.html.Element;

class Main {

    private var stead_dispatcher:SteadDispatcher;
    private var theme_parser:ThemeParser;

    public function new () {
        stead_dispatcher = new SteadDispatcher();
        theme_parser = new ThemeParser();
        theme_parser.Parse();
        var stead_div:Element = Browser.document.getElementById('stead');
        if(theme_parser.theme.exists('scr.gfx.bg'))
            stead_div.style.backgroundImage = 'url(gamesource/'+theme_parser.theme.get('scr.gfx.bg')+')';
        if(theme_parser.theme.exists('scr.h') && theme_parser.theme.exists('scr.w'))
        {
            stead_div.style.width = theme_parser.theme.get('scr.w') + 'px';
            stead_div.style.height = theme_parser.theme.get('scr.h') + 'px';
        }
    }

    static function main() {
        var object:Main = new Main();
    }
}
