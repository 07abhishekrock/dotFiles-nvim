function GetVpnStatus()
  local totalLinesString = vim.fn.system('ps -u root | grep -G "sudo -A /Applications/Pritunl.app/Contents/Resources/pritunl-openvpn" | wc -l');
  local totalLinesCount = tonumber(totalLinesString);

  if (totalLinesCount >= 1) then
    return '嬨Connected VPN';
  end;
  return '嬨Disconnected';

end


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'branch', 'diff', 'diagnostics'},
    lualine_x = {{ 'filename', path = 1, file_status = true }, 'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_c = {{ 'filename', path = 2, file_status = true }},
  },
  tabline = {},
  winbar = {},
  extensions = {}
}

