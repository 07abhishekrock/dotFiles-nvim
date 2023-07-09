local extensions = require('el.extensions')
local subscribe = require('el.subscribe')
local sections = require('el.sections')

vim.cmd[[
	highlight StatusBarError cterm=bold,reverse guifg=#FF7043  guibg=#434c5e 
	highlight StatusBarWarn cterm=bold,reverse guifg=#ebcb8b  guibg=#434c5e 
]]

function Status(window, buffer)
	local info = vim.api.nvim_eval('get(b:, \'coc_diagnostic_info\', {})')
	local is_error = false;
	local total_diagnostics_count = 0;

	for v,w in pairs(info) do

		if type(w) == 'number' then

			if v == "error" and w > 0 then
				is_error = true;
				total_diagnostics_count = total_diagnostics_count + w;
			end
			if v == "warning" and w > 0 then
				total_diagnostics_count = total_diagnostics_count + w;
			end

		end

	end

	if total_diagnostics_count > 0 then
		if is_error then
			return sections.highlight('StatusBarError', string.format( "%%f %d ", total_diagnostics_count))(window, buffer);
		else
			return sections.highlight('StatusBarWarn', string.format("%%f %d " ,total_diagnostics_count ))(window, buffer);
		end
	end

	return '%f'
end

local generator = function(_window, buffer)
   local segments = {}

	table.insert(segments,
			subscribe.buf_autocmd(
				"el_edit_mode",
				"ModeChanged",
				function(_, buffer)
					local mode = vim.api.nvim_get_mode().mode;
					if mode == 'n' then
						return sections.highlight('DiffAdd', ' NORMAL ')(_, buffer)
					elseif mode == 'i' then 
						return sections.highlight('TermCursor', ' INSERT ')(_, buffer)
					elseif mode == 'v' then
						return sections.highlight('DiffDelete', ' VISUAL ')(_, buffer)
					else
						return sections.highlight('DiffText', ' COMMAND ')(_, buffer)
					end

				end
		))

	table.insert(segments, ' ');



		table.insert(segments, sections.maximum_width(function (window, buffer)
			if string.find(buffer.name, 'fern://') then
				return ' Fern '
			end
			return Status(window, buffer);
		end, 50))

	 table.insert(segments, sections.split);

  table.insert(segments,
    subscribe.buf_autocmd(
      "el_git_status",
      "BufWritePost",
      function(window, buffer)

        local changes =  extensions.git_changes(window, buffer)
        if changes then
					local changesSanitized = string.sub(changes, 2, #changes - 1) 
					local splitOnCommas = require('aj.utils').stringSplit(changesSanitized, ',')

					local addedCount = '';
					local changedCount = '';
					local deletedCount = '';


					for index, v in ipairs(splitOnCommas) do
						if index == 1 then
							addedCount = sections.highlight('Question', v)(window, buffer);
						end
						if index == 2 then
							changedCount = sections.highlight('CursorLineFold', v)(window, buffer);
						end
						if index == 3 then
							deletedCount = sections.highlight('WildMenu', v)(window, buffer);
						end
					end

					local spacing = sections.highlight('Question', ' ')(window, buffer);

          return spacing ..  addedCount .. changedCount .. deletedCount .. spacing;
        end
      end
    ))

   table.insert(segments,
    subscribe.buf_autocmd(
      "el_git_branch",
      "BufEnter",
      function(window, buffer)
        local branch = extensions.git_branch(window, buffer)
        if branch then
          return string.format( "  %s ",branch )
        end
      end
    ))


	table.insert(segments,
			subscribe.buf_autocmd(
				"el_file_icon",
				"BufRead",
				function(_)
					local completeExtensionWithIcon = string.format(" %s %s " ,extensions.file_icon(_,buffer), buffer.extension)
					return sections.highlight('PMenuSel', completeExtensionWithIcon)(_, buffer)
				end
		))


	 return segments;
end

require('el').setup({generator = generator})


