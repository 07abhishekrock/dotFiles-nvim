local nullLs = require("null-ls")
local lsp_format = require("lsp-format")

local callback = function()
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            return client.name == "null-ls"
        end
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

nullLs.setup({
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = lsp_format.on_attach,
		sources = {
        nullLs.builtins.diagnostics.eslint,
				nullLs.builtins.formatting.eslint,
				nullLs.builtins.code_actions.eslint
    }
})
