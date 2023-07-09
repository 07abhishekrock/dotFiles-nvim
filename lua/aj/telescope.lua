local telescope = require('telescope');
local builtins = require('telescope.builtin');

telescope.setup{
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top"  -- search bar at the top
    },
    mappings = {
    }
  },
  pickers = {
  },
  extensions = {
  }
}

vim.keymap.set("n", "<leader>p", function()
	builtins.find_files({hidden = true})
end);
vim.keymap.set("n", "<leader>g", function()
	builtins.live_grep({})
end);
vim.keymap.set("n", "<leader>z", function()
	builtins.buffers{ sort_mru = true }
end);
vim.keymap.set("n", "<leader>w", function()
	telescope.extensions.luasnip.luasnip{
		layout_strategy = 'vertical',
		layout_config = {
			vertical = {width = 0.5}
		}
	}
end);

