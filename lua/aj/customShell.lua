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


Connect_vpn = function (str)
  local vpn_args = mysplit(str, " ")
  local password = vpn_args[1]
  local vpn_name = vpn_args[2]

  print(password, vpn_name)

  if(password == nil) then
    print("This cmd requires password")
    return
  end

  if(vpn_name == nil) then
    print("no vpn name found")
    return
  end

  local cmd_string = string.format("!echo '%s' | sudo -S ~/vpn/connect.sh %s & disown", password, vpn_name) 
  vim.cmd(cmd_string)

end

vim.cmd[[
command! -nargs=* Connect lua Connect_vpn("<args>")
]]
