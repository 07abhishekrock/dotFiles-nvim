-- local fzf = require('fzf');

-- function GitVersions()

--   coroutine.wrap(function()

--     local openedBuffer = vim.fn.expand("%:p")
--     local gitCmd = 'git log --color --pretty=format:"%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset" <file>'
--     local finalCmd = string.gsub(gitCmd, '<file>', openedBuffer);

--     local status, result = pcall(fzf.fzf, finalCmd, "--nth 1 --ansi --expect=ctrl-t,ctrl-s,ctrl-v")

--     if not status then
--       return
--     end

--     if not result then
--       return
--     end

--     if result then

--       local commitHash = vim.split(result[2], " ")[1]
--       local key = result[1];

--       local windowcmd;

--       if key == "" then
--         windowcmd = "Gvdiffsplit"
--       elseif key == "ctrl-s" then
--         windowcmd = "Gsplit"
--       elseif key == "ctrl-v" then
--         windowcmd = "vsp"
--       elseif key == "ctrl-t" then
--         windowcmd = "tab"
--       else
--         print("Not implemented!")
--         error("Not implemented!")
--       end

--       vim.cmd(string.format("%s %s", windowcmd, commitHash))

--     end
--   end)()

-- end


local picker = require('telescope.pickers');
local finder = require('telescope.finders');
local conf = require("telescope.config").values

local git_command = { "git", "log", '--pretty=format:"\\%h \\%s \\%an"' }

local pickerInstance = picker.new({
        finder = finder.new_oneshot_job(vim.tbl_flatten{
                git_command,
                { vim.fn.expand("%:p") }
            }, {}),
    sorter = conf.sorter
  }, {})


pickerInstance:find();
