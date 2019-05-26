local rootElement = getRootElement()

function runString (commandstring, outputTo, sourceName)
	--outputChatBoxR(sourceName.." executed command: "..commandstring, outputTo, true)
	exports.discord_staff:send("chat.message.text", { author = sourceName, text = " executed command: "..commandstring })
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
		--outputChatBoxR("Error: "..errorMsg, outputTo)
		exports.discord_staff:send("chat.message.text", { author = sourceName, text = "Error -> "..outputTo })
		return
	end
	--Finally, lets execute our function
	results = { pcall(commandFunction) }
	if not results[1] then
		--It failed.
		--outputChatBoxR("Error: "..results[2], outputTo)
		exports.discord_staff:send("chat.message.text", { author = sourceName, text = "Error -> "..results[2] })
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
		--outputChatBoxR("Command results: "..resultsString, outputTo)
		exports.discord_staff:send("chat.message.text", { author = sourceName, text = "Command results: "..resultsString })
	elseif not errorMsg then
		--outputChatBoxR("Command executed!", outputTo)
		exports.discord_staff:send("chat.message.text", { author = sourceName, text = "Command executed!" })
	end
end

function getPlayerFromPartialName(name)
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

function string:monochrome()
    local colorless = self:gsub("#%x%x%x%x%x%x", "")

    if colorless == "" then
        return self:gsub("#(%x%x%x%x%x%x)", "#\1%1")
    else
        return colorless
    end
end

function getPlayerName(player)
    return player.name:monochrome()
end
addEvent("discord_staff.onDiscordUserCommand")
addEventHandler("discord_staff.onDiscordUserCommand", root,
    function (author, message)
		local msg = table.concat(message.params," ")
		
		--AURORA COMMANDS
        if (message.command == "sup") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .sup <message>" })
				return
			end
			triggerEvent("OnEchoSupportChat", root, author.name.."[Điscord]", msg)
			exports.discord_staff:send("chat.message.text", { author = "(SUPPORT)[Điscord]"..author.name, text = msg })
			
			
		elseif (message.command == "occupation") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .occupation <player name>" })
				return
			end
			local player = getPlayerFromPartialName(msg)
			if (player) then
				local occupation = getElementData(player, "Occupation")
				if (occupation) then
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s occupation: "..occupation })
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has no occupation." })
				end
			else 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
			end 
			
		elseif (message.command == "group") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .group <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					local group = getElementData(player, "Group")
					if (group) then
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s group: "..group })
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has no group." })
					end
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end
				
				
		elseif (message.command == "score") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .score <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					local score = getElementData(player, "Score")
					if (score) then
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s score: "..score })
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has no score." })
					end
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end
				
				
		elseif (message.command == "playtime") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .playtime <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					
					local hours = getElementData( player, "playTime" )
					if (hours and hours/60 >= 1) then
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has "..math.floor((hours/60)-0.5).." hours." })

					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has no playtime." })

					end
					
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end
				
		elseif (message.command == "staff") then 
			local admins = {}
			if getResourceState(getResourceFromName("CSGstaff")) == "running" then
				admins = exports.CSGstaff:getOnlineAdmins() or {}
			end
			if #admins > 0 then
				for i=1,#admins do
					admins[i] = getPlayerName(admins[i])
				end
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Online staff: "..table.concat(admins,", ") })
			else
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "No Staff Online." })
			end

		elseif (message.command == "pm") then 
			local name = message.params[1]
			local fmsg = ""
			for i=2, #message.params do
				fmsg = fmsg.." "..message.params[i]
			end 
			if (not name) then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .pm <player name> <message>" })
				return
			end
			if (fmsg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .pm <player name> <message>" })
				return
			end 
			local player = getPlayerFromPartialName(name)
			if (player) then
				outputChatBox("[Điscord] PM from "..author.name..": "..fmsg,player,255,168,0)
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Your pm has been sent to "..getPlayerName(player) })
			else
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player." })
			end
			
			
		elseif (message.command == "ts") then 
			local name = message.params[1]
			local fmsg = ""
			for i=2, #message.params do
				fmsg = fmsg.." "..message.params[i]
			end 
			if (not name) then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ts <team name> <message>" })
				return
			end
			if (fmsg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .pm <team name> <message>" })
				return
			end 
			local team = getTeamFromPartialName(name)
			if (team) then
				for i,player in ipairs (getPlayersInTeam(team)) do
					outputChatBox("[Điscord] Team message from "..author.name..": "..fmsg,player,255,168,0)
				end
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Your team message has been sent to "..getTeamName(team) })
			else
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such team." })
			end
			
		elseif (message.command == "kick") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Supervisor" or dRoles[i] == "Executive Manager" or dRoles[i] == "Supervising Manager"  or dRoles[i] == "Senior Manager" or dRoles[i] == "Manager") then
					local name = message.params[1]
					local fmsg = ""
					for i=2, #message.params do
						fmsg = fmsg.." "..message.params[i]
					end 
					if (not name) then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .kick <player name> <reason>" })
						return
					end
					if (fmsg == "") then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .kick <player name> <reason>" })
						return
					end 
					local player = getPlayerFromPartialName(name)
					if (player) then
						local nick = getPlayerName(player)
						kickPlayer(player,fmsg)
						outputChatBox("[Điscord] "..nick.." was kicked from the game by "..author.name.." ("..fmsg..")",root,255,100,100)
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
				return
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
			
		elseif (message.command == "ban") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Supervisor" or dRoles[i] == "Executive Manager") then
					local name = message.params[1]
					local time = message.params[2]
					local fmsg = ""
					for i=3, #message.params do
						fmsg = fmsg.." "..message.params[i]
					end 
					if (not name) then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ban <player name> <time> <reason>" })
						return
					end
					if (fmsg == "") then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ban <player name> <time> <reason>" })
						return
					end 
					if (time == "") then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ban <player name> <time> <reason>" })
						return
					end
					local player = getPlayerFromPartialName(name)
					if (player) then
						addBan(getPlayerIP(player),nil,getPlayerSerial(player),author.name,fmsg,getTimeFromString(time)/1000)
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
				return
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
			
		elseif (message.command == "mute") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Trial Staff" or dRoles[i] == "Leading Staff" or dRoles[i] == "Supervisor" or dRoles[i] == "Executive Manager" or dRoles[i] == "Supervising Manager"  or dRoles[i] == "Senior Manager" or dRoles[i] == "Manager") then
					local ttype = message.params[1]
					local name = message.params[2]
					local time = message.params[3]
					local fmsg = ""
					for i=4, #message.params do
						fmsg = fmsg.." "..message.params[i]
					end 
					if (not name) then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .mute <global/main/support> <player name> <minutes> <reason>" })
						return
					end
					if (fmsg == "") then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .mute <global/main/support> <player name> <minutes> <reason>" })
						return
					end 
					if (time == "") then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .mute <global/main/support> <player name> <minutes> <reason>" })
						return
					end
					local player = getPlayerFromPartialName(name)
					if (player) then
						--setPlayerMuted(player,true,fmsg,author.name)
						--outputChatBox("[Điscord] "..getPlayerName(player).." has been muted by "..author.name.." ("..fmsg..")",root,255,0,0)
						if (ttype == "main") then 
						exports.discord_staff:send("chat.message.text", { author = "Discord Mute", text = getPlayerName(player).." has been muted by "..author.name..". ("..fmsg..")" })
						exports.CSGadmin:adminMutePlayer(root, player, "[Discord Mute by "..author.name.."] ("..fmsg..")", math.floor(time*60), "Main")
						outputChatBox("[Điscord] "..getPlayerName(player).." has been muted by "..author.name.." ("..fmsg..")",root,255,0,0)
						elseif (ttype == "global") then 
						exports.discord_staff:send("chat.message.text", { author = "Discord Mute", text = getPlayerName(player).." has been globally muted by "..author.name..". ("..fmsg..")" })
						exports.CSGadmin:adminMutePlayer(root, player, "[Discord Mute by "..author.name.."] ("..fmsg..")", math.floor(time*60), "Global")
						outputChatBox("[Điscord] "..getPlayerName(player).." has been globally muted by "..author.name.." ("..fmsg..")",root,255,0,0)
						elseif (ttype == "support") then 
						exports.discord_staff:send("chat.message.text", { author = "Discord Mute", text = getPlayerName(player).." has been muted on support chat by "..author.name..". ("..fmsg..")" })
						exports.CSGadmin:adminMutePlayer(root, player, "[Discord Mute by "..author.name.."] ("..fmsg..")", math.floor(time*60), "Support")
						outputChatBox("[Điscord] "..getPlayerName(player).." has been muted on support channel by "..author.name.." ("..fmsg..")",root,255,0,0)
						else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .mute <global/main/support> <player name> <minutes> <reason>" })
						end
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
				return
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
		
		elseif (message.command == "kill") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Supervisor" or dRoles[i] == "Executive Manager" or dRoles[i] == "Supervising Manager"  or dRoles[i] == "Senior Manager" or dRoles[i] == "Manager") then
					local name = message.params[1]
					local fmsg = ""
					local player = getPlayerFromPartialName(name)
					for i=2, #message.params do
						fmsg = fmsg.." "..message.params[i]
					end 
					if (not name) then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .kill <player name> <reason>" })
						return
					end
					
					if (player) then
						killPed(player)
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." was killed by "..author.name.." ("..fmsg..")" })
						outputChatBox("[Điscord] "..getPlayerName(player).." was killed by "..author.name.." ("..fmsg..")",root,255,0,0)
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
					return 
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
		
		elseif (message.command == "unmute") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Supervisor" or dRoles[i] == "Executive Manager" or dRoles[i] == "Supervising Manager" or dRoles[i] == "Senior Manager" or dRoles[i] == "Manager") then
					local name = message.params[1]
					local player = getPlayerFromPartialName(name)
					if (not name) then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .unmute <player name>" })
						return
					end
					
					if (player) then
						--setPlayerMuted(player,false)
						exports.CSGadmin:adminUnmutePlayer(player, root)
						outputChatBox("[Điscord] "..getPlayerName(player).." was unmuted by "..author.name,root,255,0,0)
						exports.discord_staff:send("chat.message.text", { author = "Discord Mute", text = getPlayerName(player).." has been unmuted by "..author.name.."."})
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
					return 
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
			
		
		elseif (message.command == "uptime") then 			
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Server uptime: "..getTimeString(getTickCount()) })
		
		elseif (message.command == "players") then 			
			if getPlayerCount() == 0 then
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "There are no players in game" })
			else
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "There are "..getPlayerCount().." players in game" })
			end
			
		elseif (message.command == "run") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Server Manager") then
					if (msg == "") then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .run <string>" })
						return
					end
					
					runString(msg,root,"<@"..author.id..">")
					return 
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
	
		
		elseif (message.command == "resources") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Server Manager") then
					
					local resourcesz = getResources()
					local resources = {}
					for i,resource in ipairs (resourcesz) do
						if getResourceState(resource) == "running" then
							resources[i] = " "..getResourceName(resource)..""
						elseif getResourceState(resource) == "failed to load" then
							resources[i] = ""..getResourceName(resource).." ("..getResourceLoadFailureReason(resource)..")"
						else
							resources[i] = ""..getResourceName(resource)..""
						end
					end
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Resources: "..table.concat(resources,", ") })
					
					return 
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
			
		elseif (message.command == "start") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Server Manager") then
					local name = message.params[1]
					if (not name) then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .start <resource name>" })
						return
					end
					local resource = getResourceFromName(name)
					if (resource) then
						if not startResource(resource) then
							exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Failed to start "..getResourceName(resource) })
						else	
							exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Started "..getResourceName(resource) })
						end
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = name.." resource not found" })
					end
					
					return 
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
			
		elseif (message.command == "restart") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Server Manager") then
					local name = message.params[1]
					if (not name) then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .restart <resource name>" })
						return
					end
					local resource = getResourceFromName(name)
					if (resource) then
						if not restartResource(resource) then
							exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Failed to restart "..getResourceName(resource) })
						else	
							exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Restarted "..getResourceName(resource) })
						end
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = name.." resource not found" })
					end
					
					return 
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
			
			
		elseif (message.command == "stop") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Server Manager") then
					local name = message.params[1]
					if (not name) then 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .stop <resource name>" })
						return
					end
					local resource = getResourceFromName(name)
					if (resource) then
						if not stopResource(resource) then
							exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Failed to stop "..getResourceName(resource) })
						else	
							exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Stopped "..getResourceName(resource) })
						end
					else
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = name.." resource not found" })
					end
					
					return 
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
		
		elseif (message.command == "refresh") then 
			local dRoles = author.roles
			
			for i=1, #dRoles do 
				if (dRoles[i] == "Server Manager") then
					
				if refreshResources(false) then
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Refreshing new resources..." })
				end
					
					return 
				end 
			end 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })
		
		elseif (message.command == "money") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .money <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s money: $"..tostring(getPlayerMoney(player)) })
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end
				
		elseif (message.command == "health") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .health <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s health: "..tostring(getPlayerHealth(player)) })
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end
				
				
		elseif (message.command == "team") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .team <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					local team = getPlayerTeam(player)
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s team: "..getTeamName(team) })
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end
			
		elseif (message.command == "ping") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ping <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					if (getElementData(player, "serverlocation") == "SEA") then 
						if (type(getElementData( player, "Ping" )) == "number") then 
							exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s ping: "..getPlayerPing(player)-181 })
						end
					else 
						exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s ping: "..getPlayerPing(player) })
					end 
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end
				
		elseif (message.command == "server") then 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Server: "..tostring(getServerName()).." Port: "..tostring(getServerPort()) })
			
		elseif (message.command == "zone") then 
			if (msg == "") then 
				exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .zone <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					local x,y,z = getElementPosition(player)
					if not x then return end
					local zone = getZoneName(x,y,z,false)
					local city = getZoneName(x,y,z,true)
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s zone: "..zone.." ("..city..")" })
				else
					exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end
	
		elseif (message.command == "cmds") then 
			exports.discord_staff:send("chat.message.text", { author = "<@"..author.id..">", text = "Available commands: .ban .kick .stop .start .refresh .restart .run .unmute .mute .kill .sup .occupation .group .score . playtime .staff .pm .ts .uptime .money .health .team .ping .zone .cmds" })
		
			--END OF AURORA COMMANDS
		end 
    end
)

addEventHandler("onPlayerQuit", root,
    function (quitType, reason, responsible)
        local playerName = getPlayerName(source)
        
        if isElement(responsible) then
            if getElementType(responsible) == "player" then
                responsible = getPlayerName(responsible)
            else
                responsible = "Console"
            end
        else
            responsible = false
        end

        if type(reason) ~= "string" or reason == "" then
            reason = false
        end
        
        if quitType == "Kicked" and responsible then
            exports.discord_staff:send("player.kick", { player = playerName, responsible = responsible, reason = reason })
        elseif quitType == "Banned" and responsible then
            exports.discord_staff:send("player.ban", { player = playerName, responsible = responsible, reason = reason })
        else
            --exports.discord_staff:send("player.quit", { player = playerName, type = quitType, reason = reason })
        end
    end
)

addEvent("discord_staff.onDiscordPacket")
addEventHandler("discord_staff.onDiscordPacket", root,
    function (packet, payload)
        if packet == "text.message" then
            outputServerLog(("DISCORD_STAFF: %s: %s"):format(payload.author.name, payload.message.text))
			exports.CSGstaff:outputStaffChatMessage("[Điscord] "..payload.author.name, payload.message.text)
        elseif packet == "text.command" then
            triggerEvent("discord_staff.onDiscordUserCommand", resourceRoot, payload.author, payload.message)
        end
    end
)

addEventHandler("onPlayerMute", root,
    function (state)
        if state == nil then
            return
        end

        if state then
            exports.discord_staff:send("player.mute", { player = getPlayerName(source) })
        else
            exports.discord_staff:send("player.unmute", { player = getPlayerName(source) })
        end
    end
)

addEventHandler("onResourceStart",root,
	function (resource)
		if getResourceInfo(resource,"type") ~= "map" then
			exports.discord_staff:send("chat.message.text", { author = "Resource Status", text = getResourceName(resource).." started!" })
		end
	end
)

addEventHandler("onResourceStop",root,
	function (resource)
		if getResourceInfo(resource,"type") ~= "map" then
			exports.discord_staff:send("chat.message.text", { author = "Resource Status", text = (getResourceName(resource) or "?").." stopped!" })
		end
	end
)
