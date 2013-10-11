function table_get_maxn(tbl)
	local c=nil
	for k in pairs(tbl) do
		print(c, k)
		if type(k)=='number' and (c == nil or k > c) then
			c=k
		end
	end
	print('current c is ', c)
	return c
end