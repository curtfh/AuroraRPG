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
addEvent("onDiscordUserCommand")
addEventHandler("onDiscordUserCommand", root,
    function (author, message)
		local msg = table.concat(message.params," ")

		--AURORA COMMANDS
        if (message.command == "sup") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .sup <message>" })
				return
			end
			triggerEvent("OnEchoSupportChat", root, author.name.."[Điscord]", msg)
			exports.discord:send("chat.message.text", { author = "(SUPPORT)[Điscord]"..author.name, text = msg })


		elseif (message.command == "occupation") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .occupation <player name>" })
				return
			end
			local player = getPlayerFromPartialName(msg)
			if (player) then
				local occupation = getElementData(player, "Occupation")
				if (occupation) then
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s occupation: "..occupation })
				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has no occupation." })
				end
			else
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
			end

		elseif (message.command == "group") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .group <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					local group = getElementData(player, "Group")
					if (group) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s group: "..group })
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has no group." })
					end
				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end


		elseif (message.command == "score") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .score <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					local score = getElementData(player, "Score")
					if (score) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s score: "..score })
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has no score." })
					end
				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end


		elseif (message.command == "playtime") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .playtime <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then

					local hours = getElementData( player, "playTime" )
					if (hours and hours/60 >= 1) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has "..math.floor((hours/60)-0.5).." hours." })

					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." has no playtime." })

					end

				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
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
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Online staff: "..table.concat(admins,", ") })
			else
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "No Staff Online." })
			end

		elseif (message.command == "pm") then
			local name = message.params[1]
			local fmsg = ""
			for i=2, #message.params do
				fmsg = fmsg.." "..message.params[i]
			end
			if (not name) then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .pm <player name> <message>" })
				return
			end
			if (fmsg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .pm <player name> <message>" })
				return
			end
			local player = getPlayerFromPartialName(name)
			if (player) then
				outputChatBox("[Điscord] PM from "..author.name..": "..fmsg,player,255,168,0)
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Your pm has been sent to "..getPlayerName(player) })
				setElementData(player, "AURdiscord.lastPM", "<@"..author.id..">")
			else
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player." })
			end


		elseif (message.command == "ts") then
			local name = message.params[1]
			local fmsg = ""
			for i=2, #message.params do
				fmsg = fmsg.." "..message.params[i]
			end
			if (not name) then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ts <team name> <message>" })
				return
			end
			if (fmsg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .pm <team name> <message>" })
				return
			end
			local team = getTeamFromPartialName(name)
			if (team) then
				for i,player in ipairs (getPlayersInTeam(team)) do
					outputChatBox("[Điscord] Team message from "..author.name..": "..fmsg,player,255,168,0)
				end
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Your team message has been sent to "..getTeamName(team) })
			else
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such team." })
			end

		elseif (message.command == "kick") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Executive Staff" or dRoles[i] == "Expert Staff" or dRoles[i] == "Loyal Staff") then
					local name = message.params[1]
					local fmsg = ""
					for i=2, #message.params do
						fmsg = fmsg.." "..message.params[i]
					end
					if (not name) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .kick <player name> <reason>" })
						return
					end
					if (fmsg == "") then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .kick <player name> <reason>" })
						return
					end
					local player = getPlayerFromPartialName(name)
					if (player) then
						local nick = getPlayerName(player)
						kickPlayer(player,fmsg)
						outputChatBox("[Điscord] "..nick.." was kicked from the game by "..author.name.." ("..fmsg..")",root,255,100,100)
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
				return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "ban") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Executive Staff" or dRoles[i] == "Expert Staff") then
					local name = message.params[1]
					local time = message.params[2]
					local fmsg = ""
					for i=3, #message.params do
						fmsg = fmsg.." "..message.params[i]
					end
					if (not name) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ban <player name> <time> <reason>" })
						return
					end
					if (fmsg == "") then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ban <player name> <time> <reason>" })
						return
					end
					if (time == "") then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ban <player name> <time> <reason>" })
						return
					end
					local player = getPlayerFromPartialName(name)
					if (player) then
						addBan(getPlayerIP(player),nil,getPlayerSerial(player),author.name,fmsg,getTimeFromString(time)/1000)
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
				return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "mute") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Executive Staff" or dRoles[i] == "Expert Staff" or dRoles[i] == "Loyal Staff") then
					local name = message.params[1]
					local time = message.params[2]
					local fmsg = ""
					for i=3, #message.params do
						fmsg = fmsg.." "..message.params[i]
					end
					if (not name) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .mute <player name> <time> <reason>" })
						return
					end
					if (fmsg == "") then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .mute <player name> <time> <reason>" })
						return
					end
					if (time == "") then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .mute <player name> <time> <reason>" })
						return
					end
					local player = getPlayerFromPartialName(name)
					if (player) then
						setPlayerMuted(player,true,fmsg,author.name)
						outputChatBox("[Điscord] "..getPlayerName(player).." has been muted by "..author.name.." ("..fmsg..")",root,255,0,0)
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
				return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "kill") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Executive Staff" or dRoles[i] == "Expert Staff" or dRoles[i] == "Loyal Staff") then
					local name = message.params[1]
					local fmsg = ""
					local player = getPlayerFromPartialName(name)
					for i=2, #message.params do
						fmsg = fmsg.." "..message.params[i]
					end
					if (not name) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .kill <player name> <reason>" })
						return
					end

					if (player) then
						killPed(player)
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).." was killed by "..author.name.." ("..fmsg..")" })
						outputChatBox("[Điscord] "..getPlayerName(player).." was killed by "..author.name.." ("..fmsg..")",root,255,0,0)
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "unmute") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff" or dRoles[i] == "Executive Staff" or dRoles[i] == "Expert Staff" or dRoles[i] == "Loyal Staff") then
					local name = message.params[1]
					local player = getPlayerFromPartialName(name)
					if (not name) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .unmute <player name>" })
						return
					end

					if (player) then
						setPlayerMuted(player,false)
						outputChatBox("[Điscord] "..getPlayerName(player).." was unmuted by "..author.name,root,255,0,0)
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..name.."' no such player. " })
					end
					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })


		elseif (message.command == "uptime") then
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Server uptime: "..getTimeString(getTickCount()) })

		elseif (message.command == "players") then
			if getPlayerCount() == 0 then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "There are no players in game" })
			else
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "There are "..getPlayerCount().." players in game" })
			end

		elseif (message.command == "run") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff") then
					if (not msg) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .run <string>" })
						return
					end

					runString(msg,root,author.name)
					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })


    elseif (message.command == "lockdown") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff") then
					if (not msg) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .run <string>" })
						return
					end
          setServerPassword("proaurora")
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Server is now on locked down! Password set." })
					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "resources") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff") then

					local resources = getResources()
					for i,resource in ipairs (resources) do
						if getResourceState(resource) == "running" then
							resources[i] = " "..getResourceName(resource)..""
						elseif getResourceState(resource) == "failed to load" then
							resources[i] = ""..getResourceName(resource).." ("..getResourceLoadFailureReason(resource)..")"
						else
							resources[i] = ""..getResourceName(resource)..""
						end
					end
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Resources: "..table.concat(resources,", ") })

					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "start") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff") then
					local name = message.params[1]
					if (not name) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .start <resource name>" })
						return
					end
					local resource = getResourceFromName(name)
					if (resource) then
						if not startResource(resource) then
							exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Failed to start "..getResourceName(resource) })
						else
							exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Started "..getResourceName(resource) })
						end
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = name.." resource not found" })
					end

					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "restart") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff") then
					local name = message.params[1]
					if (not name) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .restart <resource name>" })
						return
					end
					local resource = getResourceFromName(name)
					if (resource) then
						if not restartResource(resource) then
							exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Failed to restart "..getResourceName(resource) })
						else
							exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Restarted "..getResourceName(resource) })
						end
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = name.." resource not found" })
					end

					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })


		elseif (message.command == "stop") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff") then
					local name = message.params[1]
					if (not name) then
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .stop <resource name>" })
						return
					end
					local resource = getResourceFromName(name)
					if (resource) then
						if not stopResource(resource) then
							exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Failed to stop "..getResourceName(resource) })
						else
							exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Stopped "..getResourceName(resource) })
						end
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = name.." resource not found" })
					end

					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "refresh") then
			local dRoles = author.roles

			for i=1, #dRoles do
				if (dRoles[i] == "Leading Staff") then

				if refreshResources(false) then
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Refreshing new resources..." })
				end

					return
				end
			end
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Access is denied" })

		elseif (message.command == "money") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .money <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s money: $"..tostring(getPlayerMoney(player)) })
				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end

		elseif (message.command == "health") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .health <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s health: "..tostring(getPlayerHealth(player)) })
				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end


		elseif (message.command == "team") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .team <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					local team = getPlayerTeam(player)
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s team: "..getTeamName(team) })
				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end

		elseif (message.command == "ping") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .ping <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					if (getElementData(player, "serverlocation") == "SEA") then
						if (type(getElementData( player, "Ping" )) == "number") then
							exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s ping: "..getPlayerPing(player)-181 })
						end
					else
						exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s ping: "..getPlayerPing(player) })
					end
				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end

		elseif (message.command == "server") then
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Server: "..tostring(getServerName()).." Port: "..tostring(getServerPort()) })

		elseif (message.command == "zone") then
			if (msg == "") then
				exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Syntax is .zone <player name>" })
				return
			end
				local player = getPlayerFromPartialName(msg)
				if (player) then
					local x,y,z = getElementPosition(player)
					if not x then return end
					local zone = getZoneName(x,y,z,false)
					local city = getZoneName(x,y,z,true)
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = getPlayerName(player).."'s zone: "..zone.." ("..city..")" })
				else
					exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "'"..msg.."' no such player." })
				end

		elseif (message.command == "cmds") then
			exports.discord:send("chat.message.text", { author = "<@"..author.id..">", text = "Available commands: .sup .occupation .group .score . playtime .staff .pm .ts .uptime .money .health .team .ping .zone .cmds" })

			--END OF AURORA COMMANDS
		end
    end
)

addEventHandler("onPlayerJoin", root,
    function ()
        exports.discord:send("chat.message.text", { author = "Server", text = ":inbox_tray: "..getPlayerName(source).." has joined ("..getPlayerCount().."/"..getMaxPlayers()..")" })
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
            exports.discord:send("chat.message.text", { author = "Server", text = ":boot: "..getPlayerName(source).." has been kicked by "..responsible.." ["..reason.."] ("..getPlayerCount().."/"..getMaxPlayers()..")" })
        elseif quitType == "Banned" and responsible then
            exports.discord:send("chat.message.text", { author = "Server", text = ":bangbang: "..getPlayerName(source).." has been banned by "..responsible.." ["..reason.."] ("..getPlayerCount().."/"..getMaxPlayers()..")" })
        else
            exports.discord:send("chat.message.text", { author = "Server", text = ":door: "..getPlayerName(source).." has left ["..quitType.."] ("..getPlayerCount().."/"..getMaxPlayers()..")" })
        end
    end
)

addEventHandler("onPlayerChangeNick", root,
    function (previous, nick)
        exports.discord:send("player.nickchange", { player = nick:monochrome(), previous = previous:monochrome() })
    end
)

addEventHandler("onPlayerChat", root,
    function (message, messageType)
        if messageType == 0 then
            exports.discord:send("chat.message.text", { author = "("..exports.server:getPlayChatZone(source)..") "..getPlayerName(source), text = message })
        elseif messageType == 1 then
            exports.discord:send("chat.message.action", { author = getPlayerName(source), text = message })
        end
    end
)

addEvent("onInterchatMessage")
addEventHandler("onInterchatMessage", root,
    function (server, playerName, message)
        exports.discord:send("chat.message.interchat", { author = playerName:monochrome(), server = server, text = message })
    end
)

addEvent("onDiscordPacket")
addEventHandler("onDiscordPacket", root,
    function (packet, payload)
        if packet == "text.message" then
            outputServerLog(("DISCORD: %s: %s"):format(payload.author.name, payload.message.text))
            outputChatBox(("#69BFDB[Điscord] #FFFFFF%s: #ffffff%s"):format(payload.author.name, payload.message.text), root, 255, 255, 255, true)
            --exports.discord:send("chat.confirm.message", { author = payload.author.name, message = payload.message })
        elseif packet == "text.command" then
            triggerEvent("onDiscordUserCommand", resourceRoot, payload.author, payload.message)
        end
    end
)

addEventHandler("onPlayerMute", root,
    function (state)
        if state == nil then
            return
        end

        if state then
            exports.discord:send("player.mute", { player = getPlayerName(source) })
        else
            exports.discord:send("player.unmute", { player = getPlayerName(source) })
        end
    end
)
local timers = {}
function sendRePM (player, cmd, ...)
	local msg = table.concat({...}, " ")

	if (isTimer(timers[player])) then return end
	if (type(getElementData(player, "AURdiscord.lastPM")) ~= "string") then
		outputChatBox("No one in discord messaged you.", player, 255, 0, 0)
		return
	end
	if (msg == nil or msg == "" or msg == " ") then
		outputChatBox("Syntax: /dre <message>", player, 255, 0, 0)
		return
	end

	exports.discord:send("chat.message.text", { author = "[REPLY FROM "..getPlayerName(player).." TO "..getElementData(player, "AURdiscord.lastPM").."]", text = msg })
	outputChatBox("Your reply has been sent on discord!", player, 0, 255, 0)
	timers[player] = setTimer(function()
		if (isElement(timers[players])) then
			killTimer(timers[players])
		end
	end, 1000, 1)
end
addCommandHandler("dre", sendRePM)
