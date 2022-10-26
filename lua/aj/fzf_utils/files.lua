local fzf = require('fzf');
require('aj.utils')

function OpenFilesDialog()

  coroutine.wrap(function()
    local result = fzf.fzf('fd -t=f', "--nth 1 --ansi --expect=ctrl-t,ctrl-s,ctrl-v")
    if result then

      local choice = vim.split(result[2], "\t")[1]
      local key = result[1];

      local windowcmd;

      if key == "" then
        windowcmd = "e"
      elseif key == "ctrl-s" then
        windowcmd = "sp"
      elseif key == "ctrl-v" then
        windowcmd = "vsp"
      elseif key == "ctrl-t" then
        windowcmd = "tab"
      else
        print("Not implemented!")
        error("Not implemented!")
      end

      vim.cmd(string.format("%s %s", windowcmd, choice))

    end
  end)()

end

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function LoadOpenedBuffers()

  local buffers = vim.api.nvim_list_bufs()
  local workspaceDir = git_root() or vim.cmd('pwd')
  local workspaceBuffers = {}

  for _, v in pairs(buffers) do
    local filename = vim.api.nvim_buf_get_name(v)

    if(string.starts(filename, workspaceDir)) then
      table.insert(workspaceBuffers, v)
    end

  end

  return workspaceBuffers

end


function OpenBuffers()

  coroutine.wrap(function()
   local result = fzf.fzf(LoadOpenedBuffers(), "--nth 1 --ansi --expect=ctrl-t,ctrl-s,ctrl-v,ctrl-x")
    if result then

      local choice = vim.split(result[2], "\t")[1]
      local key = result[1];

      local windowcmd;

      if key == "" then
        windowcmd = "e"
      elseif key == "ctrl-s" then
        windowcmd = "sb"
      elseif key == "ctrl-v" then
        windowcmd = "vertical sb"
      elseif key == "ctrl-t" then
        windowcmd = "tabnew"
      elseif key == "ctrl-x" then
        windowcmd = "bd"
      else
        print("Not implemented!")
        error("Not implemented!")
      end

      vim.cmd(string.format("%s %s", windowcmd, choice))

    end
  end)()

end



