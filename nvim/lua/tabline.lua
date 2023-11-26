-- nvim-tabline
-- David Zhang <https://github.com/crispgm>

local M = {}
local fn = vim.fn

M.options = {
  show_index = true,
  show_modify = true,
  show_icon = false,
  brackets = { '[', ']' },
  no_name = 'No Name',
  modify_indicator = ' [+]',
}

M.tablist = {}

local function get_second_level_path(bufname)
  local paths = {}
  for p in string.gmatch(fn.fnamemodify(bufname, ":~:."), "[^/]+") do
    table.insert(paths, p)
  end

  local path = paths[#paths]
  for i = 1, 2 do
    if #paths - i < 1 then
      break
    end
    path = paths[#paths - i] .. '/' .. path
  end

  return path
end

local function tabline(options)
  local s = ''
  local tabnr = fn.tabpagenr('$')
  local tablen = 0
  for index = 1, tabnr do
    local winnr = fn.tabpagewinnr(index)
    local buflist = fn.tabpagebuflist(index)
    local bufnr = buflist[winnr]
    local bufname = fn.bufname(bufnr)
    local bufmodified = fn.getbufvar(bufnr, '&mod')

    s = s .. '%' .. index .. 'T'
    if index == fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    -- tab index
    s = s .. ' '
    -- index
    if options.show_index then
      s = s .. index .. ':'
    end
    -- icon
    local icon = ''
    if options.show_icon and M.has_devicons then
      local ext = fn.fnamemodify(bufname, ':e')
      icon = M.devicons.get_icon(bufname, ext, { default = true }) .. ' '
    end

    local path = get_second_level_path(bufname)

    s = s .. options.brackets[1]
    if bufname ~= '' then
      s = s .. icon .. path
      tablen = tablen + string.len(icon .. path)
    else
      s = s .. options.no_name
      tablen = tablen + string.len(options.no_name)
    end
    s = s .. options.brackets[2]
    -- modify indicator
    if
        bufmodified == 1
        and options.show_modify
        and options.modify_indicator ~= nil
    then
      s = s .. options.modify_indicator
    end
    -- additional space at the end of each tab segment
    s = s .. ' '

    -- spaces
    tablen = tablen + 6
  end

  s = s .. '%#TabLine#' .. tablen .. ''
  tablen = tablen + 4

  s = s .. '%#TabLineFill#'
  return s
end

function M.setup(user_options)
  M.options = vim.tbl_extend('force', M.options, user_options)
  M.has_devicons, M.devicons = pcall(require, 'nvim-web-devicons')

  function _G.nvim_tabline()
    return tabline(M.options)
  end

  vim.o.showtabline = 2
  vim.o.tabline = '%!v:lua.nvim_tabline()'

  vim.g.loaded_nvim_tabline = 1
end

return M
