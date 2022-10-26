vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function pluginMap(mode, lhs, rhs)
  map(mode, lhs, rhs, { noremap = false })
end

map("t", "<Esc>", "<C-\\><C-n>", { silent = true })

map("n", "<Leader><Left>", ":lua GitVersions()<CR>")
map("n", "<Leader>x", "<C-w>s<C-w>j:terminal<CR>:resize 10<CR>")
map("n", "<Leader>X", ":tabnew | terminal<CR>")
map("n", "<Leader><Leader>", "<C-^>")
map("n", "<Leader>b", "<C-o>")
map("n", "<C-b>", ":execute \'Fern \' . RootDirectory() . \' -reveal=%:p -drawer -toggle\'<CR>", { silent = true })

-- map("n", "rm", ':call delete(expand("%")) \| bdelete!<CR>')
-- 
--
map("n", "<Leader>p", ":lua require'fzf-lua'.files({ prompt='LS>>',  cwd=git_root() })<CR>", { silent = true })
map("n", "<Leader>z" , ":lua require('fzf-lua').buffers()<CR>", { silent = true })
map("n", "<Leader>q", ":lua toggle_qf('q')<CR>", { silent = true })

map("n", "ma" ,":lua require('harpoon.mark').add_file() <CR>", { silent = true })


vim.cmd[[
command! -nargs=1 Goto lua require('harpoon.ui').nav_file(<args>) 
command! -nargs=0 Gco lua require('fzf-lua').git_branches()
autocmd FileType qf nnoremap <buffer> <CR> <CR>:lua toggle_qf('q')<CR>
]]

map("n", "ml" ,":lua require('harpoon.ui').toggle_quick_menu() <CR>", { silent = true })
-- Plugin remaps

pluginMap("n", "[y", "<plug>(YoinkRotateBack)")
pluginMap("n", "]y", "<plug>(YoinkRotateForward)")

-- pluginMap("n", "<Leader>R", "<plug>(fern-action-rename:select)")
-- pluginMap("n", "<Leader>D", "<plug>(fern-action-remove=)")
-- pluginMap("n", "<Leader>%", "<plug>(fern-action-new-path=)")
-- pluginMap("n", "mY", "<plug>(fern-action-copy)")
-- pluginMap("n", "mP", "<plug>(fern-action-paste)")
-- pluginMap("n", "my", "<plug>(fern-action-clipboard-copy)")
-- pluginMap("n", "mm", "<plug>(fern-action-clipboard-move)")
-- pluginMap("n", "mp", "<plug>(fern-action-clipboard-paste)")
-- pluginMap("n", "mc", "<plug>(fern-action-clipboard-clear)")



