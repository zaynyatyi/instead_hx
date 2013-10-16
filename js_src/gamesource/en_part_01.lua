instead_version '1.7.1'

require 'para'
require 'proxymenu'
require 'hideinv'
--require 'dbg'

dofile ('en_menu_actions.lua');

function init ()
    actions_init();
    take (revolver);
    lifeon (mplayer);
end


main = room
{
    nam = 'part 01',
    enter = code [[ walk (intro_1); ]],
};


subway = obj
{
    nam = 'subway',
    _felchi_street = false,
    dsc = nil,
};


mplayer = obj
{
    nam = 'mplayer';
    life = function (s)
        if here() == intro_1 then
            set_music ('music/vvb_-_behind_the_maya_pyramid.ogg');
        end
        if here() == police_car_5 then
            set_music ('music/vvb_-_night_city_blues_(1).ogg');
        end
        if here() == police_car_6 then
            set_music ('music/vvb_-_lonely_journey_(1).ogg');
        end
        if here() == police_car_11 then
            set_music ('music/vvb_-_night_is_sneaking.ogg');
        end
        if here() == quay_near_police_car then
            set_music ('music/vvb_-_nights_fading_(1).ogg');
        end
        if here() == quay_near_red_car then
             set_music ('music/vvb_-_night_is_sneaking.ogg');
        end
    end,
};


intro_1 = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/intro_1.png',
    dsc = function (s)
        p [[Bright light... Flashes of light... Glimpses of colors...
        Multicolors and fast... What is it? Flowers?
        Tumult of colors and bright splashes... Illegible silhouettes of
        men...  Faces... No... There are masks... Gleams of costumes and
        masks... Masks?  So, it is a carnival... Thus I can understand what is
        noise I hear...  Hollow rumble... This is beats of the drums...
        Eternal peace. Feels like home...^
        Flashes of light gradually go away. It’ strange.
        Blazing attires disappear and become winking of huge amount of
        multicolored lamps... What is it? Garlands?
        Why all in masks here?
        Sense of alarm slightly squeeze sense of calm.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'intro_2') },
};


intro_2 = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/intro_2.png',
    dsc = function (s)
        p [[Now flickering almost ends, and I saw that I’m in the room
        with huge number of electronic equipment.
        Everything is flickering by millions of lamps and huge amount of
        multicolor lights.
        But the men as I can see are dressed in the identical gowns.
        Their faces are hidden by masks.^
        Why I can’t move? It seems that I chained to the bed.
        Sense of alarm starts to rise. Am I in hospital?
        May be there was some kind of accident? Whats happened to me?^
        Someone bend over me. He says something, but I can’t understand words.
        Sound is floating, sometimes turns to roar, sometimes turns to whistle.
        I hear some knocking. It seems all of these machines make this sound.^
        I’m trying to say something, but I can’t open my mouth.
        I can’t even move.
        Alarm, whipped by sense of fear, increase many multiply. Where I am?^
        Finally, I can discern some noises.
        Squeaking of machines, flicks of handles and knobs.^
        – Do not resist, or it will be even worse! — green eyes of man who
        bends over me intently look at me.^
        The knocking rings out. It’ strange. I’ve heard this before.
        What is relation between knocking and all that happens to me?
        I don’t remember anything. I’m close my eyes slowly.
        I must remember how I get here...
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'hotel_room') },
};


-- ----------------------------------------------------------------------

hotel_room = room
{
    nam = 'Room',
    _visit = 1,
    pic = 'images/hotel_room.png',
    dsc = function (s)
        if s._visit == 1 then
            s._visit = 2;
            p [[I open my eyes. I’m laying on the bed in some room.
            How do I get here?
            And what for was that dream about lamps and men in masks?
            Oh, damn it, I don’t remember anything, not even my own name!^
            There is something in my hand. I raise my head and millions
            of needles stick into my brain instantly.
            I fall back on bed again.
            After a couple of minutes I try to raise my head again and
            I manage to do it finally.
            There is a revolver in my hand. And the gun still warm.
            It seems that this gun have been shoot from recently.
            I don’t get it. And don’t remember anything. Blackout.^
            I lower down legs on the floor. Oh my God!
            There is a huge pool of blood on the floor.
            I examine myself quickly. I have no scratches or any other
            wounds. Well, it means that this blood is not mine.
            Then who’s blood is it?^
            I hear a knock in the door. It seems that it was not the first
            time they knock in.^
            – Open up! – the voice belong to male.^
            Who it can be?^
            What’s happened here? The revolver had been shoot from.
            So, neighbors heard the shooting and called the police.
            Meeting with the police is to far from my plans.
            You just give them small reason only... And there is to many
            reasons to interest the police.
            So, I have to get out from here immediately!
            I should figure out everything by myself. If police get me, I will
            never had a chance to understand what happened here exactly.^
            I look out. Slight wind blows from opened window.
            There are only two furniture items here – the bad and small
            bedside-table. Of course, they’d not been made from wood.
            Plastic and polycarbons.
            Only few can allow to use true wood furniture nowadays...
            ]];
            return;
        end
        if s._visit == 2 then
            p [[It seems that I’m at the cheap hotel room.
            Slight wind blows from opened window.
            There are only two furniture items here – the bad and small
            bedside-table. Of course, they’d not been made from wood.
            Plastic and polycarbons.
            Only few can allow to use true wood furniture nowadays...
            ]];
            return;
        end
    end,
    obj =
    {
        'hotel_bed',
        'hotel_bedside_table',
        'hotel_window',
        'hotel_door'
    },
    exit = function (s, to)
        if to == main then
            p [[I don’t want to face with nobody behind the door.
            I should find another way.
            ]];
            return false;
        end
    end,
};


revolver = obj
{
    nam = 'revolver',
    _examined = false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            if here ()== hotel_room then
                p [[Beside the revolver I don’t have anything.
                I have no documents, no money, no credit cards.
                ]];
            end
        end
        p [[I examine revolver. The barrel is strengthen by accelerator, and
        bullets must be bursting in it. Serious gun for serious deals. There
        must be six bullets in revolver’s drum. But two of them are missing
        now.
        ]];
        return;
    end,
    take = function (s)
        p 'I take revolver.';
        return;
    end,
    drop = function (s)
        p [[I don’t want to leave revolver here. It is a bad idea. There are
        many mine fingerprints on it.
        ]];
        return false;
    end,
    useit = function (s)
        p [[I think that shooting from the revolver is not a good idea now.
        ]];
        return;
    end,
    used = function (s, w)
        p [[The revolver is too dangerous toy to do some kind of manipulations
         with it.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[Yes, I know that some maniacs give name to their weapon and talks
        to it. But I’m not this kind.
        ]];
        return;
    end,
};


hotel_bed = obj
{
    nam = 'bed',
    _examined = false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            p [[The cheap bed in cheap hotel. This bed had seen many things
            here. But I have not any wish to clarify the details of it.
            ]];
            return;
        else
            p 'It’s usual bed.';
            return;
        end
    end,
    take = function (s)
        p 'I don’t want to take this bed and carry it everywhere with me.';
        return false;
    end,
    useit = function (s)
        p [[No! I don’t even want to think about how this bed used before me.
        And that was not once. And I don’t neither lay here, not even be here.
        ]];
        return;
    end,
    used = function (s, w)
        p [[I have no time for rest. I need to get out of here as soon as
        possible.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[May be some romantic persons cry to the pillow because of
        unrequited love. But I’m not in this kind of situation. Besides I
        don’t like to complain about my problems to lifeless objects.
        ]];
        return;
    end,
};


hotel_bedside_table = obj
{
    nam = 'bedside-table',
    _examined = false,
    dsc = nil,
    exam = function (s)
        p 'I examine bedside-table. It’s empty.';
        return;
    end,
    useit = function (s)
        p [[I have neither time nor need to use this bedside-table.
        I’m not planning to live here, so I don’t need to put my stuff in it.
        ]];
        return;
    end,
    take = function (s)
        p 'I don’t want to carry bedside-table with me everywhere.';
        return false;
    end,
    used = function (s, w)
        p [[I don’t have time to invent how I can manipulate with this
        bedside-table. Every seconds means a lot!
        ]];
        return;
    end,
    talk = function (s, w)
        p [[Small box doesn’t answer to me. I’ve try to get some answers,
        but in vain...
        ]];
        return;
    end,
};


hotel_door = obj
{
    nam = 'door',
    _examined = false,
    dsc= nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            ways(hotel_room):add(vroom ('Door', 'main'));
            p [[I quietly come to door and accurately look into door’s eye.
            There is nobody behind the door.
            It seems that one who knocking is gone.
            ]];
        else
            p 'I look into the door’s eye. There is nobody behind the door.';
        end
        return;
    end,
    useit = function (s)
        p [[I don’t want to open the door. When there is a blood on the floor,
        it’s hard to assure somebody that it’s OK.
        ]];
        return;
    end,
    take = function (s)
        p [[The door is firmly attached. I have no chance to take it with me.
        ]];
        return false;
    end,
    used = function (s, w)
        p [[The door is locked firmly. I don’t need to strength it any more.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[There is nobody behind the door. Talking to empty space is
        unreasonable.
        ]];
        return;
    end,
};


hotel_window = obj
{
    nam = 'window',
    _examined = false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            ways(hotel_room):add(vroom('Window','hotel_fire_stairs_floor_5'));
            p [[I look to the window. Judging the weather, the summer is going
            to it’s end. It’s later evening now.^
            The window is come out to the yard, which is surrounded by brick
            walls from the three sides. The room I’m in is on the fifth floor.
            I notice the iron ladder is not far from the window.
            It’s built on the fire case.
            If I try, I can jump to it.
            ]];
            return;
        else
            p [[There is a fire ladder not far from the window. If I’ll try,
            I can jump to it.
            ]];
            return;
        end
    end,
    take = function (s)
        p [[I can’t take the window with me.
        ]];
        return false;
    end,
    used = function (s, w)
        p [[The window is opened already. I don’t need to manipulate with him.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[I don’t have time to talk with lifeless objects.
        ]];
        return;
    end,
};


hotel_fire_stairs_floor_5 = room
{
    nam = 'Fire ladder. 5th floor.',
    _visit = 1,
    pic = 'images/hotel_fire_stairs.png',
    dsc = function (s)
        if s._visit == 1 then
            s._visit = 2;
            p [[I get out of the window, and jump.
            I think there are many my fingerprints left in room.
            But I have no choice than leave.
            I’m not assure that I did any crime.
            But I have to figure out everything by myself.^
            I miscalculate my strength slightly and my jump turns out
            awkward. I reach ladder successfully, but pound my forehead at
            footstep. Brain explode with pain again. All start to float
            before my eyes. I grasp the ladder as hard as I can, trying not
            to fall. After a couple of minutes vertigo goes away and I look
            around.^
            I’m at fire ladder.
            Rust is strew from the old footsteps, but ladder looks solid on
            the whole.^
            I can see inner court from here. Brick walls, some wires, which
            stretch on different levels. Only light here is coming from
            windows. So I can’t see very clear course of the approaching
            twilight, which covers the city fast.^
            Old ladder is attached to the building wall. There is a window
            not far from here.
            ]];
        else
            p [[I’m at fire ladder. Rust is strew from the old footsteps,
            but ladder looks solid on the whole.
            There is a window not far from here.
            ]];
        end
        return;
    end,
    obj =
    {
        'hotel_iron_stairs',
        'hotel_window_5'
    },
    way =
    {
        vroom ('Window', 'main'),
        vroom ('Down', 'hotel_fire_stairs_floor_4'),
    },
    exit = function (s, to)
        if to == main then
            p [[I do not want to risk and jump back. I don’t want to fall down
            from here.
            ]];
            return false;
        end
    end,
};


hotel_window_5 = obj
{
    nam = 'window',
    dsc = nil,
    exam = function (s)
        p 'This is a window I jump from.';
        return;
    end,
    take = function (s)
        p [[I can’t take the window with me.
        ]];
        return false;
    end,
    used = function (s, w)
        p [[I have no time to manipulate with window. I have to move on.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[Under the other circumstances may be I try to communicate with
        windows, stones, may be iron...
        But now I have no time to this nonsense.
        ]];
        return;
    end,
};


hotel_iron_stairs = obj
{
    nam = 'ladder',
    dsc = nil,
    exam = function (s)
       p [[It’s just an iron ladder. There are two long metal corners with
       transverse rods boiled to them. It’s still solid despite of it’s old
       age. There are small platforms on every level of the floor.
       ]];
       return;
    end,
    take = function (s)
        p [[I can’t take the ladder with me.
        ]];
        return false;
    end,
    used = function (s, w)
        p [[Ladder doesn’t need to manipulate with.
        It’s serve well enough without my interference.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[The only thing I can do right now is just to count aloud
        the stairs I’m go down at.
        ]];
        return;
    end,
};


hotel_fire_stairs_floor_4 = room
{
    nam = 'Fire ladder. 4th floor.',
    _visit = 1,
    pic = 'images/hotel_fire_stairs.png',
    dsc = function (s)
        if s._visit == 1 then
            s._visit = 2;
            p [[Fighting with vertigo, I’m descend on the next platform
            and scare away pigeons. They flew, indignantly flapping their
            wings.^
            Old rusty iron ladder is attached to the brick wall.
            Not far from the ladder I can see the window.
            There is a dark stain on the platform.
            ]];
        else
            p [[I’m at the fire ladder on the fourth floor level.
            Not far from the ladder I can see the window.
            There is a dark stain on the platform.
            ]];
        end
        return;
    end,
    obj =
    {
        'hotel_iron_stairs',
        'hotel_window_4',
        'hotel_fire_stairs_blood_4'
    },
    way =
    {
        vroom ('Window', 'main'),
        vroom ('Down', 'hotel_fire_stairs_floor_3')
    },
    exit = function (s, to)
        if to == main then
            p [[It’s a long way to window. I don’t want to risk trying to
            jump. I don’t want to fall down because of vertigo.
            ]];
            return false;
        end
    end,
};


hotel_window_4 = obj
{
    nam = 'window',
    dsc = nil,
    exam = function (s)
        p [[The fourth floor window. It’s closed. There is a flower stand on
        the window-sill. Most likely it’s rubber plant. Most likely it is made
        of plastic. Not everyone can allow to own real plant nowadays.
        ]];
        return;
    end,
    take = function (s)
        p 'I can’t take the window with me.';
        return false;
    end,
    used = function (s, w)
        p [[I have no time to manipulate with window. I have to move on.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[Under the other circumstances may be I try to communicate with
        windows, stones, may be iron...
        But now I have no time to this nonsense.
        ]];
    end,
};


hotel_fire_stairs_blood_4 = obj
{
    nam = 'stain',
    _examined =false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            p [[I examine it closer and to my horror I realize that this is a
            blood. It seems that someone who was wounded in hotel room,
            he gone away this way. But how much blood did he loose?
            May be he fall down from the ladder? I look down.
            The trash containers stand down here, but there is nobody here.
            ]];
        else
            p 'It’s a blood stain.';
        end
        return;
    end,
    take = function (s)
        p [[Take it with me? Oh, no. I don’t want to touch it.
        ]];
        return false;
    end,
    talk = function (s, w)
        p [[The blood is speaking to itself. It’s speaks that something
        bad is happened here.
        ]];
        return;
    end,
};


hotel_fire_stairs_floor_3 = room
{
    nam = 'Fire ladder. 3rd floor.',
    _visit = 1,
    pic = 'images/hotel_fire_stairs.png',
    dsc = function (s)
        if s._visit == 1 then
            s._visit = 2;
            p [[I descend one floor lower. My had spin around so badly,
            I just can’t see nothing in front of me but the endless
            rotation, in which ladder, windows and wires are laced with each
            other...^
            Old rusty iron ladder is attached to the brick wall.
            Not far from the ladder I can see the window.
            There is a dark stain on the platform.
            ]];
        else
            p [[I stand on the third floor fire ladder platform.
            Is it the third floor? I’m not sure anymore.^
            Old rusty iron ladder is attached to the brick wall.
            Not far from the ladder I can see the window.
            There is a dark stain on the platform.
            ]];
        end
        return;
    end,
    obj =
    {
        'hotel_iron_stairs',
        'hotel_window_3',
        'hotel_fire_stairs_blood_3'
    },
    way =
    {
        vroom ('Window', 'main'),
        vroom ('Down', 'hotel_fire_stairs_floor_2'),
    },
    exit = function (s, to)
        if to == main then
            p [[I’m hardly stand on my feet. I can’t jump to the window
            in my current condition.
            ]];
            return false;
        end
    end,
};


hotel_window_3 = obj
{
    nam = 'window',
    dsc = nil,
    exam = function (s)
        p [[The window is curtained. I can’t see what is in here anyway.
        ]];
        return;
    end,
    take = function (s)
        p [[I can’t take the window with me.
        ]];
        return false;
    end,
    used = function (s, w)
        p [[I have no time to manipulate with window. I have to move on.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[Under the other circumstances may be I try to communicate with
        windows, stones, may be iron...
        But now I have no time to this nonsense.
        ]];
    end,
};


hotel_fire_stairs_blood_3 = obj
{
    nam = 'stain',
    _examined =false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            p [[It’s a blood. The stain is bigger than on the platform
            level up. It seems that the wound had bleed badly.
            The blood is trickle from the platform down the ladder.
            ]];
        else
            p 'It’s a blood stain.';
        end
        return;
    end,
    take = function (s)
        p [[Take it with me? Oh, no. I don’t want to touch it.
        ]];
        return false;
    end,
    talk = function (s, w)
        p [[The blood is speaking to itself. It’s speaks that something
        bad is happened here.
        ]];
        return;
    end,
};


hotel_fire_stairs_floor_2 = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/hotel_fire_stairs.png',
    dsc = function (s)
        p [[I try to descend lower, but my had whirl so badly that
        I don’t keep my hands on the ladder and fall down.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'hotel_fire_stairs_floor_1') },
};


hotel_fire_stairs_floor_1 = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/hotel_fire_stairs_floor_1.png',
    dsc = function (s)
        p [[I have luck. I fall on the pile of trash packages.
        Judging the terrible smell, the trash is laying here for a very long
        time. So, the pile of trash packages near the trash containers is high
        enough. And this saves me. The garbage softs my fall and I don’t hurt
        a lot.^
        I try to get up. Everything is floating before my eyes.
        The strong smell of cats and rotten garbage is knocking over.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'hotel_fire_stairs_floor_1z') },
};


hotel_fire_stairs_floor_1z = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/hotel_fire_stairs_floor_1.png',
    dsc = function (s)
        p [[Coming loose, I try to get out from the trash package pile.
        But I stumble over, loose my balance and fall. I hit my head against
        trash container. The stars blaze up in my eyes and darkness comes
        after that...
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_1') },
    exit = function (s)
        remove (revolver, inv());
    end,
};



police_car_1 = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/hotel_fire_stairs_floor_1a.png',
    dsc = function (s)
        p [[– You think I engaged to pull out the freaks of all kinds from the
        shit?^
        – Come on, come on, it’s your turn now...^^
        I wake up but can’t open my eyes. My head almost explode.
        I just lay down and listen. It seems that there are two of them
        are speaking. And they are speaking about me.
        In my poor condition I can’t run away from them.
        So, I try not to give myself away that I awake.
        May be I can find out from their dialog something useful...^^
        – And why is that so?
        – I bought the coffee and donuts.^
        – Oh, you call that slops the «coffee»? And that stale rubbish was
        the donuts? Thank you that you clear it out to me. I never been able
        to figure it out by myself...^
        – Excellent! So tomorrow you will buy everything by yourself. And you
        know what... If you say so, everyone is at his own.^
        – Tom, why are you so angry? Just out of hand «everyone is at his
        own»...^
        – Oh I get it. As soon as we start to talk about the money, you blew
        away at once.^
        – Why am I blew away? No, actually... Tom, you frequently buy the
        coffee at the morning... Don’t be so hasty, I get this blockhead
        from the trash right now and we will drive him to the station...
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_2') },
};


police_car_2 = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/hotel_fire_stairs_floor_1a.png',
    dsc = function (s)
        p [[Station? So, these two are cops. I’m curious what they’ll do
        when they’ll find the gun? But it seems that I’ve drop it when I fell.
        It was in my hand when I descend down the ladder, but I don’t feel it
        any more. Then it laying somewhere in the trash pile.
        This the most important that the cops don’t notice it.^^
        – Tom, could you help me?^
        – Do it yourself, Rick... I’ll wait for you here.^
        I feel that I have been grabbed by the hand and then have been pulled
        from the garbage.^^
        – He is heavy, damn...^
        – Come on, come on, don’t bewail...^
        – Wait! What have we got here?^^
        That’s it. This is my end. They’ve found the gun. It’ll be to hard to
        wriggle out now.^^
        – It’s a dead rat, Rick. Don’t be scared, it will not bite you.^
        – It’s very funny. Grab his feet, you, wit...
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_3') },
};


police_car_3 = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/police_carry.png',
    dsc = function (s)
        p [[They carry me over to somewhere. I open my eyes, but I can’t
        focus my look. Everything is whirling before my eyes, just like
        I have been in the center of the hurricane.^^
        – Hey, look! He’s wake up. Don’t twitch, fellow.
        We are representatives of the power.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_4') },
};


police_car_4 = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/police_car_drive.png',
    dsc = function (s)
        p [[They throw me on the back seat of the car and close the door.
        There are no handles on the doors inside, in window thick glass
        mounted.
        There is a strong scent of sweat and other human excretions inside.
        Police radio give out separate city crime reports through the cracks
        and statics. Policeman clicks the switch.^^
        – Central! This is fifty fifth.^
        – Central is on line, – the woman voice reaches out through the
        statics.^
        – Oh, Nikki, my dear! With  my huge pleasure I’m hurry to respond to
        you that we are work through the call. We’ve got the noisemaker.
        We’ll bring him soon. Please, prepare to him worthy apartments.^
        – We are out of the free cells, Fincher. By the way, you’ll look good
        in one of them.^
        – Ouhh, Nikki... When I just start thinking about how you cuff me,
        my heart starts to beating faster.^
        – Fincher, stop playing the fool, – the woman voice is uncompromising.
        – Just deliver yourself to the station. Now.^
        – I’m gladly obey, my mistress!^
        – Fifty fifth! Stop clutter up the air!^^
        Policeman clicks the switch.^
        – Let’s drive on the Alley of the Hopes, Rick.^
        – Are you out of your mind? There are maintenance works doing about
        three days. Let’s drive on quay.^
        – Well... Let’s drive on the quay. It’s a big detour though...^^
        Policeman starts the engine and car starts to move on the stone
        jungle of the city.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_5') },
};


police_car_5 = room
{
    nam = 'Night City Blues',
    hideinv = true,
    pic = 'images/hotel.png',
    dsc = function (s)
        p [[We drive out on avenue, but nothing what I can see
        awake any memory. I don’t remember how I get here.^
        Vertigo slightly abate, but I feel sick still.^
        It seems that hotel I wake up in, is located in poor part of the city.
        Old brick walls and concrete buildings less than ten floors high are
        rambling here densely.
        The evening comes to rule already. The street lamps, showcases of
        shops and cafés are light up.^
        Smooth light of glass cases and fresh air are relaxing and quietly.
        The city is singing his blues. I’d like to enjoy it, if it were not
        emptiness in my past and uncertainty in my future...^
        What lies up ahead? Now, when police get me, my perspectives is not
        so bright.
        It’s good that they didn’t find the revolver though...^
        Unfortunately I don’t know hotel address. I have to go back and find
        the revolver. There are my fingerprints on it.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_6') },
};


police_car_6 = room
{
    nam = 'Quay',
    hideinv = true,
    pic = 'images/quay_1.png',
    dsc = function (s)
        p [[We drive out on quay. I knew this place.
        Lafollet quay waves are licking concrete quay slopes.^
        Not far from here there is a part of the city, known as
        Good Hope Cape. Processing and utilization of wastes technology
        proposed by «Kawasaki Nanotechnology» corporation, allows to heap
        processed and compacted wastes into the ocean. This makes the city
        area grows. Slowly but implacably territory on Good Hope Cape is
        taken from the God of the Sea and is given to the God of the Earth...
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_7') },
};



police_car_7 = room
{
    nam = 'Quay',
    hideinv = true,
    pic = 'images/quay_1.png',
    dsc = function (s)
        p [[On Good Hope Cape lives those who unable to buy the domicile on
        normal land.^
        How can I remember this? I have no idea. It seems that permanent
        memory is not lost. That means that I have trouble with short-term
        memory...
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_8') },
};



police_car_8 = room
{
    nam = 'Quay',
    hideinv = true,
    pic = 'images/quay_2.png',
    dsc = function (s)
        p [[Police car drives along the quay, approaching to dark silhouette
        of skyscrapers.
        Policeman talks about something, and I have to listen that they say.^
        – Rick, did you hear about Douglas?^
        – Nope. Who is it?^
        – Well... It is a lanky guy from «drug» department... On last week
        they knock out factory which produced «White Happiness» in China Town.
        Our people worked very competently, close round everything – not even
        mouse was able to escape. And they just proposed to surrender in an
        amicable way. But all these junkies either just used their own stuff
        or just breathed in all of it. Anyway, I don’t know all details but
        it is result in skirmish.^
        – And so what?^
        – Our people put everybody down, but Douglas had no luck. He got a
        burst point-blank...^
        – Mmmm... Pour fellow... And what, is he dead?^
        – You know what? He is not. But his lung is sifted. Well...
        Now to the most interesting part. The police had payed his operation
        and now he’s got an «Sayamura Medicals» implant instead of his lung.^
        – Oh! It costs vast fortune! I did not know that I can expect this
        moneyed assistance from my own organization in case of emergency...^
        – Just wait for a while. Here is moral of the whole story. They say
        that Douglas is a nephew of the chief of police...^
        – Ouhh... I see... Now I get it...^^
        I feel slightly better. My vertigo is stopped, and sickness is almost
        gone.^^
        – A nephew... There should not be any doubts...^
        – This is not exactly known, but...^^
        I’ve been unable to know what policeman mean by this «but»...
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_9') },
};


police_car_9 = room
{
    nam = 'Quay',
    hideinv = true,
    pic = 'images/quay_police_car_red_car.png',
    dsc = function (s)
        p [[Suddenly something hit our car from behind. The car pulls towards
        aloud.
        I turn back and see that some red car had hit in back of our car.^
        – Rick, what the hell?^
        – Some moron can’t drive properly and forgot to use his brakes. But
        now I’ll teach him! Just sit down, Tom. I’ll deal with it by myself.^
        Policeman walk out from the car slowly. He stretch himself, adjust his
        gun on the belt, flap his door loudly on purpose and goes toward the
        red car.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_10') },
};


police_car_10 = room
{
    nam = 'Quay',
    hideinv = true,
    pic = 'images/police_car_back_left_window.png',
    dsc = function (s)
        p [[The second cop press the button on the radio.^^
        – Central! This is fifty fifth.^
        – This is central. What’s happened?^
        – Well, we’ve got...
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_11') },
};


police_car_11 = room
{
    nam = 'Quay',
    hideinv = true,
    pic = 'images/police_car_back_left_window_blood.png',
    dsc = function (s)
        p [[Right away I hear the gunshot and blood splashes on the window
        next to me. The policeman drop the radio, grab his shotgun which was
        besides the front seats, open wide his door and roll out from the car.
        I collapse on the back seat and conceal myself. It is the best
        solution I have in this situation.^
        Exchange of fire have been desperate but short. Suddenly all become
        quiet. And only female voice on the radio says over and over again
        worried: «Fifty fifth! This is central! What’s happened?»^
        As I can see there is nobody alive who can answer.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'police_car_12') },
};


police_car_12 = room
{
    nam = 'Quay',
    hideinv = true,
    pic = 'images/police_car_door_open.png',
    dsc = function (s)
        p [[Suddenly door swing open and I see gloomy unshaven fellow. He is
        squeeze up wound in his shoulder by hand in which a revolver is in.
        Wrinkle up from pain he throw about:^
        – Get out.^^
        I think that I should not contend and I should do as he said.
        Before I even get up fro the seat shot is ring out and gloomy fellow
        fall backwards. Carefully I look out from the car and I get that
        happened. Rick, the policeman who leave the car first, he is still
        alive. It was him who kill the gloomy guy. But his terrible wound did
        not leave him any chances. He died to the moment I get out from the
        car.
        ]];
        return;
    end,
    obj = { vway('1', '{Next}', 'quay_near_police_car') },
};


quay_near_police_car = room
{
    nam = 'Near the police car',
    pic = 'images/quay_near_police_car.png',
    enter = function (s, from)
        if from == police_car_11 then
            lifeon (quay_police_car_radio);
            p [[I get out from the police car. The gloomy guy who open my door
            is lying not far from here. He is dead. Tom is lying from the
            other side of police car. Rick is lying near the red car. He is
            dead too as far as I can see.
            ]];
            return;
        end
    end,
    dsc = function (s)
        p [[I am at the quay. Ocean waves lazy surge towards the concrete
        plates. There are office skyscrapers silhouettes are seen in the
        distance.^
        I am standing by the police car. There are three bodies are lying
        near. There are nobody else can be seen here.
        ]];
        return;
    end,
    obj = 
    { 
        'quay_police_car',
        'gloomy_man_corpse',
        'policeman_rick_corpse',
        'policeman_tom_corpse' 
    },
    way = { vroom ('To the red car', 'quay_near_red_car'), },
};


gloomy_man_corpse = obj
{
    nam = 'gloomy',
    _examined = false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            put (felchi_credit_card);
            put (felchi_key);
            p [[I search the gloomy guy corpse. I decide not touch his gun. I
            have more than enough troubles. I don’t want that police tagged me
            as «cop killer». In his pocket I found keys and the credit card
            with Peter Felchi name on it.
            ]];
        else
            p [[I search the gloomy guy body once more, but I have not found
            anything interesting.
            ]];
        end
        return;
    end,
    take = function (s)
        p 'I don’t want to move the body.';
        return false;
    end,
    used = function (s, w)
        p [[I have more than enough troubles with the law. I don’t want that
        police to «hang» the body on me.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[In past century different books about some mages and sorcerers was
        very popular. In these books have been described times when all
        questions were decided by the sword and the axe. In those books some
        necromancers was able not only to talk with the dead people but even
        resurrect them. Unfortunately, I’m not that sort of man.
        ]];
        return;
    end,
};


felchi_credit_card = obj
{
    nam = 'credit card',
    _first_time_taken = true,
    dsc = nil,
    exam = function (s)
        p [[Credit card of «Keitaro Credit» bank. Judging to inscription, it
        belongs to Peter Felchi. Now I know gloomy guy name.
        ]];
        return;
    end,
    take = function (s)
        if s._first_time_taken then
            s._first_time_taken = false;
            p [[Credit card can help police to disclose the crime, but I
            desperately need money.  Certainly police can handle this without
            credit card. So, I take credit card and put it in my pocket.
            ]];
        else
            p 'I take credit card.';
        end
        return;
    end,
    drop = function (s)
        p 'I drop credit card.';
        return;
    end,
    useit = function (s)
        p [[I click on plastic with my nail. Hmm... It is not a bad melody
        I’ve got here... I think I should compose a hit at my spare time...
        ]];
        return;
    end,
    used = function (s, w)
        p [[Credit card is useful when it is used on cash machine. And not at
        all otherwise.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[Credit card is a property of «Keitaro Credit» bank. If I have any
        questions about it, I should consult in the nearest bank department. I
        can’t speak with soulless plastic card. It is useless.
        ]];
        return;
    end,
};


felchi_key = obj
{
    nam = 'combokey',
    _examined = false,
    dsc = nil,
    exam = function (s)
        p 'It is a key on a keychain with a little monkey on it.';
        if not s._examined then
            s._examined = true;
            p [[This key is corresponding to modern tendencies in high level
            of house safety.
            ]];
        end
        p [[The key at the same time is a mechanical and contain some
        electronic part. This combokey was belong to gloomy guy.
        ]];
        return;
    end,
    take = function (s)
        p 'I take combokey.';
        return;
    end,
    drop = function (s)
        p 'I drop kombokey.';
        return;
    end,
    useit = function (s)
        p [[I twiddle a combokey on my finger for a while. If somebody is
        watching over me, he may think that I’m an idler. But I have a lot of
        things to do! I should stop wasting my time on a things like this.
        ]];
        return;
    end,
    used = function (s, w)
        p [[The combokey unlocks some sort of lock. If I’ll try to use it on
        some objects mindlessly, I can damage it.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[I try to talk with the key, but it seems that it does not hold any
        voice recognize system.
        ]];
        return;
    end,
};


policeman_rick_corpse = obj
{
    nam = 'Rick',
    dsc = nil,
    exam = function (s)
        p [[I examine policeman. Rick is dead. I don’t want to search his
        pockets.
        ]];
        return;
    end,
    take = function (s)
        p [[I don’t want to move the body. I don’t want to left any signs of
        my present here.
        ]];
        return false;
    end,
    used = function (s, w)
        p [[I have enough problems with the law already. I don not want that
        they think that I am a «cop killer».
        ]];
        return;
    end,
    talk = function (s, w)
        p [[The books about any mages and wizards are used to be popular in
        the previous century. There were described times when people are
        solved their problems by a sword and an axe. In these books
        necromancers can be met. These guys can’t only talk with the people,
        but even resurrect them. Unfortunately, I am not this kind of person.
        ]];
        return;
    end,
};


policeman_tom_corpse = obj
{
    nam = 'Tom',
    dsc = nil,
    exam = function (s)
        p 'Tom is dead. I don’t want to search his body.';
        return;
    end,
    take = function (s)
        p [[I don’t want to move the body. I don’t want to leave any
        evidence of my presence here.
        ]];
        return false;
    end,
    used = function (s, w)
        p [[I have enough problems with the law already. I don not want that
        they think that I am a «cop killer».
        ]];
        return;
    end,
    talk = function (s, w)
        p [[The books about any mages and wizards are used to be popular in
        the previous century. There were described times when people are
        solved their problems by a sword and an axe. In these books
        necromancers can be met. These guys can’t only talk with the people,
        but even resurrect them. Unfortunately, I am not this kind of person.
        ]];
        return;
    end,
};


quay_police_car = obj
{
    nam = 'car',
    _examined = false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            put (quay_police_car_computer);
            put (quay_police_car_radio);
            p [[I search the police car carefully, trying not to leave my
            fingerprints. The computer, which is built in control board, is
            attracted my attention. The radio is calling for cops still.
            ]];
            return;
        else
            p [[I search the police car once more, but did not find any
            interesting.
            ]];
            return;
        end
    end,
    useit = function (s)
        p [[To drive in the police car on the city? It’s a brilliant idea. I’m
        curious what policeman will say to me when they catch me doing this?
        ]];
        return;
    end,
    used = function (s, w)
        p [[I don’t want to do any manipulations with the police property.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[It’s an age of robots now. Artificial intellect is almost build.
        And there are a lot of voice recognition systems built in many
        machinery. But there is no such system in this car.
        ]];
        return;
    end,
};


quay_police_car_computer = obj
{
    nam = 'computer',
    _used = false,
    _opened = false,
    dsc = nil,
    exam = function (s)
        if not s._opened then
            p 'Police car computer.';
        else
            p 'Dismantled police car computer.';
        end
        return;
    end,
    take = function (s)
        p [[The computer is built in instrument panel of police car. I can
        not take it with me.
        ]];
        return false;
    end,
    useit = function (s)
        if s._opened then
            p [[There is a memory block missing here. It is impossible to turn
            it on.
            ]];
            return;
        end
        if not s._used then
           s._used = true;
           p [[The computer is provided with a SPG system. It is a system of
           global positioning. That means that there is an address of hotel
           where I was captured.^
           I try to find out the address, but the computer demand to enter the
           password. Unfortunately I don’t know the password. And I have no
           time to try to fit it.
           ]];
           return;
        else
           p [[I don’t have time to try to fit the password.
           ]];
           return;
        end
    end,
    used = function (s, w)
        if w == knife then
            if not s._opened then
                s._opened = true;
                put (memory_block);
                p [[Using the knife I catch the display of car computer and
                pull it out. After rummaging in the inside of computer, I
                carefully pick out the memory block. There must be some data
                in it. The data about the hotel I was wake up in. I don’t
                know how to extract this data, but they are major hook.
                ]];
                return;
            else
                p [[I have pulled the memory block from the computer already.
                I don’t want anything more from it.
                ]];
                return;
            end
        end
        if w == memory_block then
            p [[It was hard to get the memory block. I don’t want to put it
            back.
            ]];
            return;
        end
        p [[How can I use it on computer? I don’t know...
        ]];
        return;
    end,
    talk = function (s, w)
        p [[No, there is no voice control system in this model.
        ]];
        return;
    end,
};


memory_block = obj
{
    nam = 'memory block',
    _batteries = false,
    _first_time = true,
    dsc = nil,
    exam = function (s)
        if not s._batteries then
            p [[The memory block from police car. Now it is hanging on the
            power wires, which lead from the panel.
            ]];
            return;
        else
            p [[The memory block from the police car. It is powered by the
            battery now.
            ]];
            return;
        end
    end,
    take = function (s)
        if not s._batteries then
            p [[If I pull it out from the panel, the information can be lost.
            ]];
            return false;
        end
        if s._first_time then
            s._first_time = false;
            p [[I carefully take the memory block, holding wires, which
            sticked by the gum. After that I disconnect the power wires from
            the panel and pull out released memory block.
            ]];
        else
            p 'I take the memory block.';
        end
        return;
    end,
    drop = function (s)
        p 'I drop the memory block.';
        return;
    end,
    useit = function (s)
        p 'I don’t know how to extract information from it.';
        return;
    end,
    used = function (s, w)
        if w == knife then
            p [[Knife can solve many problems in life. Using a knife some
            people can get needed information from other people. But I can’t
            get information I need from the memory block by using the knife.
            ]];
            return;
        end
        if w == flashlight_battery then
            if not flashlight_battery._sticked then
                p 'Battery will not hold on the wires.';
            else
                drop (flashlight_battery);
                remove (flashlight_battery);
                s._batteries = true;
                p [[I connect the battery to power wires of memory block and
                stick it with the gum. I hope that this construction will not
                fall apart.
                ]];
            end
            return;
        end
        p 'I just have no idea how I can use it on memory block...';
        return;
    end,
    talk = function (s, w)
        p [[The soulless hardware is unable to answer to me.
        ]];
        return;
    end,
};


quay_police_car_radio = obj
{
    nam = 'radio',
    _index = 0,
    dsc = nil,
    exam = function (s)
        p [[The radio transmitter in police car is a standard «Fujitsu
        Electronic» model.
        ]];
        return;
    end,
    take = function (s)
        p 'I don’t need the radio transmitter. I can’t break it off anyway.';
        return false;
    end,
    useit = function (s)
        walk (quay_police_car_radio_dlg);
        return;
    end,
    used = function (s, w)
        if w == knife then
            p [[There is no point to cut off the radio. The transmitter is
            located in depths of the car anyway. Even if I cut off the radio,
            it will be no use in carrying useless box with the loud speaker
            and the toggle switch.
            ]];
            return;
        end
        p [[I don’t have any ideas how I can use it on the radio.
        ]];
        return;
    end,
    life = function (s)
        s._index = s._index + 1;
        if s._index > 4 then
            s._index = 1;
            if not (here() == quay_police_car_radio_dlg) then
                local v = rnd (5);
                if v == 1 then
                    p [[Alarmed female voice from the radio said: «Central!
                    This is fifty fifth.»
                    ]];
                    return;
                end
                if v == 2 then
                    p [[Alarmed female voice from the radio said:
                    «Central! This is fifty fifth. What’s happened?»
                    ]];
                    return;
                end
                if v == 3 then
                    p [[Alarmed female voice from the radio said:
                    «Central! This is fifty fifth. Please answer!»
                    ]];
                    return;
                end
                if v == 4 then
                    p [[Alarmed female voice from the radio said:
                    «Central! This is fifty fifth. Answer to me immediately!»
                    ]];
                    return;
                end
                if v == 5 then
                    p [[Alarmed female voice from the radio said:
                    «Central! This is fifty fifth. Report your status right
                    now!»
                    ]];
                    return;
                end
            end
        end
    end,
    talk = function (s, w)
        p [[I need to pick the radio up. There is a button on it which I
        should press on to talk. The radio is working in receive mode by
        default.
        ]];
        return;
    end,
};


quay_police_car_radio_dlg = dlg
{
    nam = 'Near the police car',
    hideinv = true,
    pic = 'images/police_car_radio.png',
    enter = function (s, from)
        p 'I pick up the radio.';
        return;
    end,
    phr =
    {
        {
            tag = 'radio_begin',
            [[Central, both policeman from fifty fifth squad are dead.]],
            [[After my phrase the pause appears. Then female voice say:^
            – Who are you?^^
            Well... I’d like to know the answer to that question by myself
            gladly.
            ]],
            [[ psub ('who_am_i'); ]]
        };
        {
            always = true,
            [[Exit.]],
            [[I click the switch and put the radio back.]],
            [[ back(); ]]
        };
        { },
        {
            tag = 'who_am_i',
            [[I’m the one who policeman were drive to the station from the
            motel. By the way, could you please say it’s address?
            ]],
            [[ psub ('radio_end'); ]]
        };
        {
            [[I’m accidental passer-by. There was an assault on your car.
            Everyone is dead.
            ]],
            [[ psub ('radio_end'); ]]
        };
        { },
        {
            tag = 'radio_end',
            function ()
                p [[The woman on the radio say:^
                – Stay where you are. Await the patrol car arriving.^
                Attention everyone! The assault on the policeman on Lafollet
                quay. Surround this region promptly.^^
                I’ve report about accident. I’ve settle a score with my
                conscience. I have to get out from here now. I have to do it
                before the area will be surrounded by the cops.
                ]];
                lifeoff (quay_police_car_radio);
                pjump ('radio_begin');
            end
        };
    }
};


quay_near_red_car = room
{
    nam = 'Near the red car',
    pic = 'images/quay_near_red_car.png',
    enter = function (s, from)
        p [[I approach to the red car. There is a second attacker lying not
        far from here. He is dead too.
        ]];
        return;
    end,
    dsc = function (s)
        p [[I’m at the quay. The ocean waves surging idly over the concrete
        plates. There are silhouette of skyscrapers of the office part of
        town.^
        I’m standing near the red car. There is a corpse of one of the
        attackers lying not far from here. There are nobody else here can be
        seen.
        ]];
        return;
    end,
    obj =
    {
        'quay_red_car',
        'attacker_man_corpse'
    },
    way = { vroom ('To the police car', 'quay_near_police_car'), },
};


quay_red_car = obj
{
    nam = 'car',
    _examined = 0,
    dsc = nil,
    exam = function (s)
        s._examined = s._examined + 1;
        if s._examined == 4 then s._examined = 3; end
        if s._examined == 1 then
            put (quay_red_car_computer);
            put (knife);
            p [[I examine the red car. There is a computer with GPS built in a
            panel. In a glow box I found a knife.
            ]];
            return;
        end
        if s._examined == 2 then
            put (flashlight);
            p [[I examine the car once more. Under the seat I grope some
            object. I think it is a flashlight, judging to it’s shape.
            ]];
            return;
        end
        p [[I examine the car once more, but did not find nothing useful.
        ]];
        return;
    end,
    useit = function (s)
        if not subway._felchi_street then
            p [[I did not know where I can go.]];
            return;
        else
            if have (memory_block) then
                if not (have (knife) and have (flashlight)
                    and have (chewing_gum) and have (felchi_key)
                    and have (felchi_credit_card)) then
                    p [[I know where I can go now, but I think I should
                    examine this place more carefully. May be I’ll find some
                    objects here which I can use later.
                    ]];
                    return;
                else
                    lifeoff (quay_police_car_radio);
                    walk (part_01_end);
                    return;
                end
            else
                p [[I need to know address of the hotel, where I have been
                captured.
                ]];
                return;
            end
        end
    end,
    used = function (s, w)
        p [[This car works perfectly without any additional actions. I have no
        need to use some objects on it.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[I don’t have time to talk. Especially trying to talk with an
        objects which can’t answer to me.
        ]];
        return;
    end,
};


quay_red_car_computer = obj
{
    nam = 'computer',
    _used = false,
    dsc = nil,
    exam = function (s)
        p [[The computer is built in a panel of the car, on which attackers
        have driven. The computer has a GPS module.
        ]];
        return;
    end,
    take = function (s)
        p [[The computer is built in a panel of the car. I can’t take it
        with me.
        ]];
        return false;
    end,
    useit = function (s)
        if not s._used then
            s._used = true;
            subway._felchi_street = true;
            p [[I grasp with the computer fast and find out the address of the
            place the car have leave from. It is a corner of Roosevelt street
            and Valor avenue.
            ]];
        else
            p [[I know the place the red car leave from already.
            ]];
        end
        return;
    end,
    used = function (s, w)
        if w == knife then
            p [[I think there must be another way to get information from the
            computer.
            ]];
            return;
        end
    end,
    talk = function (s, w)
        p [[I think the voice recognition system in the computer is set to the
        owner of the car. If I’ll try to give some voice commands to it, it’ll
        send the signal to the police. I don’t need it.
        ]];
        return;
    end,
};


attacker_man_corpse = obj
{
    nam = 'corpse',
    _examined = false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            put (chewing_gum);
            p [[I examine the corpse of the second attacker. I do not touch
            his gun just in case. I found the chewing gum in his pocket.
            ]];
        else
            p [[I search the body once more, but didn’t find nothing useful.
            ]];
        end
        return;
    end,
    take = function (s)
        p [[I do not want to move the body. And to carry it with me is not my
        goal.
        ]];
        return false;
    end,
    useit = function (s)
        p 'I don’t want to move the body.';
        return;
    end,
    used = function (s, w)
        p [[I have more than enough troubles with the law. I don’t want that
        police to «hang» the body on me.
        ]];
        return;
    end,
    talk = function (s, w)
        p [[The books about any mages and wizards are used to be popular in
        the previous century. There were described times when people are
        solved their problems by a sword and an axe. In these books
        necromancers can be met. These guys can’t only talk with the people,
        but even resurrect them. Unfortunately, I am not this kind of person.
        ]];
        return;
    end,
};


chewing_gum = obj
{
    nam = 'chewing gum',
    dsc = nil,
    exam = function (s)
        p [[It’s a chewing gum. Chewing gum has a fruit taste, as it’s said on
        the label.
        ]];
        return;
    end,
    take = function (s)
        p 'I take the chewing gum.';
        return;
    end,
    drop = function (s)
        p 'I drop the chewing gum.';
        return;
    end,
    useit = function (s)
        p [[Fruit chewing gum are preferred by children. And I just don’t want
        it right now anyway.
        ]];
        return;
    end,
    used = function (s, w)
        p [[I have no idea how I can use it on the chewing gum...
        ]];
        return;
    end,
    talk = function (s, w)
        p [[Should I try to talk with the food? I have to call hospital
        attendants immediately. They’ll take me to the place where people with
        similar thoughts are living...
        ]];
        return;
    end,
};


knife = obj
{
    nam = 'knife',
    _examined = false,
    dsc = nil,
    exam = function (s)
        if not s._examined then
            s._examined = true;
            p [[Old-fashioned folding knife. It’s blade is made from good
            steel. It’s not common asiatic trifle, which anyone can buy in a
            every stall. It’s a rarity. The handle with two cover plates is
            paled with time, but as for the rest, the knife is excellent.^
            I don’t want to think about knife’s previous owner and the things
            what have been done with the knife. From this moment the knife is
            mine and it’ll be never be used for the «dirty» job...
            ]];
        else
            p [[It’s an old folding knife with a strong blade.
            ]];
        end
        return;
    end,
    take = function (s)
        p [[I take the knife.
        ]];
        return;
    end,
    drop = function (s)
        p [[I drop the knife.
        ]];
        return;
    end,
    useit = function (s)
        p [[The knife is very sharp.
        ]];
        return;
    end,
    used = function (s, w)
        if w == flashlight then
            p [[I have no idea how I can use the flashlight on the knife.
            ]];
            return;
        end
        if w == felchi_credit_card then
            p [[I have no idea how I can use the credit card on the knife.
            ]];
            return;
        end
        if w == chewing_gum then
            p [[Only children stick chewing gum to an objects an on people...
            ]];
            return;
        end
        if w == felchi_key then
            p [[The key is using on the locks. It’s pointless to use it on the
            knife.
            ]];
            return;
        end
        if w == memory_block then
            p [[I don’t know what can I do here...
            ]];
            return;
        end
    end,
    talk = function (s, w)
        p [[You know... I will call you Frank. From this time, my sharp
        friend, I’ll call you this name. And someday, I can tell the story to
        my children. This story will be started with the phrase «One day me
        and my best friend Frank...»^
        I should to talk less with the weapon and start to think more about my
        problems. Those, who talks with the weapon, are maniacs. Or they are
        extremely lone and unhappy people...
        ]];
        return;
    end,
};


flashlight = obj
{
    nam = 'flashlight',
    _batteries = true,
    dsc = nil,
    exam = function (s)
        if s._batteries then
            p [[Metal flashlight. It seem the battery is good. But since
            the electric bulb in flashlight is broken, I can’t check it
            out to make sure is it working.
            ]];
        else
            p [[Metal flashlight. The electric bulb is broken. And there
            is no battery. So I just don’t know is it working at all...
            ]];
        end
        return;
    end,
    take = function (s)
        p 'I take the flashlight.';
        return;
    end,
    drop = function (s)
        p 'I drop the flashlight.';
        return;
    end,
    useit = function (s)
        if s._batteries then
            p [[I try to turn on the flashlight, but the electric bulb in it
            is smashed. So, I turn the flashlight off.
            ]];
        else
            p 'There is no battery in the flashlight.';
        end
        return;
    end,
    used = function (s, w)
        if w == knife then
            if s._batteries then
                put (flashlight_battery);
                take (flashlight_battery);
                s._batteries = false;
                p [[I hook up the lid by the knife and take out the battery.
                ]];
            else
                p 'I’ve take out the battery already.';
            end
            return;
        end
        if w == felchi_credit_card then
            p [[I don’t know how I can use the credit card on the flashlight.
            ]];
            return;
        end
        if w == chewing_gum then
            p [[Only children stick chewing gum to an objects an on people...
            ]];
            return;
        end
        if w == felchi_key then
            p [[The key is used on the locks. It’s pointless to use it on the
            flashlight.
            ]];
            return;
        end
        if w == memory_block then
            p [[What? A memory block? On the flashlight? I don’t know how to
            do this...
            ]];
            return;
        end
    end,
    talk = function (s, w)
        p [[The flashlight has only one method of contact with the outer
        world. It’s a small switch on it’s side. If I need to come to
        agreement with it, I have to press the button. The flashlight create
        an impression of yielding and reliable friend. I don’t have to
        persuade it to do it’s job.
        ]];
        return;
    end,
};


flashlight_battery = obj
{
    nam = 'battery',
    _sticked = false,
    dsc = nil,
    exam = function (s)
        p 'It’s a small battery.';
        if s._sticked then
            p 'There is a chewing gum sticked on it.';
        end
        return;
    end,
    take = function (s)
        p 'I take the battery';
        return;
    end,
    drop = function (s)
        p 'I drop the battery';
        return;
    end,
    useit = function (s, w)
        p [[Should I touch the battery with my tongue? Just to check the
        charge? What for? I don’t see any point in it.
        ]];
        return;
    end,
    used = function (s, w)
        if w == chewing_gum then
            if not s._sticked then
                s._sticked = true;
                p [[I take out one chewing gum from the package, chew it over
                and stick it to the battery.
                ]];
            else
                p 'I’ve stick the chewing gum to the battery already.';
            end
            return;
        end
        p 'I have no idea how I can use it on the battery';
        return;
    end,
    talk = function (s, w)
        p [[– Thank you, my little friend! Thank you for despite your small
        size you allow to use great power of electricity in any point of our
        Earth.^
        I’ve spent some time thanking the battery as one of the best
        inventions of humanity. But the silence was the answer to me.
        ]];
        return;
    end,
};


part_01_end = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/red_car_left.png',
    dsc = function (s)
        p [[I sit in the red car, start the engine and drive to the place,
        which I discovered in the computer. There are some bullet holes in a
        car and frontal glass is cracked. But I have no choice.^
        I’m exactly in time. Some police cars come across me. They all rush to
        the quay, but I’ve drove too far to them to connect me with an
        accident. So, I slip away easily.^
        I orient myself for the car computer and get to the destination
        without any troubles.^
        I stop the car two blocks away from the point. I have to get rid of
        the car, I just can’t drive on in. So I wipe carefully all things I’ve
        touch in there. Then I left the key in it and walk to the corner of
        Roosevelt street and Valor avenue.
        ]];
        return;
    end,
    obj =
    {
        obj
        {
            nam = '1'; dsc = '{Далее}';
            act = code [[ gamefile ('en_part_02.lua', true); ]];
        };
    },
};

