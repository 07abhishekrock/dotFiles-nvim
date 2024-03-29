function find_qf(type)
  local wininfo = vim.fn.getwininfo()
  local win_tbl = {}
  for _, win in pairs(wininfo) do
      local found = false
      if type == 'l' and win['loclist'] == 1 then
        found = true
      end
      -- loclist window has 'quickfix' set, eliminate those
      if type == 'q' and win['quickfix'] == 1 and win['loclist'] == 0  then
        found = true
      end
      if found then
        table.insert(win_tbl, { winid = win['winid'], bufnr = win['bufnr'] })
      end
  end
  return win_tbl
end

-- toggle quickfix/loclist on/off
-- type='q': qf toggle and send to bottom
-- type='l': loclist toggle (all windows)
function toggle_qf(type)
  local windows = find_qf(type)
  if #windows > 0 then
    -- hide all visible windows
    for _, win in ipairs(windows) do
      vim.api.nvim_win_hide(win.winid)
    end
  else
    -- no windows are visible, attempt to open
    if type == 'l' then
      open_loclist_all()
    else
      open_qf()
    end
  end
end


-- open quickfix if not empty
function open_qf()
  local qf_name = 'quickfix'
  local qf_empty = function() return vim.tbl_isempty(vim.fn.getqflist()) end
  if not qf_empty() then
    vim.cmd('copen')
    vim.cmd('wincmd J')
  else
    print(string.format("%s is empty.", qf_name))
  end
end

-- enum all non-qf windows and open
-- loclist on all windows where not empty
function open_loclist_all()
  local wininfo = vim.fn.getwininfo()
  local qf_name = 'loclist'
  local qf_empty = function(winnr) return vim.tbl_isempty(vim.fn.getloclist(winnr)) end
  for _, win in pairs(wininfo) do
      if win['quickfix'] == 0 then
        if not qf_empty(win['winnr']) then
          -- switch active window before ':lopen'
          vim.api.nvim_set_current_win(win['winid'])
          vim.cmd('lopen')
        else
          print(string.format("%s is empty.", qf_name))
        end
      end
  end
end

function _echo_multiline(msg)
  for _, s in ipairs(vim.fn.split(msg, "\n")) do
    vim.cmd("echom '" .. s:gsub("'", "''").."'")
  end
end

function shell_error()
  return vim.v.shell_error ~= 0
end

function info(msg)
  vim.cmd('echohl Directory')
  _echo_multiline(msg)
  vim.cmd('echohl None')
end

function git_root(cwd, noerr)
  local cmd = { "git", "rev-parse", "--show-toplevel" }
  if cwd then
    table.insert(cmd, 2, "-C")
    table.insert(cmd, 3, vim.fn.expand(cwd))
  end
  local output = vim.fn.systemlist(cmd)
  if shell_error() then
    if not noerr then info(unpack(output)) end
    return nil
  end
  print(output[1])
  return output[1]
end
