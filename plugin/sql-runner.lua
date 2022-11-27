local api = vim.api

api.nvim_create_user_command("SqlRunner", function(o)
  local sql_runner= require("sql-run")
end, {
  nargs = "*",
  desc = "",
  complete = function(arglead)
      print("complete")
  end,
})
