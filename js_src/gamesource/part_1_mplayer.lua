mplayer_part_1 = obj
{
    nam = 'player_part_1';
    life = function (s)

        -- part 1 chapter 1
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

    end;
};

