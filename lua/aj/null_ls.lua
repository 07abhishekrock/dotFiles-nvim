local nullLs = require("null-ls")
local lsp_format = require("lsp-format")

nullLs.setup({
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = lsp_format.on_attach,
		sources = {
        nullLs.builtins.diagnostics.eslint_d,
				nullLs.builtins.formatting.eslint_d,
				nullLs.builtins.code_actions.eslint_d
    }
})
