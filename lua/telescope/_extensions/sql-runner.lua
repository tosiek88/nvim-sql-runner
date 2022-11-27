local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function table_invert(t)
	local u = {}
	for k, v in pairs(t) do
		u[v] = k
	end
	return u
end

-- our picker function: colors
local profiles = function(opts)
	local config = require("sql-runner.config")

	local keyset = {}
	local n = 0

	local selected = {}
	selected = config.get_profile()
	local inv_selected = table_invert(selected)

	print(vim.inspect(inv_selected))

	for k, v in pairs(config.values.profiles) do
		n = n + 1
		keyset[n] = k
		if inv_selected[v] == k then
			keyset[n] = "* " .. k
		end
	end

	opts = opts or {}

	pickers.new(opts, {
		prompt_title = "Profiles",
		finder = finders.new_table({
			results = keyset,
		}),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				require("sql-runner.config").set_profile(selection[1])
			end)
			return true
		end,
		previewer = previewers.new_buffer_previewer({
			title = "Profile Preview",
			define_preview = function(self, entry, status)
				local clean_entry = string.gsub(entry[1], "* ", "")
				local entry_config = require("sql-runner.config").values.profiles[clean_entry]
				local serializer = require("sql-runner.serializer")

				local lines = {}
				for s in serializer.to_string(entry_config):gmatch("[^\r\n]+") do
					table.insert(lines, s)
				end

				vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
			end,
		}),
	}):find()
end

return require("telescope").register_extension({
	setup = function(ext_config, config)
		-- access extension config and user config
	end,
	exports = {
		select_profile = function(opts)
			return profiles()
		end,
	},
})
