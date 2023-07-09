local tsserver_options = {
	on_attach = function(client, bufnr)
		-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		client.server_capabilities.document_formatting = false
	end,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },

	capabilities = vim.lsp.protocol.make_client_capabilities(),

	root_dir = require('lspconfig').util.root_pattern({ 'pnpm-lock.yaml', 'package-lock.json', '.git', 'yarn.lock' }),
}

return tsserver_options;
