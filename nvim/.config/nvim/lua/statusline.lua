-- ~/.config/nvim/lua/statusline.lua

local t = {
  bg_dark  = '#1f2335', -- Deepest
  bg_med   = '#24283b', -- Storm background
  bg_light = '#292e42', -- Segment highlight
  fg       = '#c0caf5', -- Main text
  blue     = '#7aa2f7',
  cyan     = '#7dcfff',
  green    = '#9ece6a',
  magenta  = '#bb9af7',
  orange   = '#ff9e64',
  red      = '#f7768e',
}

local function apply_highlights()
  -- Bold Mode Blocks
  vim.api.nvim_set_hl(0, 'SLNormal',  { fg = t.bg_dark, bg = t.blue,    bold = true })
  vim.api.nvim_set_hl(0, 'SLInsert',  { fg = t.bg_dark, bg = t.green,   bold = true })
  vim.api.nvim_set_hl(0, 'SLVisual',  { fg = t.bg_dark, bg = t.magenta, bold = true })
  vim.api.nvim_set_hl(0, 'SLCmd',     { fg = t.bg_dark, bg = t.orange,  bold = true })
  
  -- Layered Segments
  vim.api.nvim_set_hl(0, 'SLFile',    { fg = t.cyan,    bg = t.bg_light, bold = true })
  vim.api.nvim_set_hl(0, 'SLInfo',    { fg = t.fg,      bg = t.bg_med })
  vim.api.nvim_set_hl(0, 'SLMain',    { fg = t.fg,      bg = t.bg_dark })
end

local function get_mode_data()
  local m = vim.api.nvim_get_mode().mode
  if m == 'i' then return ' INSERT ', 'SLInsert'
  elseif m == 'v' or m == 'V' or m == '' then return ' VISUAL ', 'SLVisual'
  elseif m == 'c' then return ' COMMAND ', 'SLCmd'
  else return ' NORMAL ', 'SLNormal'
  end
end

function _G.simple_statusline()
  local mode_text, mode_hl = get_mode_data()
  
  local res = '%#' .. mode_hl .. '#' .. mode_text
  res = res .. '%#SLFile# %f %m%r '
  res = res .. '%#SLMain#%=' 
  res = res .. '%#SLInfo# %y | %{&fileencoding?&fileencoding:&encoding} '
  res = res .. '%#' .. mode_hl .. '#' .. ' %l:%c %P '

  return res
end

apply_highlights()
vim.opt.statusline = '%!v:lua.simple_statusline()'
vim.opt.laststatus = 3
