-- $Name:Backup$
-- $Name(ru):Резервная копия$
-- $Version:0.4$
instead_version '1.7.1'

require 'para'

main = room
{
    nam = '«Backup»';
    pic = 'images/title.png',
    dsc = function(s)
        if LANG == 'ru' then
            p [[Выберите язык игры:]];
        else
            p [[Select game language:]];
        end
    end;
    obj =
    {
        obj
        {
            nam = 'en'; dsc = '> {English} (1 chapter from 4)^';
            act = code [[ gamefile ('en_main.lua', true); ]];
        };
        obj
        {
            nam = 'ru'; dsc = '> {Русский}';
            act = code [[ gamefile ('ru_main.lua', true); ]];
        };
    }
};
