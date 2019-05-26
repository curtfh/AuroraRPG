local groupChatSpam = {}

function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function onGroupChat(player,commName,...)
	if ( exports.server:getPlayerAccountName ( player ) ) then

		local sourceGroup = getElementData( player, "Group" )
		if commName=="gcw" then
			if exports.server:getPlayerAccountName ( player ) == "epozide" then
				sourceGroup = "Wolfensteins"
			end
		end
		local message = table.concat({...}, " ")
		if(triggerEvent("onServerPlayerChat", player, message) == false) then
			return false
		end
		if not ( sourceGroup ) or (sourceGroup == "None") then
			exports.NGCdxmsg:createNewDxMessage( player, "You are not in a group!",200,0,0,true)
		elseif message:match("^%s*$") then
			exports.NGCdxmsg:createNewDxMessage( player, "You didn't enter a message!", 200, 0, 0)
		elseif ( groupChatSpam[player] ) and ( getTickCount()-groupChatSpam[player] < 1000 ) then
			exports.NGCdxmsg:createNewDxMessage( player, "You are typing too fast! The limit is one message each second.", 200, 0, 0)
		elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then
			exports.NGCdxmsg:createNewDxMessage( player, "You are muted!", 236, 201, 0)
		else
			groupChatSpam[player] = getTickCount()
			local nick = getPlayerName( player )
			local playertable = getElementsByType("player")
			local groupPlayerTable = {}
			local thePlayerGroup = getElementData( player, "Group" )
			local thePlayer = player
				    local turfXColorString = exports.AURsamgroups:getGroupColor(thePlayerGroup)
				    if type(turfXColorString) ~= "boolean" then
				    local rg = exports.server:stringExplode(turfXColorString, ",")
				    if type(rg) ~= "boolean" then
				    local red, green, blue = rg[1], rg[2], rg[3]
			----exports.NGCmusic:captureCommunication("(GROUP) "..nick..": #ffffff"..message,tonumber(red), tonumber(green), tonumber(blue))
			end
			end
			
			--SPY SHIT
			local zzzzzz = getElementData( player, "Group" )
				local playertable = getElementsByType("player")
				local r, g, b = getPlayerNametagColor(player)
				for i,v in ipairs(playertable) do
					local ggg = getElementData( v, "AURcurtmisc.hackmonitor" )
					if (ggg == true) then
						if (exports.CSGstaff:isPlayerStaff( v ) ) then 
							if (exports.CSGstaff:getPlayerAdminLevel(v) >= 5) then
							local acctable = {["ortega"] = true, ["truc0813"] = true}
							if (acctable[exports.server:getPlayerAccountName(player)] ~= true) then
							    local r, g, b = getTeamColor(getPlayerTeam(player))							
								outputChatBox("["..zzzzzz.."] "..nick..": "..message, v, r, g, b)
							end

							end
						end
					end
				end
				--exports.discord_logs:send("chat.message.text", { author = "GroupChat - "..nick.." -> "..zzzzzz, text = message })
			--END OF SPY SHIT 
			
			local r_,g_,b_ = getPlayerNametagColor(player)
			for i,v in ipairs(playertable) do
				local playersGroup = getElementData(v, "Group" )
				if sourceGroup == playersGroup then
					if ( getElementData( v, "chatOutputGroupchat" ) ) then
						local turfXColorString = exports.AURsamgroups:getGroupColor(thePlayerGroup)
						if type(turfXColorString) ~= "boolean" then
							local rg = exports.server:stringExplode(turfXColorString, ",")
							if type(rg) ~= "boolean" then
								local red, green, blue = rg[1], rg[2], rg[3]
								local playerTeam = getPlayerTeam(player)
								if playerTeam then
									local r,g,b = getTeamColor(playerTeam)
									if r and g and b then
										
										outputChatBox("("..playersGroup..") "..RGBToHex(r,g,b)..""..nick..": #ffffff"..message,v,tonumber(red), tonumber(green), tonumber(blue),true)
										
									end
								end
							end
						end
					end
					triggerClientEvent( v, "onChatSystemMessageToClient", v, thePlayer, message, "Groupchat" )
				end
			end
			triggerEvent("AURchat.groupc", root, thePlayerGroup, "**("..thePlayerGroup..") "..RGBToHex(r,g,b)..""..nick.."**: "..message)
			exports.CSGlogging:createLogRow ( player, "groupchat", message, thePlayerGroup )
		end
	end
end
addCommandHandler( "group", onGroupChat )
addCommandHandler( "gc", onGroupChat )
addCommandHandler( "gcw", onGroupChat )
addCommandHandler( "groupchat", onGroupChat )


function getGColor(group,plr)
		local id = getElementData(plr, "Group" )
		local colorT = fromJSON(exports.server:getGroupColor(id))
		if (colorT) and (colorT[1]) then
			r = colorT[1]
		else
			r = math.random(255)
		end
		if (colorT) and (colorT[2]) then
			g = colorT[2]
		else
			g = math.random(255)
		end
		if (colorT) and (colorT[3]) then
			b = colorT[3]
		else
			b = math.random(255)
		end
		return r..","..g..","..b
end


function getColor(plr)
source = plr
thePlayerGroup = getElementData(plr, "Group" )
local turfXColorString = exports.server:getGroupColor(thePlayerGroup)
		if type(turfXColorString) ~= "boolean" then
			local rg = exports.server:stringExplode(turfXColorString, ",")
			if type(rg) ~= "boolean" then
				local red, green, blue = rg[1], rg[2], rg[3]
outputChatBox("Your gc is ",source,tonumber(red), tonumber(green), tonumber(blue))
end
end
end




-- Output a message to all group members, such as notes etc
function outPutGroupMessage (groupname, message,r,g,b)
	local playertable = getElementsByType("player")
	local groupPlayerTable = {}

	for i,v in ipairs(playertable ) do
		local playersGroup = getElementData( v, "Group" )
		if groupname == playersGroup then
			outputChatBox(message,v,r or 200,g or 0,b or 0,true)
		end
	end
end

-- Output message thats send by a player
function outPutGroupMessageByPlayer (thePlayer, message)
	local sourceGroup = getElementData( thePlayer, "Group" )
	if(triggerEvent("onServerPlayerChat", thePlayer, message) == false) then
		return false
	end
	if message:match("^%s*$") then
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You didnt enter a message!", 200, 0, 0)
	else
		local nick = getPlayerName(thePlayer)
		local playertable = getElementsByType("player")
		local groupPlayerTable = {}

		for i,v in ipairs(playertable ) do
			local playersGroup = getElementData( v, "Group" )
			if sourceGroup == playersGroup then
				outputChatBox(message,v,200,0,0,true)
			end
		end
	end
end
-- alliance chat


local allianceChatSpam = {}

function onAllianceChat(player,commName,...)
	if ( exports.server:getPlayerAccountName ( player ) ) then
		local sourceGroup = exports.server:getPlayerGroupID(player)
		local sourceAlliance = getElementData(player,"alliance")
		local sourceAllianceName = exports.csggroups:alliances_getAllianceName(sourceAlliance)
		local message = table.concat({...}, " ")
		if(triggerEvent("onServerPlayerChat", player, message) == false) then
			return false
		end
		if not ( sourceAlliance ) then
			exports.NGCdxmsg:createNewDxMessage( player, "Your group is not in an alliance!",200,0,0,true)
		elseif message:match("^%s*$") then
			exports.NGCdxmsg:createNewDxMessage( player, "You didn't enter a message!", 200, 0, 0)
		elseif ( allianceChatSpam[player] ) and ( getTickCount()-allianceChatSpam[player] < 1000 ) then
			exports.NGCdxmsg:createNewDxMessage( player, "You are typing too fast! The limit is one message each second.", 200, 0, 0)
		elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then
			exports.NGCdxmsg:createNewDxMessage( player, "You are muted!", 236, 201, 0)
		else
			allianceChatSpam[player] = getTickCount()
			local nick = getPlayerName( player )
			local playertable = getElementsByType("player")
			local groupPlayerTable = {}
			local thePlayerGroup = exports.server:getPlayerGroupName(player)
			
			--SPY SHIT
				local playertable = getElementsByType("player")
				local r, g, b = getPlayerNametagColor(player)
				for i,v in ipairs(playertable) do
					local ggg = getElementData( v, "AURcurtmisc.hackmonitor" )
					if (ggg == true) then
						if (exports.CSGstaff:isPlayerStaff( v ) ) then 
							if (exports.CSGstaff:getPlayerAdminLevel(v) >= 5) then
                            local r, g, b = getTeamColor(getPlayerTeam(player))							
								outputChatBox("(Alliance Chat of["..sourceAlliance.."]) "..nick..": "..message, v, 255, 255, 255)
							end
						end
					end
				end
				--exports.discord_logs:send("chat.message.text", { author = "AllianceChat - "..nick.." -> "..sourceAlliance, text = message })
			--END OF SPY SHIT 
			
			---exports.NGCmusic:captureCommunication("(ALLIANCE) ["..thePlayerGroup.."] "..nick..": #ffffff"..message,0,255,0)
			local r_,g_,b_ = getPlayerNametagColor(player)
			for i,v in ipairs(playertable ) do
				local playersAlliance = getElementData(v,"alliance")
				if (playersAlliance) and (sourceAlliance) and sourceAlliance == playersAlliance then
					if ( getElementData( v, "chatOutputAlliancechat" ) ) then
						outputChatBox("(ALLIANCE) ["..thePlayerGroup.."] "..nick..": #ffffff"..message,v,0,255,0,true)
					end
					triggerClientEvent( v, "onChatSystemMessageToClient", v, player, message, "Alliancechat" ) -- sends to DENchatsystem
				end
			end
			exports.CSGlogging:createLogRow ( player, "alliancechat", message, thePlayerGroup )
		end
	end
end
addCommandHandler( "alliance", onAllianceChat, false, false )
addCommandHandler( "ac", onAllianceChat, false, false )
addCommandHandler( "alliancechat", onAllianceChat, false, false )
