local database = {
	profiles = {
		main = {
			user = "root",
			password = "fallen88",
			name = "vxdb",
			uri = "",
		},
	},
}

local selected = database.profiles.main

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("MateuszTocha", { clear = true }),
	pattern = { "*.sql" },
	callback = function(opt)
		vim.cmd("vsplit")
		local win_h = vim.api.nvim_get_current_win()
		local wins_h = vim.api.nvim_list_wins()

		print(vim.inspect(wins_h))
		print(vim.inspect(win_h))

		local bufnr = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(win_h, bufnr)

		vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<leader>bd", {})
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "output of: schema.sql" })
		vim.fn.jobstart({
			"mysql",
			"-D" .. selected.name,
			"-u" .. selected.user,
			"-p" .. selected.password,
			"-t",
			"-e",
			"source " .. opt.file,
		}, {
			stdout_buffered = true,
			stderr_buffered = true,
			on_stderr = function(_, data)
				for _, v in pairs(data) do
					vim.api.nvim_err_write(v)
				end
			end,
			on_stdout = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
					vim.api.nvim_set_current_win(win_h)
				end
			end,
		})
	end,
})
