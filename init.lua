local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
 "lambdalisue/fern.vim",
	{
		'lambdalisue/nerdfont.vim', config=function()
		vim.cmd[[ 
			let g:fern#default_hidden = 1
			let g:fern#default_exclude = '^\.DS_Store$' 
		]]
	end
	},
 "tpope/vim-surround",
 "jiangmiao/auto-pairs",
 "tpope/vim-commentary",
 "kyazdani42/nvim-web-devicons",
 "nvim-lua/plenary.nvim",
 {
	 "nvim-treesitter/nvim-treesitter",
	 build = function()
		 vim.cmd("TSUpdate")
	 end
 },
 {
	 "nvim-telescope/telescope.nvim",
	 tag = "0.1.1"
 },
  {
	 "shaunsingh/nord.nvim",
	 lazy = true,
	 priority = 1000
 },
 {
	 "JoosepAlviste/nvim-ts-context-commentstring",
	 ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
 },
 'tjdevries/express_line.nvim',
 'skywind3000/asyncrun.vim',
 'Shatur/neovim-session-manager',
 {
		"williamboman/mason.nvim",
		build = ":MasonUpdate" -- :MasonUpdate updates registry contents
	},
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	{
		"ms-jpq/coq_nvim",
		config = function()
			-- vim.cmd(":COQnow")
		end
	},
	{
		'neoclide/coc.nvim',
		branch = 'release'
	}
})


vim.cmd('set termguicolors')
vim.cmd('colorscheme nord')
vim.opt.background = 'dark'

require('aj.setup');
require("aj.keymaps");
require("aj.express-line");
require("aj.commands");
require('aj.session-manager');
require('aj.lsp.init');
require('aj.treesitter');
