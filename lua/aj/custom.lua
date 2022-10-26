function getAllFunctions()
	
	local items = vim.fn

	for i, v in pairs(items) do
		
		print(i)

	end

end

function getAllVersions()
	local versionList = vim.fn.getqflist() 
	local versions = {}
	local totalVersions = 0

	for i, v in pairs(versionList) do
		local nameOfBuffer = vim.fn.bufname(v.bufnr)

		for k, v in string.gmatch(nameOfBuffer, "(.+)/.git//(.+)") do
			versions[totalVersions] = v
			totalVersions = totalVersions + 1
		end

	end

	return versions, totalVersions

end

function loadLastVersion(versionNumber)
	
	local versions, totalVersions = getAllVersions()
	local versionNumber = versionNumber or 0

	if (totalVersions - 1) >= versionNumber then
		--valid version		
		
		local versionString = versions[versionNumber]
		
		local cmdString = string.format("silent! Gvdiffsplit %s", versionString)

		vim.cmd(cmdString)

	else
		print("Invalid version count")
	end

end


function replaceAllItemsInQf(replaceString) 

	local items = vim.fn.getqflist()
	local lastBuffer = ""

	table.sort(items, function(item1, item2)
	
		return item1.bufnr < item2.bufnr

	end)

	for i, v in pairs(items) do

		local nameOfBuffer = vim.fn.bufname(v.bufnr) 

		if (lastBuffer == nameOfBuffer) then

			goto loopEnd

		end


		lastBuffer = nameOfBuffer

		local sedCommand = string.format('silent! !sed -i "" -e "%s" %s' , replaceString , nameOfBuffer);

		local closeBufferCommand = string.format('silent! bdelete %s <CR>' , nameOfBuffer);

		print(string.format("Replace complete on %s %s", lastBuffer, vim.fn.expand('%')))

		vim.cmd(sedCommand)

		-- TODO : Close only the non-opened buffers
		--
		
		vim.cmd(closeBufferCommand)

		-- if(nameOfBuffer == vim.fn.expand('%')) then
		-- 	print("File Match found")
		-- end



		::loopEnd::

	end



end


vim.cmd[[

command! -nargs=1 QfReplace lua replaceAllItemsInQf("<args>")
command! -nargs=1 Ver lua loadLastVersion(<args>)

]]
