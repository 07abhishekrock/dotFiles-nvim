-- local api = vim.api

-- local vimEnterGroup = api.nvim_create_augroup("vim-enter-group", { clear = true })
-- api.nvim_create_autocmd("VimEnter", {
--   command = "silent! if @% == '' | :GG | endif<CR>",
--   group = vimEnterGroup
-- })

local function changeDirToGitRoot()
  local dir = git_root()

  if dir then
    local cdCmd = string.format( "cd %s", dir);
    vim.cmd(cdCmd)
  end

end

local function formatDartFile()
  vim.cmd("silent !dart format %")
end

vim.api.nvim_create_autocmd(
  {'VimEnter'},
  {
    pattern = {"*"},
    callback = changeDirToGitRoot
  }
)


vim.api.nvim_create_autocmd(
  {'BufWritePost'},
  {
    pattern = { "*.dart" },
    callback = formatDartFile
  }
)

