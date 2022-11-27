local M = {}

M.config = {}

M.setup = function(opts)
	local config = require("sqlrunner.config")
	if opts ~= nil then
		M.config.values = vim.tbl_deep_extend("force", config.values, opts)
	end
	local register = require("sqlrunner.autocmds")
	register.registerOnEntry(config)
end

return M
