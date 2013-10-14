require 'terminal'

fxd_font:init('font/font.ttf', 18);
TERMINAL_W = 44
TERMINAL_H = 20
TERMINAL_BG = 'box:800x600,black'

terminal_subway_demon = terminal
{
	nam = 'Терминал',
	_command = false,
	_hint_enter = true,
	_hint_dev = true,
	_hint_ls = true,
	_hint_mount = true,
	_arg = false,
	_path = '100',
	_mounted = false,
    _file =
    {
        { '100', '/', ' <DIR> etc\n <DIR> dev\n <DIR> home\n <DIR> lib64\n <DIR> mnt\n <DIR> root\n <DIR> tmp' },
        { '200', '/bin', ' <DIR> ..\n 1 kb  cat\n 1 kb  cd\n 1 kb  clear\n 1 kb  echo\n 8 kb  help\n 1 kb  kill\n 1 kb  ls\n 2 kb  man\n 9 kb  mount\n 2 kb  ps\n 1 kb  pwd\n 1 Mb  sdl-instead\n 7 kb  top\n 3 kb  uname\n 1 kb  vim\n 1 kb  who'},
        { '300', '/dev', ' <DIR> ..\n 1 kb  isa1\n 1 kb  keyboard\n 1 kb  old1\n 1 kb  random\n 1 kb  sda1\n 1 kb  tty1\n 1 kb  tty2\n 1 kb  tty3\n 1 kb  xda1'},
        { '301', '/dev/old1', ' <DIR> ..\n 1 kb  ext5'},
        { '500', '/etc', ' 7 kb  fstab\n 4 kb  grub.conf\n 1 kb  resolv.conf\n 1 Mb  sys_init\n 9 kb  passwd\n 3 kb  sys_ppp\n 9 kb  Xorg.conf'},
        { '600', '/home', ' <DIR> ..\n <DIR> vvb\n <DIR> test'},
        { '601', '/home/vvb', ' <DIR> ..\n 1 kb  .kicad\n 3 kb  .bashrc\n 1 kb  .msmtprc\n 3 kb  .muttrc\n 1 kb  .procmailrc\n 3 kb  .vimrc\n'},
        { '700', '/lib64', ' <DIR> ..\n 1 Mb  libext.so\n 2 Mb  libisa.so\n 9 kb  libpci.so\n 2 Mb  libraid.so\n 3 Mb  libusb.so\n 8 kb  libvlb.so\n 9 Mb  lib-7.so'},
        { '800', '/mnt', ' <DIR> ..'},
        { '900', '/root', ' <DIR> ..\n pulseaudio and systemd must die!'},
        { '1000', '/tmp', ' <DIR> ..\n 1 kb  .X0-lock'},
    },
	disp = true,
	start = function (s) -- entered и left использовать нельзя
		s:cls();
		s:echo ('Welcome to the Zinux OS v1.2\n');
		s:echo ('Type help to help.\n');
		s:echo ('Type quit to exit.\n');
		if s._hint_enter then
		    s._hint_enter = false;
    		s:echo ('\nГхм... Значит мне нужно найти каталог,\n');
    		s:echo ('подмонтировать в него устройство и\n');
    		s:echo ('найти на нём нужный файл.\n');
    		s:echo ('Вроде бы не особо сложно...\n');
    		s:echo ('Так... что он пишет?\n');
    		s:echo ('Наберите help для получения помощи,\n');
    		s:echo ('наберите quit для выхода. Итак...\n\n');
    	end
  		s:prompt(">");
	end,
	shell = function (s, line)
	    local ind;
	    local tmp;
	    local i, j;
        --local cmd,a = get_cmd "a b c d";
        local cmd,a = get_cmd (line);
        --print(cmd);
        --print(a[1], a[2], a[3]);

		if cmd == 'quit' then
			walkback();
			if not subway._renascence then
    			p 'Мне надоело работать с терминалом.';
    		else
    			p 'Я узнал всё, что мне было нужно.';
    		end
			return;
		end

		s._command = false;
		if cmd == 'echo' then
			s._command = true;
			s:echo (stead.unpack(a),"\n");
		end

		if cmd == 'cat' then
			s._command = true;
            if (s._path == '800') then
                -- /mnt
                if not s._mounted then
                    s:echo ('There are no files.\n');
                else
                    -- /mnt and is mounted
                    if subway._renascence then
                        s:echo ('\nЯ уже узнал нужную мне информацию.\n\n');
                    else
                        if not (a[1] == '22-07-frid') then
                            if (a[1] == '01-20-tues') or (a[1] == '02-12-wedn') or
                            (a[1] == '02-23-thur') or (a[1] == '10-01-frid') or
                            (a[1] == '11-11-mond') or (a[1] == '19-17-thur') or
                            (a[1] == '23-59-mond') then
                                s:echo ('\nЯ вывел на экран содержимое файла.\n');
                                s:echo ('Внимательно изучив его, я не нашёл\n');
                                s:echo ('нужной мне информации.\n');
                                s:echo ('Это не тот файл, который мне нужен.\n\n');
                            else
                                s:echo ('ERROR: no such file.\n');
                            end
                        else
                            subway._renascence = true;
                            s:echo ('\nЯ вывел на экран содержимое файла.\n');
                            s:echo ('Сегодня пятница. Вот почему файл\n');
                            s:echo ('называется именно так.\n');
                            s:echo ('22:07 - это время создания файла.\n');
                            s:echo ('Изучив содержимое, я узнал, что\n');
                            s:echo ('отель, в котором я очнулся, находился\n');
                            s:echo ('на станции метро "Возрождение".\n\n');
                        end
                    end
                end
            else
                -- NOT /mnt
                s:echo ('Access denied.\n');
            end
		end

		if cmd == 'cd' then
			s._command = true;
            if a[1] then
    			if a[1] == '..' then
    			    if not (tonumber(s._path) == 100) then
    			        -- go UP one level
    			        tmp = math.floor ( tonumber(s._path) / 100 ) * 100;
    			        i = s._path - tmp;
    			        if (i > 0) then
    			            -- 303 or smth
    			            s._path = tostring(tmp);
    			        else
    			            -- 200, 300...
    			            s._path = '100';
    			        end
    			        -- go UP one level END
    			    end
    			else
        			if string.find (a[1], '/') then
        			    -- try to go /p1/p2
        			    j = index_of_path (a[1]);
        			    if j > 0 then
        			        s._path = s._file[j][1];
        			    end
        			else
        			    local p;
        			    -- try to go subfolder1
        			    if (tonumber(s._path) == 100) then
        			        -- pwd = /
        			        p = '/'..a[1];
        			    else
        			        -- pwd is NOT /
        			        local t = 0;
        			        local num = s._path;
      			            for i = 1, #s._file do
    		                    if s._file[i][1] == num then
	                                t = i;
                                end
                            end
        			        p = s._file[t][2]..'/'..a[1];
        			    end
                        j = index_of_path (p);
        			    if j > 0 then
          			        s._path = s._file[j][1];
          			    end
        			end
    			end
            end
            -- dev hint
            if (s._path == '300') and (s._hint_dev) then
                s._hint_dev = false;
                s:echo ('\nГхм... Похоже, один из этих подкаталогов\n');
                s:echo ('представляет то устройство, которое мне\n');
                s:echo ('нужно подмонтировать...\n\n');
            end
            -- mount hint
            if (s._path == '800') and (s._hint_mount) then
                s._hint_mount = false;
                if not s._mounted then
                    s:echo ('\nТак. Похоже, этот каталог годится для\n');
                    s:echo ('монтирования.\n\n');
                end
            end
            -- root? access denied!
            if (s._path == '900') then
                s._path = '100';
                s:echo ('Access denied.\n');
            end
            ind = get_index (s._path, s._file);
            s:echo (s._file[ind][2]);
            s:echo ('\n');
		end

		if cmd == 'clear' then
			s._command = true;
			s:cls();
		end

	    if cmd == 'help' then
			s._command = true;
            s:echo ('cat <file> - print file.\n');
            s:echo ('cd <dir> - change current directory.\n');
			s:echo ('clear - clear screen.\n');
			s:echo ('echo <something> - echo <something>.\n');
			s:echo ('help - print this help.\n')
			s:echo ('ls - list directory contents.\n')
            s:echo ('man <command> - print <command> manual.\n');
            s:echo ('mount - attach files on some device to\n');
            s:echo ('      filesystem.\n');
            s:echo ('pwd - print name of current directory.\n');
			s:echo ('quit - quit.\n');
		end

		if cmd == 'kill' then
			s._command = true;
            s:echo ('You do not have permission to do it.\n');
        end

		if cmd == 'ls' then
			s._command = true;
			if (s._path == '800') then
			    if not s._mounted then
			        s:echo ('/mnt\n\n');
			        s:echo (' <DIR> ..\n');
			    else
			        s:echo ('/mnt\n\n');
			        s:echo (' 4 kb  01-20-tues\n 8 kb  02-12-wedn\n 7 kb  02-23-thur\n');
			        s:echo (' 9 Mb  10-01-frid\n 9 Mb  11-11-mond\n 9 Mb  19-17-thur\n');
			        s:echo (' 1 kb  22-07-frid\n 4 Mb  23-59-mond\n');
			        if s._hint_ls then
			             s._hint_ls = false;
			             s:echo ('\nКакая странная система именования файлов...\n');
			             s:echo ('Какой же из них мне нужен?\n\n');
			        end
			    end
			else
    			ind = get_index (s._path, s._file);
    			s:echo (s._file[ind][2]);
    			s:echo ('\n\n');
    			s:echo (s._file[ind][3]);
    			s:echo ('\n');
			end
        end

        if cmd == 'man' then
			s._command = true;
			s._arg = false;
            if (a[1] == 'cat') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  cat\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  cat <file>\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  Print file on the screen.\n');
                s:echo ('NOTE\n');
                s:echo ('  <file> must be in current folder.\n');
                s:echo ('  <file> can not be full path to it.\n');
                s:echo ('EXAMPLE\n');
                s:echo ('  cat text.txt\n');
                s:echo ('\n');
            end
            if (a[1] == 'cd') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  cd\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  cd <folder>\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  Change current directory to specified.\n');
                s:echo ('  If <folder> is .. than go up level\n');
                s:echo ('  in filesystem.\n');
                s:echo ('NOTES\n');
                s:echo ('  <folder> can be either name of subfolder\n');
                s:echo ('  or specify the full path to it.\n');
                s:echo ('EXAMPLE:\n');
                s:echo ('  cd /\n');
                s:echo ('  cd /home/test\n');
                s:echo ('  cd test\n');
                s:echo ('  cd ..\n');
                s:echo ('\n');
            end
            if (a[1] == 'clear') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  clear\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  clear\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  Clear the terminal screen.\n');
                s:echo ('\n');
            end
            if (a[1] == 'echo') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  echo\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  echo <file>\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  Display a line of text on screen.\n');
                s:echo ('EXAMPLE:\n');
                s:echo ('  echo text\n');
                s:echo ('\n');
            end
            if (a[1] == 'ls') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  ls\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  ls\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  List directory contents.\n');
                s:echo ('\n');
            end
            if (a[1] == 'man') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  man\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  man <command>\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  Print <command> manual on screen.\n');
                s:echo ('EXAMPLE:\n');
                s:echo ('  man mount\n');
                s:echo ('\n');
            end
            if (a[1] == 'mount') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  mount\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  mount <device> <directory>\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  Attach files on <device> to the specified');
                s:echo ('      <directory> in filesystem.\n');
                s:echo ('NOTES\n');
                s:echo ('  <device> must be one of the devices in\n');
                s:echo ('      /dev directory.\n');
                s:echo ('  <directory> must be one you can write to.\n');
                s:echo ('  <directory> must be the full path to\n');
                s:echo ('      device.\n');
                s:echo ('EXAMPLE:\n');
                s:echo ('  mount /dev/sda1 /home/vvb/t\n');
                s:echo ('\n');
            end
            if (a[1] == 'pwd') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  pwd\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  pwd\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  Print name of current/working directory.\n');
                s:echo ('\n');
            end
            if (a[1] == 'quit') then
                s._arg = true;
                s:echo ('\n');
                s:echo ('NAME\n');
                s:echo ('  quit\n');
                s:echo ('SYNOPSIS\n');
                s:echo ('  quit\n');
                s:echo ('DESCRIPTION\n');
                s:echo ('  Close terminal session and quit.\n');
                s:echo ('\n');
            end
            if not s._arg then
                s:echo ('No manual entry for ', a[1], '\n');
            end
        end

		if cmd == 'mount' then
			s._command = true;
			if s._mounted then
			    s:echo ('\nЯ уже подмонтировал устройство.\n\n');
			else
    			if (#a < 2) then
    			    s:echo ('ERROR: No mount point specified!\n');
    			else
    			    if not a[1] then
                        s:echo ('ERROR: No device specified!\n');
                    else
                        -- mount a b
                        if not (a[1] == '/dev/old1') then
                            s:echo ('ERROR: Can not read device ');
                            s:echo (a[1]);
                            s:echo ('\n');
                        else
                            -- mount /dev/CORRECT_ONE b
                            if not (a[2] == '/mnt') then
                                s:echo ('ERROR: Can not write to folder ');
                                s:echo (a[2]);
                                s:echo ('\n');
                            else
                                s._mounted = true;
                                s:echo ('Mounted /dev/old1 to /mnt folder.\n');
                                s:echo ('\nОтлично!\n');
                                s:echo ('Мне удалось подмонтировать устройство.\n');
                                s:echo ('Теперь нужно найти на нём файл...\n\n');
                            end
                            -- mount /dev/CORRECT b END
                        end
                        -- mount a b END
    			    end
    			end
    		end
		end

		if cmd == 'ps' then
			s._command = true;
            s:echo ('  PID TTY          TIME CMD\n');
            s:echo (' 4861 pts/10   00:00:00 bash\n');
            s:echo (' 9137 pts/10   00:00:00 ps\n');
        end

		if cmd == 'pwd' then
			s._command = true;
			ind = get_index (s._path, s._file);
			s:echo ('Current directory is: \n');
			s:echo (s._file[ind][2]);
            s:echo ('\n');
        end

		if cmd == 'sdl-instead' then
			s._command = true;
			s:echo ('Starting INSTEAD...\n');
			s:echo ('"Return of Quantum Cat" file is corrupt.\n');
			s:echo ('Reinstall game and run INSTEAD again.\n');
			s:echo ('\n');
		end

		if cmd == 'top' then
			s._command = true;
            s:echo ('');
            s:echo ('top - 09:16:50 up  1:39,  9 users\n');
            s:echo ('Tasks: 179 total,   1 running, 178 sleeping\n');
            s:echo ('Cpu(s):  0.3%us,  0.2%sy,  0.0%ni, 99.1%id\n');
            s:echo ('Mem: 8 Gb total, 1.4 Gb used, 6.8 Gb free\n');
            s:echo ('Swap: 16 Gb total, 0 Gb used, 16 Gb free\n');
            s:echo ('\n');
            s:echo ('  PID USER %CPU %MEM    TIME+  COMMAND\n');
            s:echo (' 4240 vvb   2.0  0.4   1:29.23 sdl-instead\n');
            s:echo ('  777 vvb   1.1  0.2   1:02.17 vim\n');
            s:echo (' 1209 vvb   1.0  0.1   1:12.31 mc\n');
        end

		if cmd == 'uname' then
			s._command = true;
			s:echo ('Zinux vampire 8.20.1-x86_64\n');
		end

		if cmd == 'vim' then
			s._command = true;
			s:echo ('Starting Vi IMproved...\n');
			s:echo ('systemd files are corrupt.\n');
			s:echo ('Remove systemd from system,\n');
            s:echo ('kill pulseaudio and start vim again.\n');
		end

		if cmd == 'who' then
			s._command = true;
			s:echo ('vvb      tty1         2012-09-05 07:37 (:0)\n');
		end

		if cmd == 'whoami' then
			s._command = true;
			s:echo ('player\n');
		end

		if not s._command then
			s:echo('Invalid command ', cmd, '\n');
		end
		s:prompt('>');
	end,
}


function get_index (path, array)
    local r = 0;
    for i = 1, #array do
        if array[i][1] == path then
            r = i;
        end
    end
    return r;
end
