local Utils = require('aj.utils');

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- remap jump to prev file
vim.keymap.set("n", '<leader><leader>', '<C-^>');

-- remap jump to prev breakpoint 
vim.keymap.set("n", '<leader>b', '<C-o>');

--fern remaps
vim.keymap.set({ "n", "i", "s" }, '<C-b>', function ()
	local cmdString = string.format(":Fern %s -drawer -toggle -reveal=%%:p", Utils.get_current_dir());
	vim.cmd(cmdString);
end)
