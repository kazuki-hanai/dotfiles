-- nvim-tabline
-- David Zhang <https://github.com/crispgm>

local utf8 = require("utf8")

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

local start_i = 1

local WINBUF = 0

local function get_filename_list(options)
  local tabnr = fn.tabpagenr('$')
  local filename_list = {}

  for index = 1, tabnr do
    local winnr = fn.tabpagewinnr(index)
    local bufnr = fn.tabpagebuflist(index)[winnr]
    local bufname = fn.bufname(bufnr)
    local bufmodified = fn.getbufvar(bufnr, '&mod')

    local s = ''

    -- index
    if options.show_index then
      s = s .. index .. ':'
    end

    -- icon
    if options.show_icon and M.has_devicons then
      local ext = fn.fnamemodify(bufname, ':e')
      local icon = M.devicons.get_icon(bufname, ext, { default = true })
      s = s .. icon .. ' '
    end

    -- bracket
    s = s .. options.brackets[1]

    if bufname ~= '' then
      s = s .. bufname
    else
      s = s .. options.no_name
    end

    -- modify indicator
    if
        bufmodified == 1
        and options.show_modify
        and options.modify_indicator ~= nil
    then
      s = s .. options.modify_indicator
    end

    -- bracket
    s = s .. options.brackets[2]

    table.insert(filename_list, {
      index = index,
      name = s
    })
  end

  return filename_list
end

local function get_tablen(filename_list)
  local tablen = 0
  for index = 1, #filename_list do
    tablen = tablen + utf8.len(filename_list[index].name)
  end
  return tablen
end

local function generate_shown_tab(filename_list)
  local currtab = fn.tabpagenr()
  local tabnr = fn.tabpagenr('$')
  local winlen = vim.opt.columns:get()

  local shown_filename_list = {}
  local include_currtab = false

  if currtab < start_i then
    start_i = currtab
  end

  while true do
    shown_filename_list = {}
    local tablen = 0
    for index = start_i, tabnr do
      if filename_list[index] == nil then
        break
      end

      tablen = tablen + utf8.len(filename_list[index].name)

      if index == currtab then
        include_currtab = true
      end

      table.insert(shown_filename_list, filename_list[index])

      if winlen - 2 * (#shown_filename_list) - WINBUF < tablen then
        break
      end
    end

    if include_currtab then
      break
    end

    start_i = start_i + 1
  end

  return shown_filename_list
end

local function generate_tab_string(filename_list)
  local currtab = fn.tabpagenr()
  local winlen = vim.opt.columns:get()

  local s = ''

  local tablen = 0
  for index = 1, #filename_list do
    tablen = tablen + utf8.len(filename_list[index].name)
  end

  if winlen -2 * (#filename_list) - WINBUF < tablen then
    if #filename_list ~= 0 and filename_list[#filename_list].index ~= currtab then
      for i = #filename_list, 1, -1 do
        if tablen - utf8.len(filename_list[i].name) < winlen then
          local bef_len = utf8.len(filename_list[i].name)
          local end_offset = utf8.offset(filename_list[i].name, tablen - winlen + 3)
          filename_list[i].name = string.sub(filename_list[i].name, 1, end_offset) .. '...'
          tablen = tablen - bef_len + utf8.len(filename_list[i].name)
          break
        else
          tablen = tablen - utf8.len(filename_list[i].name)
          table.remove(filename_list, i)
        end
      end
    else
      while #filename_list ~= 1 do
        local i = 1
        if tablen - utf8.len(filename_list[i].name) < winlen then
          local bef_len = utf8.len(filename_list[i].name)
          local end_offset = utf8.offset(filename_list[i].name, tablen - winlen + 3)
          filename_list[i].name = string.sub(filename_list[i].name, 1, end_offset) .. '...'
          tablen = tablen - bef_len + utf8.len(filename_list[i].name)
          break
        else
          tablen = tablen - utf8.len(filename_list[i].name)
          table.remove(filename_list, i)
        end
      end
    end
  end

  if #filename_list ~= 0 and filename_list[1].index ~= 1 then
    filename_list[1].name = '<< ' .. filename_list[1].name
  end

  if #filename_list ~= 0 and filename_list[#filename_list].index ~= fn.tabpagenr('$') then
    filename_list[#filename_list].name = filename_list[#filename_list].name .. ' >>'
  end

  for index = 1, #filename_list do
    s = s .. '%' .. index .. 'T'
    if filename_list[index].index == currtab then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    s = s .. ' ' .. filename_list[index].name
  end

  s = s .. '%#TabLine#'
  s = s .. '%#TabLineFill#'

  print(tablen, "/", winlen)

  return s
end

local function tabline(options)
  local filename_list = get_filename_list(options)
  local shown_filename_list = generate_shown_tab(filename_list)
  local s = generate_tab_string(shown_filename_list)

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
