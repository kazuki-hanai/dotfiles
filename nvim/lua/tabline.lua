-- nvim-tabline

local utf8 = require("utf8")

local M = {}
local fn = vim.fn

M.options = {
  show_index = true,
  show_modify = true,
  show_icon = false,
  brackets = { '[ ', ' ]' },
  no_name = 'No Name',
  modify_indicator = '[+]',
}

local start_i = 1

local function get_filename_list(options, tabnr)
  local filename_list = {}

  for index = 1, tabnr do
    local winnr = fn.tabpagewinnr(index)
    local bufnr = fn.tabpagebuflist(index)[winnr]
    local path = fn.fnamemodify(fn.bufname(bufnr), ":p:~:.")
    local bufmodified = fn.getbufvar(bufnr, '&mod')

    local s = ''

    -- index
    if options.show_index then
      s = s .. index .. ':'
    end

    -- icon
    -- if options.show_icon and M.has_devicons then
    --   local ext = fn.fnamemodify(path, ':e')
    --   local icon = M.devicons.get_icon(path, ext, { default = true })
    --   s = s .. icon
    -- end

    -- bracket
    s = s .. options.brackets[1]

    if path ~= '' then
      s = s .. path
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

local function generate_shown_tab(filename_list, winlen, tabnr, currtab)
  local shown_filename_list = {}
  local include_currtab = false

  if currtab < start_i then
    start_i = currtab
  end

  local tablen = 0
  while true do
    shown_filename_list = {}
    -- "<< " and " >>" are 6 characters
    tablen = 10

    for index = start_i, tabnr do
      if filename_list[index] == nil then
        break
      end

      -- +3 is for the space and the two brackets?
      -- TODO: Fix 
      tablen = tablen + utf8.len(filename_list[index].name) + 2

      if index == currtab then
        include_currtab = true
      end

      table.insert(shown_filename_list, filename_list[index])

      if winlen < tablen then
        break
      end
    end

    if include_currtab then
      break
    end

    start_i = start_i + 1
  end

  print(tablen, "/", winlen)

  return shown_filename_list
end

local function generate_tab_string(filename_list, winlen, currtab)

  local s = ''

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

  return s
end

local function tabline(options)
  local winlen = vim.opt.columns:get()

  -- Get the number of tabs
  local tabnr = fn.tabpagenr('$')
  local currtab = fn.tabpagenr()

  local filename_list = get_filename_list(options, tabnr)
  local shown_filename_list = generate_shown_tab(filename_list, winlen, tabnr, currtab)
  local s = generate_tab_string(shown_filename_list, winlen, currtab)

  return s
end

function M.setup(user_options)
  M.options = vim.tbl_extend('force', M.options, user_options)
  M.has_devicons, M.devicons = pcall(require, 'nvim-web-devicons')

  function _G.nvim_tabline()
    return tabline(M.options)
  end

  -- Always show tabline
  vim.o.showtabline = 2
  vim.o.tabline = '%!v:lua.nvim_tabline()'

  vim.g.loaded_nvim_tabline = 1
end

return M
