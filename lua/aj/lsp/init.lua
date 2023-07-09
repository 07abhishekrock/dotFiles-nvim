require("mason").setup()
require("mason-lspconfig").setup()
require('aj.lsp.autocmds');
require('aj.lsp.coc-config');
local coq = require "coq"

local lspconfig = require('lspconfig');
local servers = {
	"lua_ls"
}


for _,server in ipairs(servers) do

	local opts = {};

	if server == "lua_ls" then
		opts = require('aj.lsp.lua_ls');
	end

	if server == "tsserver" then
		opts = require('aj.lsp.tsserver');
	end


	lspconfig[server].setup(coq.lsp_ensure_capabilities(opts));

end

