local M = {}

M.Map = function(modes, buffernr)
	for mod, mapping in pairs(modes) do
		for key, cmd in pairs(mapping) do
			vim.api.nvim_buf_set_keymap(buffernr, mod, key, cmd, {})
		end
	end
end

return M
