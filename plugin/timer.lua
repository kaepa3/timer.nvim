package.loaded["timer"] = nil
package.loaded["timer.module"] = nil
vim.api.nvim_create_user_command("SetTimer", function(args)
  require("timer").hello(args)
end, { nargs = "?" })
