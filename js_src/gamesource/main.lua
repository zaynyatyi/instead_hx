-- $Name:Backup$
-- $Name(ru):Резервная копия$
-- $Version:0.3.1$
instead_version '1.7.1'

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
            nam = 'en'; dsc = '> {English}^';
            act = code [[ gamefile('main_eng.lua', true); ]];
        };
        obj
        {
            nam = 'ru'; dsc = '> {Русский}';
            act = code [[ gamefile('main_rus.lua', true); ]];
        };
    }
};
