local picker = require('telescope.pickers');
local finder = require('telescope.finders');
local conf = require("telescope.config").values

local pickerInstance = picker.new({}, {
    finder = finder.new_oneshot_job({
      'git log',
      vim.fn.expand("%:p")
    }, {}),
    sorter = conf.sorter
  })


pickerInstance:find();
