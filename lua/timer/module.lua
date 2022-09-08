-- module represents a lua module for the plugin
local M = {}

M.my_first_function = function()
  return "hello world!"
end

-- create_popup_window_opts
local function create_popup_window_opts(opts, sizes_only, width, height)
  local win_height = vim.o.lines - vim.o.cmdheight - 2 -- Add margin for status and buffer line
  local win_width = vim.o.columns
  --  local height = math.floor(win_height * 0.9)
  --local width = math.floor(win_width * 0.8)
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

local text = [[
                                                        
                                    ■                   
 ■■■■■■■■ ■                         ■                   
    ■                               ■                   
    ■     ■   ■■■■  ■■    ■■■■      ■ ■■■    ■■■   ■■■■ 
    ■     ■   ■■  ■■  ■  ■■  ■      ■■  ■■  ■   ■  ■    
    ■     ■   ■   ■   ■  ■   ■■     ■    ■      ■  ■    
    ■     ■   ■   ■   ■  ■■■■■■     ■    ■  ■■■■■   ■■  
    ■     ■   ■   ■   ■  ■          ■    ■  ■   ■     ■ 
    ■     ■   ■   ■   ■  ■■         ■    ■  ■  ■■  ■  ■ 
    ■     ■   ■   ■   ■   ■■■■      ■    ■  ■■■■■  ■■■■ 
                                                        
                                                        
                                                        
                                                        
                                      ■■  ■■  ■■        
                                      ■■  ■■  ■■        
  ■■■■   ■■■■   ■■■■  ■■    ■■■■      ■■  ■■  ■■        
 ■■  ■  ■■  ■■  ■■  ■■  ■  ■■  ■      ■■  ■■  ■■        
 ■      ■    ■  ■   ■   ■  ■   ■■     ■   ■   ■         
 ■      ■    ■  ■   ■   ■  ■■■■■■     ■   ■   ■         
 ■      ■    ■  ■   ■   ■  ■          ■   ■   ■         
 ■■  ■  ■■  ■■  ■   ■   ■  ■■                           
  ■■■■   ■■■■   ■   ■   ■   ■■■■      ■■  ■■  ■■        
]]

local function MaxLength(lines)
  local max = 0
  for i, v in next, lines do
    local l = utfstrlen(v)
    if max < l then
      max = l
    end
  end
  return max
end

-- utfstrlen
function utfstrlen(str)
  local len = #str
  local left = len
  local cnt = 0
  local arr = { 0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc }
  while left ~= 0 do
    local tmp = string.byte(str, -left)
    local i = #arr
    while arr[i] do
      if tmp >= arr[i] then
        left = left - i
        break
      end
      i = i - 1
    end
    cnt = cnt + 1
  end
  return cnt
end

-- create_new_winow
local function create_new_window(msg, opt)
  local lines = vim.split(text, "\n")
  local height = #lines + 2
  print("-------------" .. height)
  local width = MaxLength(lines) + 2
  print("-------------" .. width)
  bufnr = vim.api.nvim_create_buf(false, true)
  win_id = vim.api.nvim_open_win(
    bufnr,
    true,
    create_popup_window_opts({ desc = "Opens timer's UI window.", nargs = 0 }, false, width, height)
  )
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

-- GetInterval
local function GetInterval(val)
  if val == nil then
    return 500
  end
  local num = tonumber(val)
  if num == nil then
    return 500
  end
  return num
end

M.Run = function(msg, opt)
  local interval = GetInterval(opt)
  vim.defer_fn(function()
    create_new_window(msg, opt)
  end, interval)
end

return M
