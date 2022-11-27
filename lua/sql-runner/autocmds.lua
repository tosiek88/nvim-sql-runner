local M = {}

M.registerOnEntry = function(config)

	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("SqlRunner", { clear = true }),
		pattern = { "*.sql" },
		callback = function(opt)

			local keymap = require("sql-runner.keymap")
			keymap.Map(config.values.sql_mappings, opt.buf)

			vim.api.nvim_create_user_command(config.command_name, function()
				local sql_runner = require("sql-runner.runner")
				sql_runner.run(config, opt.file)
			end, {
				nargs = "*",
				desc = "",
				complete = function()
					print("complete")
				end,
			})

		end,
	})
end

return M
