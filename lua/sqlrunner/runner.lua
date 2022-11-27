local M = {}
M.run = function(config, file_name)

	vim.cmd("vsplit")
	local win_h = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(win_h, bufnr)

  local keymap=require("sqlrunner.keymap")

  keymap.Map(config.values.out_mappings, bufnr)

	local selected = config.values.profiles.main

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "output of: " .. file_name })
	vim.fn.jobstart({
		"mysql",
		"-D" .. selected.name,
		"-u" .. selected.user,
		"-p" .. selected.password,
		"-t",
		"-e",
		"source " .. file_name,
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
end

return M
