local M = {}

M.table_print = function(tt, indent, done)
	done = done or {}
	indent = indent or 0
	if type(tt) == "table" then
		local sb = {}
		for key, value in pairs(tt) do
			table.insert(sb, string.rep(" ", indent)) -- indent it
			if type(value) == "table" and not done[value] then
				done[value] = true
				table.insert(sb, key .. " = {\n")
				table.insert(sb, M.table_print(value, indent + 2, done))
				table.insert(sb, string.rep(" ", indent)) -- indent it
				table.insert(sb, "}\n")
			elseif "number" == type(key) then
				table.insert(sb, string.format('"%s"\n', tostring(value)))
			else
				table.insert(sb, string.format('%s = "%s"\n', tostring(key), tostring(value)))
			end
		end
		return table.concat(sb)
	else
		return tt .. "\n"
	end
end

M.to_string = function(tbl)
	if "nil" == type(tbl) then
		return tostring(nil)
	elseif "table" == type(tbl) then
		return M.table_print(tbl)
	elseif "string" == type(tbl) then
		return tbl
	else
		return tostring(tbl)
	end
end

return M
