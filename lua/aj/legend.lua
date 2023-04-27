require('legendary').setup({
  keymaps = {

    -- map keys to a command
    { '<leader><Left>', ':lua GitVersions()<CR>', description = 'Load Past Versions'},
    { '<leader><leader>', '<C-^>', description = 'Jump to Prev File'},
    { '<leader>b', '<C-o>', description = 'Jump to last cursor'},
    { '<C-b>', ':execute \'Fern \' . RootDirectory() . \' -reveal=%:p -drawer -toggle\'<CR>', description = 'Toggle Fern' , opts= {silent = true}},
    {'<leader>q', ":lua toggle_qf('q')<CR>", description = "Toggle Quickfix"},
    {
      itemgroup = 'Clipboard',
      description = 'Clipboard shortcuts',
      icon = "",
       keymaps = {
        { '[y', '<plug>(YoinkRotateBack)', description = 'Cycle clipboard backward' , opts = {silent = false, noremap = false}, mode='n', },
        { '[y', '<plug>(YoinkRotateBack)', description = 'Cycle clipboard backward' , opts = {silent = false, noremap = false}, mode='n', },
        { 'p', '<plug>(YoinkPaste_p)', description = 'paste' , opts = {silent = false, noremap = false}, mode='n', },
        { 'P', '<plug>(YoinkPaste_P)', description = 'paste P' , opts = {silent = false, noremap = false}, mode='n', },
      }
    },
    {
      itemgroup = 'File Search',
      description = 'Search through your files',
      icon = '',
      keymaps = {
        {'<leader>p', ":lua require'fzf-lua'.files({ prompt='LS>>',  cwd=git_root() })<CR>", description = "Search through files (git)" , opts={silent = false}},
        {'<leader>z', ":lua require('fzf-lua').buffers()<CR>", description = "Search through buffers"},
      },
    },
  },
  commands = {
    -- easily create user commands
    {
      ':Gco',
      function()
        require('fzf-lua').git_branches()
      end,
      description = 'Checkout git branch',
    },
  },
})
