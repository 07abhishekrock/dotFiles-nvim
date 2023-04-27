local builtins = require('el.builtin');
local extensions = require('el.extensions');
local sections = require('el.sections');

local generator = function ()
  local el_segments = {};

  -- add mode
  table.insert(el_segments, extensions.mode)

  -- add spacer
  table.insert(el_segments, '  ')

  -- add git changes
  table.insert(el_segments, extensions.git_icon);
  table.insert(el_segments, ' ')
  table.insert(el_segments, extensions.git_branch);

  -- add spacer
  table.insert(el_segments, '  ')

  -- add file name
  table.insert(el_segments, extensions.file_icon);
  table.insert(el_segments, ' ')
  table.insert(el_segments, builtins.shortened_file);


  return el_segments;

end



require('el').setup {
  -- An example generator can be seen in `Setup`.
  -- A default one is supplied if you do not want to customize it.
  generator = generator
}
