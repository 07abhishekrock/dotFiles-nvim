local ls = require('luasnip');
local types = require('luasnip.util.types')

require('aj.luasnip.compile');

ls.config.set_config {
	history = true,
	updateevents = "TextChanged, TextChangedI"
}

vim.keymap.set("i", "<c-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump();
	end
end, {
	silent = true
})

vim.keymap.set("i", "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, {
	silent = true
})

vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {
	silent = true
})


