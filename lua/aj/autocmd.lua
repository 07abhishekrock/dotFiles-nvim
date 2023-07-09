local Utils = require('aj.utils');

local function recordCurrentDirectoryAndSaveAsRoot()
	local dir = Utils.git_root();

	if(not dir) then
		vim.g.currentDir = vim.fn.getcwd();
	else
		vim.g.currentDir = dir;
	end

	local cdCmd = string.format( "cd %s", vim.g.currentDir);
	vim.cmd(cdCmd)

end

vim.api.nvim_create_autocmd(
  {'VimEnter'},
  {
    pattern = {"*"},
    callback = recordCurrentDirectoryAndSaveAsRoot
  }
)

