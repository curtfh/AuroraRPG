local rootElement = getRootElement()

function getPlayerFromPartialName( name )
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
			local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function runString (commandstring, outputTo, source)
	local sourceName
	if source then
		sourceName = getPlayerName(source)
	else
		sourceName = "Console"
	end
	outputChatBoxR(sourceName.." : "..commandstring, outputTo, true)
	local notReturned
	--First we test with return
	local commandFunction,errorMsg = loadstring("return "..commandstring)
	if errorMsg then
		--It failed.  Lets try without "return"
		notReturned = true
		commandFunction, errorMsg = loadstring(commandstring)
	end
	if errorMsg then
		--It still failed.  Print the error message and stop the function
		outputChatBoxR("Error: "..errorMsg, outputTo)
		return
	end
	--Finally, lets execute our function
	results = { pcall(commandFunction) }
	if not results[1] then
		--It failed.
		outputChatBoxR("Error: "..results[2], outputTo)
		return
	end
	if not notReturned then
		local resultsString = ""
		local first = true
		for i = 2, #results do
			if first then
				first = false
			else
				resultsString = resultsString..", "
			end
			local resultType = type(results[i])
			if isElement(results[i]) then
				resultType = "element:"..getElementType(results[i])
			end
			resultsString = resultsString..tostring(results[i]).." ["..resultType.."]"
		end
		outputChatBoxR("Command results: "..resultsString, outputTo)
	elseif not errorMsg then
		outputChatBoxR("Command executed!", outputTo)
	end
end

-- run command
addCommandHandler("arun",function (player, command, ...)
    local accName = getAccountName ( getPlayerAccount ( player ) ) -- get his account name
    if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then -- Does he have access to Admin functions?
            local commandstring = table.concat({...}, " ")
                    return runString(commandstring, rootElement, player)
            end
end)

-- silent run command
addCommandHandler("asrun",
function (player, command, ...)
	local accName = getAccountName ( getPlayerAccount ( player ) ) -- get his account name
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then -- Does he have access to Admin functions?
		local commandstring = table.concat({...}, " ")
		return runString(commandstring, player, player)
	end
end
)

-- clientside run command
addCommandHandler("acrun",
	function (player, command, ...)
		local commandstring = table.concat({...}, " ")
		if player then
			local accName = getAccountName ( getPlayerAccount ( player ) )
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then 
				return triggerClientEvent(player, "doCrun2", rootElement, commandstring)
			else
				return runString(commandstring, false, false)
			end
		end
	end
)

-- http interface run export
function httpRun(commandstring)
	if not user then outputDebugString ( "httpRun can only be called via http", 2 ) return end
	local notReturned
	--First we test with return
	local commandFunction,errorMsg = loadstring("return "..commandstring)
	if errorMsg then
		--It failed.  Lets try without "return"
		notReturned = true
		commandFunction, errorMsg = loadstring(commandstring)
	end
	if errorMsg then
		--It still failed.  Print the error message and stop the function
		return "Error: "..errorMsg
	end
	--Finally, lets execute our function
	results = { pcall(commandFunction) }
	if not results[1] then
		--It failed.
		return "Error: "..results[2]
	end
	if not notReturned then
		local resultsString = ""
		local first = true
		for i = 2, #results do
			if first then
				first = false
			else
				resultsString = resultsString..", "
			end
			local resultType = type(results[i])
			if isElement(results[i]) then
				resultType = "element:"..getElementType(results[i])
			end
			resultsString = resultsString..tostring(results[i]).." ["..resultType.."]"
		end
		return "Command results: "..resultsString
	end
	return "Command executed!"
end
