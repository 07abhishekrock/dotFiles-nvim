vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.cmd [[
autocmd FileType qf nnoremap <buffer> <CR> <CR>:lua toggle_qf('q')<CR>
command! -nargs=* F copen | AsyncRun rg --vimgrep -S <args>
command! -nargs=1  -complete=file Tsc copen | AsyncRun tsc -p <args>/tsconfig.json --pretty false | rg -N '\((\d*),(\d*)\)' -r ':$1:$2'
command! -nargs=0 VpnStatus lua vim.notify(GetVpnStatus())
command! -nargs=0 VpnDisconnect !source ~/vpn/.connect_rc.zsh && disconnect
command! -nargs=1 VpnConnect !source ~/vpn/.connect_rc.zsh && connect <args>
command! -nargs=* Gcpr silent !source ~/.config/custom/bash/git_cmds.sh && githubprcopy <args>
command! -nargs=0 LspClear silent !rm -Rf  /Users/abhishekjha/.local/state/nvim/lsp.log

command! -nargs=0 JdtUpdateConfig lua require('jdtls').update_project_config()
command! -nargs=0 JdtJol lua require('jdtls').jol()
command! -nargs=0 JdtBytecode lua require('jdtls').javap()
command! -nargs=0 JdtJshell lua require('jdtls').jshell()
]]

vim.cmd [[
  :tnoremap <C-q> <C-\><C-n>
]]

