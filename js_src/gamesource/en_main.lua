require 'para'

main = room
{
    nam = '«Backup»',
    pic = 'images/title.png',
    enter = function (s)
        set_music('music/vvb_-_careless_childhood.ogg');
    end,
    dsc = function (s)
        p [[Story, music, graphics: Vadim V. Balashoff (Вадим В. Балашов)^
        Drawings are made based on photos from open sources.^
        Version 0.4 alpha (xx.07.2013).^
        Please send your opinions to vvb.backup@rambler.ru^^
        ATTENTION! To correct music play you should choose 44 kHz or 22 kHz
        in Settings -> Sound -> Quality.
        ]];
        return;
    end,
    obj =
    {
        --vway('1', '{Об авторе}^', 'about'),
        obj
        {
            nam = '2'; dsc = '{Instruction}^';
            act = code [[ walk (ins01); return; ]];
        };
        obj
        {
            nam = '3'; dsc = '{Gratitudes}^^';
            act = code [[ walk (gratitudes); return; ]];
        };
        obj
        {
            nam = '4'; dsc = '{Start game}';
            act = code [[ gamefile ('en_part_01.lua', true); ]];
        };
    },
};


ins01 = room
{
    nam = 'Instructions',
--    pic = 'images/instructions.png',
    dsc = function (s)
        p (txtc(txtu(txtb('Player actions:'))));
        p (txtb('^EXAMINE'));
        p [[ — you can examine nearby objects (except those you are carrying
        with you).
        ]];
        p (txtb('^INVENTORY'));
        p ' — you can examine objects you are carrying with you.';
        p (txtb('^TAKE'));
        p ' — you can take the object if is it possible.';
        p (txtb('^DROP'));
        p ' — you can drop unneeded object.';
        p (txtb('^USE'));
        p [[ — you have to use objects to complete the game. To do it you have
        to point WHICH (the first click) object you want to act ON WHAT (the
        second click) object. To use the object itself, you have to click on
        it TWICE.
        ]];
        p (txtb('^TALK'));
        p ' — you can talk to some persons in the game.';
        p (txtb('^GIVE'));
        p [[ — you have to choose WHICH (the first click) object you want to
        give TO WHOM (the second click).
        ]];
        p (txtb('^WAIT'));
        p ' — you can wait for some event if you like.';
        p (txtb('^^Note^'));
        p [[In the menu USE and GIVE objects you have are shown by italic
        font.
        ]];
        return;
    end,
    obj = { vway('1', '{Back to main menu}', 'main') },
};


gratitudes = room
{
    nam = 'Gratitudes',
    pic = 'images/gun.png',
    dsc = function (s)
        p [[Author want to express thanks to:^
        – Ridley Scott for the movie «Blade Runner». It was the first time I
        meet cyberpunk. This movie is my favorite movie at all still. It is
        the best that I have ever seen.^
        – William Gibson for the book «Neuromancer». Without this book this
        game is impossible.^
        – «Golden Earring» for the song «Twilight Zone». Just listen it and
        you will get why.^
        – Jean Béraud for the picture «Au Café».^
        – Peter Kosyh for the INSTEAD, help in programming and for the visual
        theme «cyberpunk» which he create specially for this game.^
        – ...
        ]];
        return;
    end,
    obj = { vway('1', '{Back to main menu}', 'main') },
};

