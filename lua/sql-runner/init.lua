local M = {}

M.config = {}

M.setup = function(opts)
	local config = require("sql-runner.config")
	if opts ~= nil then
		M.config.values = vim.tbl_deep_extend("force", config.values, opts)
	end
	config.set_profile("main")
	local register = require("sql-runner.autocmds")
	register.registerOnEntry(config)
end

return M
