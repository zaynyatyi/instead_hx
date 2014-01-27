package;

import haxe.Http;

class ThemeParser
{
    public static var game_folder:String = 'gamesource';
    public var theme:Map<String, String>;

    public function new()
    {
        theme = new Map<String, String>();
    }

    public function Parse()
    {
        var theme_file:Array<String> = Http.requestUrl('gamesource/theme.ini').split('\n');
        for(line in theme_file) 
        {
            var pair = line.split(' = ');
            if(pair.length == 2)
                theme.set(pair[0], pair[1]);
        }
    }
}
