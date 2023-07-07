local picker = require('telescope.pickers');
local finder = require('telescope.finders');
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local git_command = { "git", "log", "--pretty=format:\'%h %s %an\'" }

local function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function GetFileCommitHistory ()

  local gitLogPickerInstance = picker.new({
      finder = finder.new_oneshot_job({"git", "log", '--pretty=%s %ar (%an) #%H', vim.api.nvim_buf_get_name(0)}, {}),
      attach_mappings = function()
        actions.select_default:replace(function ()
            local selection = action_state.get_selected_entry()
            local splitTable = mysplit(selection.value, "#")
            local commitHash = splitTable[#splitTable];

            vim.cmd.Gvdiffsplit(commitHash);
        end)

        return true;

      end
    }, {})

  gitLogPickerInstance:find();

end


