instead_version '1.7.1'

require 'xact'

main = room {
	nam = 'test caption',
	dsc = function(s) 
		p [[test test]]; 
	end;
	obj =
    {
        obj
        {
            nam = 'en'; dsc = '> {English}^';
            act = code [[ gamefile('main_eng.lua', true); ]];
        };
        obj
        {
            nam = 'ru'; dsc = '> {blabla}';
            act = code [[ gamefile('main_rus.lua', true); ]];
        };
    }
}