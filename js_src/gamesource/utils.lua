-- retun number of chars ch in string str
function number_of_chars_in_string (str, ch)
    local res = 0;
    for i = 1, string.len (str) do
        if string.char(string.byte (str, i)) == ch then
            res = res + 1;
        end
    end
    return res;
end


function index_of_path (p)
    local i, res;
    res = 0;
    p = tostring (p);
    -- searching matching path
    for i = 1, #terminal_subway_demon._file do
        if terminal_subway_demon._file[i][2] == p then
            res = i;
        end
    end
    return res;
end
