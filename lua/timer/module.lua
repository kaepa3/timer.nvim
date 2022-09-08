-- module represents a lua module for the plugin
local M = {}

M.my_first_function = function()
  return "hello world!"
end

-- create_popup_window_opts
local function create_popup_window_opts(opts, sizes_only)
  local win_height = vim.o.lines - vim.o.cmdheight - 2 -- Add margin for status and buffer line
  local win_width = vim.o.columns
  local height = math.floor(win_height * 0.9)
  local width = math.floor(win_width * 0.8)
  local popup_layout = {
    height = height,
    width = width,
    row = math.floor((win_height - height) / 2),
    col = math.floor((win_width - width) / 2),
    relative = "editor",
    style = "minimal",
    zindex = 50,
  }

  if not sizes_only then
    popup_layout.border = opts.border
  end

  return popup_layout
end

-- create_new_window
local function create_new_window(msg, opt)
  bufnr = vim.api.nvim_create_buf(false, true)
  win_id = vim.api.nvim_open_win(
    bufnr,
    true,
    create_popup_window_opts({ desc = "Opens timer's UI window.", nargs = 0 }, false)
  )
  local lines = { "hoge", "yoge", msg }
  if string.len(opt) > 0 then
    lines[#lines + 1] = opt
  end
  lines[#lines + 1] = "add"

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

-- GetInterval
local function GetInterval(val)
  if val == nil then
    return 500
  end
  local num = tonumber(val)
  return num
end

M.Run = function(msg, opt)
  local interval = GetInterval(opt)
  vim.defer_fn(function()
    create_new_window(msg, opt)
  end, interval)
end

return M
