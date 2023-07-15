local ls = require('luasnip');
local utils = require('aj.utils');
local s = ls.snippet;
local fn = ls.function_node;
local t = ls.text_node;
local i = ls.insert_node;

local function copy(args)
		return args[1][1]
end

local function get_current_filename()
	local filename_with_ext = vim.fn.expand("%:t");
	local filename_without_ext_table = utils.stringSplit(filename_with_ext, '.');

	for index, value in pairs(filename_without_ext_table) do
		if index == 1 then
			return value
		end
	end

	return 'myFile'

end

local snippets = {
	s({
		trig='rnfcc',
		dscr = 'React Native Functional Component from groww'
	}, {
		t({
			'import React from \'react\';',
			'','import {makeMintStyles} from \'@groww/mint\';',
		}),
		t({ '','','type '}), fn(copy, {1}), t('Props = {'),
		t({ '', '}' }),
		t({'', '', 'function '}),
		i(1),
		t('(props: '), fn(copy, {1}), t('Props) {'),
		t({'', '  const styles = useStyles();'}),
		t({'', '', '  return '}), i(0), t({'}'}),
		t({'', '', 'const useStyles = makeMintStyles(()=>({}))'}),
		t({'', '', 'export default '}), fn(copy, {1}), t(';')
	}),
	s({
		trig='rhook',
		dscr = 'React hook',
	}, {
		t('export const '), fn(get_current_filename), t({' = ()=>{'}),
		i(1),
		t({'', '', '}'}),
	})
}

ls.add_snippets('typescriptreact', snippets)
ls.add_snippets('typescript', snippets)
ls.add_snippets('javascriptreact', snippets)
ls.add_snippets('javascript', snippets)
