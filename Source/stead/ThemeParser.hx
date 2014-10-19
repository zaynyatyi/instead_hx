package stead;

import haxe.Http;

class ThemeParser
{
	public static var game_folder:String = 'gamesource';
	public static var horizontal_inventory:Bool = true;
	public static var left_inventory:Bool = false;
	public var theme:Map<String, String>;
	private static var instance:ThemeParser;
	
	private function new()
	{
		theme = new Map<String, String>();
	}

	public function Parse():Void
	{
		var theme_file:Array<String> = Http.requestUrl('gamesource/theme.ini').split('\n');
		for(line in theme_file) {
			var pair = line.split(' = ');
			if(pair.length == 2)
				theme.set(pair[0], pair[1]);
		}
		if (theme.exists('inv.mode') && theme.get('inv.mode').indexOf('vertical') != -1) {
			horizontal_inventory = false;
		}
	}
	
	public static function Instance():ThemeParser
	{
		if (instance == null) {
			instance = new ThemeParser();
		}
		return instance;
	}
}
