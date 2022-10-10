local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local nvim_lsp = require('lspconfig')

--
-- Lspconfig
--

-- Use an on_attach function to only map the following keys after
-- the language server attaches to the current buffer

local on_attach = function(client, bufnr)

	if(client.name == "tsserver") then
		client.server_capabilities.document_formatting = false
	end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<Leader>n', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
  vim.keymap.set('n', '<space>ne', vim.diagnostic.goto_next , bufopts)
  vim.keymap.set('n', '<space>le', vim.diagnostic.setqflist , bufopts)
end


-- nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  root_dir = require('lspconfig').util.root_pattern('.git'),
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = true
  }
}

nvim_lsp.eslint.setup({
  capabilities = capabilities,
  flags = { debounce_text_changes = 500 },
  on_attach = function(client, bufnr)

    client.server_capabilities.document_formatting = true

    if client.server_capabilities.document_formatting then

      local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = {"*.js", "*.jsx", "*.tsx", "*.ts", "*.json"},
        callback = function()
					vim.cmd('silent! :EslintFixAll')
				end,
        group = au_lsp,
      })

    end

  end,
})


-- local config = {
--    name = 'tsserver',
--    cmd = { "typescript-language-server", "--stdio" },
--    root_dir = vim.fs.dirname(vim.fs.find({'.git', 'pnpm-lock.yaml'}, { upward = true })[1]),
--    on_attach = on_attach,
--    capabilities = capabilities
-- }
-- vim.lsp.start(config, {
--   reuse_client = function(client, conf)
--     return (client.name == conf.name
--       and (
--         client.config.root_dir == conf.root_dir
--         or (conf.root_dir == nil and vim.startswith(api.nvim_buf_get_name(0), "/usr/lib/python"))
--       )
--     )
--   end
-- })


--
-- Nvim-cmp
--

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

cmp.setup {
  formatting = {
    format = lspkind.cmp_format()
  },
  mapping = {
--    ['<C-p>'] = cmp.mapping.select_prev_item(),
--    ['<C-n>'] = cmp.mapping.select_next_item(),
--    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--    ['<C-f>'] = cmp.mapping.scroll_docs(4),
--    ['<C-Space>'] = cmp.mapping.complete(),
--    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- use Tab and shift-Tab to navigate autocomplete menu
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  snippet = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  },
}


--
-- Diagnostics
--

-- Set diganostic sign icons
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


require('fzf-lua').setup({
  winopts = {
    preview = {
     layout = 'vertical' 
    }
  }
})

