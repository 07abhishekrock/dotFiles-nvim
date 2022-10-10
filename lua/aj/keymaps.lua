vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function pluginMap(mode, lhs, rhs)
  map(mode, lhs, rhs, { noremap = false })
end

map("t", "<Esc>", "<C-\\><C-n>", { silent = true })

map("n", "<Leader><Left>", ":Gclog -- %<CR>")
map("n", "<Leader>x", "<C-w>s<C-w>j:terminal<CR>:resize 10<CR>")
map("n", "<Leader>X", ":tabnew | terminal<CR>")
map("n", "<Leader>b", "<C-^>")
map("n", "<C-b>", ":execute \'Fern \' . RootDirectory() . \' -reveal=%:p -drawer -toggle\'<CR>", { silent = true })
map("n", "<Leader>ls", ":SessionManager load_session<CR>")
map("n", "<Leader>ds", ":SessionManager delete_session<CR>")

-- map("n", "rm", ':call delete(expand("%")) \| bdelete!<CR>')
-- 
--
map("n", "<Leader>p", ":lua require('fzf-lua').git_files()<CR>", { silent = true })
map("n", "<Leader>z" , ":lua require('fzf-lua').oldfiles()<CR>", { silent = true })
map("n", "<Leader>q", ":lua toggle_qf('q')<CR>")
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



