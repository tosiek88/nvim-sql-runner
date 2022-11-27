local command_name = "SqlRunner"

local M = {
	command_name = command_name,
	values = {
		sql_mappings = {
			n = {
				["<leader>rr"] = "<cmd>" .. command_name .. "<CR>",
				["<leader>sc"] = "<cmd>Telescope sql-runner select_profile<CR>",
			},
		},
		out_mappings = {
			n = {
				["q"] = "<cmd>bd<CR>",
			},
		},
		selected_profile = {},
		profiles = {
			main = {
				user = "root",
				password = "fallen88",
				name = "vxdb",
				uri = "",
			},
			main2 = {
				user = "root2",
				password = "fallen88",
				name = "vxdb",
				uri = "",
			},
		},
	},
}

M.set_profile = function(key)
	if key then
		M.values.selected_profile = {}
		M.values.selected_profile[key] = M.values.profiles[key]
		return
	end
end

M.get_profile = function()
	if M.values.selected_profile then
		return M.values.selected_profile
	end
	return M.values.profiles[1]
end

return M
