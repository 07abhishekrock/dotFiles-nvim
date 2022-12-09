local Input = require("nui.input")
local event = require("nui.utils.autocmd").event


local function joinStr(table, sep)

  local finalStr = ''
  sep = sep or ''
  for _, value in pairs(table) do
    finalStr = finalStr .. sep .. value
  end

  return finalStr

end

local function formatStrToUniversalGlob(code)
  if string.len(code) == 0
  then
    return ''
  else
    return string.format("**/%s/**/*", code)
  end
end

local function getRgCmdArgs(input)

  local rgToken = ''
  local includeList = {}

  for fileList in string.gmatch(input, "%[.+%]") do

    local i = 0;

    for file in string.gmatch(fileList, "%w*") do

      includeList[i] = file
      i = i + 1

    end

  end

  if #includeList == 0 then

    return input, includeList

  end

  for token in string.gmatch(input, ".*%[") do

    for pattern in string.gmatch(token, "[^%[]*") do

      rgToken = pattern
      break

    end
  end

  return rgToken, includeList

end

local lastRanCommandsList = {}
local traverseIndex = 0

local function mountAndStartInput()

  local popupOptions = {
    position = {
      row=55,
      col=100
    },
    size = {
      width = 50,
    },
    border = {
      style = "single",
      text = {
        top = "[Find Text]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }

  local input = Input(popupOptions, {
    prompt = " > ",
    default_value = lastRanCommandsList[#lastRanCommandsList] or '',
    on_close = function()
      print("Input Closed!")
    end,
    on_submit = function(value)

      local token, fileList = getRgCmdArgs(value)
      local globPatterns = {}

      for k, v in pairs(fileList) do
        globPatterns[k] = formatStrToUniversalGlob(v)
      end

      local tokenArg = string.format("Rg '%s' ", token)
      local globArg = #fileList > 0 and '-g' .. joinStr(globPatterns, " ") or ""

      lastRanCommandsList[#lastRanCommandsList + 1] = value

      vim.cmd(tokenArg .. globArg)
    end,
  })

  -- mount/open the component
  input:mount()
  traverseIndex = #lastRanCommandsList

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)

  -- custom keymapping

  input:map("n", "<Esc>", function()
    input:unmount()
  end, { noremap = true })

  input:map("n", "<C-d>", function()
    vim.cmd([[norm VDi]])
  end, { noremap = true })

  input:map("i", "<C-d>", function()
    vim.cmd([[norm VDi]])
  end, { noremap = true })

  input:map("n", "<C-k>", function()

    if(traverseIndex > 0) then
      traverseIndex = traverseIndex - 1
    end
    traverseIndex = traverseIndex >= 0 and traverseIndex or 0
    local traversedValue = lastRanCommandsList[traverseIndex]

    if(type(traversedValue) ~= 'string') then
      return
    end

    vim.cmd([[norm VDi]] .. traversedValue)
  end, {noremap = true})

  input:map("n", "<C-j>", function()

    if(traverseIndex < #lastRanCommandsList) then
      traverseIndex = traverseIndex + 1
    end

    traverseIndex = traverseIndex >= 0 and traverseIndex or 0
    local traversedValue = lastRanCommandsList[traverseIndex]

    if(type(traversedValue) ~= 'string') then
      return
    end

    vim.cmd([[norm VDi]] .. traversedValue)
  end, {noremap = true})

end

Open = mountAndStartInput

return Open
