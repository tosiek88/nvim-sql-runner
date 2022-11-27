local command_name = "SqlRunner"

local M = {
	command_name = command_name,
	values = {
		sql_mappings = {
			n = {
				["<leader>rr"] = "<cmd>" .. command_name .. "<CR>",
			},
		},
		out_mappings = {
			n = {
				["q"] = "<cmd>bd<CR>",
			},
		},
		profiles = {
			main = {
				user = "root",
				password = "fallen88",
				name = "vxdb",
				uri = "",
			},
		},
	},
}

return M
