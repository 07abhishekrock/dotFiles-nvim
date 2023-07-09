local ls = require('luasnip');
local s = ls.snippet;
local fn = ls.function_node;
local t = ls.text_node;
local i = ls.insert_node;

local function copy(args)
		return args[1][1]
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
	});
}

ls.add_snippets('typescriptreact', snippets)
ls.add_snippets('javascriptreact', snippets)
ls.add_snippets('javascript', snippets)
