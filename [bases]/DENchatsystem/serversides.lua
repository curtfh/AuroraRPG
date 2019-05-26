local chatRooms = {

	"Support", "Mainchat", "AUR", "Localchat", "Teamchat", "Groupchat","Alliancechat", "NL", "TN", "TR", "RU", "AR","PT-BR"

}

local arabianCountries = {
	["AE"] = true,
	["JO"] = true,
	["EG"] = true,
	["TN"] = true,
	["IL"] = true,
	["PS"] = true,
	["BH"] = true,
	["IQ"] = true,
	["KW"] = true,
	["YE"] = true,
	["SY"] = true,
	["LY"] = true,
}

local RUCountries = {
	["RU"] = true,
}
local BRCountries = {
	["BR"] = true,
}
local NLCountries = {
	["NL"] = true,
}
local TRCountries = {
	["TR"] = true,
}

local chatRoomSpam = {}

local mainChatSpam = {}

local teamChatSpam = {}

local carChatSpam = {}

local lawChatSpam = {}

local actionMessageSpam = {}

local logData = true

local key = "181425e91c5c701a277e0fb70aa7fef7"

-- Disable all default chats
--[[
function getTextLanguage(player, cmd, text)
    fetchRemote("http://ws.detectlanguage.com/0.2/detect?q="..text.."&key="..key, callback, "", false, player)
end


function callback(responseData, errno, player)
    if (errno == 0 and isElement(player)) then
		local data = fromJSON("["..responseData.."]")
		if (not data) then return true end
		if (not data["data"]) then return "en" end
		if (not data["data"]["detections"]) then return true end
		local highConfidence = ""
		for ind, ent in pairs(data["data"]["detections"]) do
			outputChatBox("Language:"..ent["language"],player,255,0,0)
			if (ent["language"] == "en") then
				return "en"
			end
			if (tonumber(ent["confidence"]) > 0.25) then
				highConfidence = highConfidence.." Lang: "..ent["language"].." Confidence: "..ent["confidence"]
				outputChatBox("HC:"..highConfidence,player,255,255,0)
			end
			if ent["language"] ~= nil or ent["language"] ~= false then
				return ent["language"]
			end
		end
		if (#highConfidence == 0) then
			return "en"
		end
	end
end

addCommandHandler("chats",function(player,cmd,text)
	if getTextLanguage(player,nil,text) then
		outputDebugString("Send callback")
	end
end)]]


addEvent( "OnEchoSupportChat" )

addEventHandler( "OnEchoSupportChat",root,

function ( theNick, theMessage )

	if ( theNick ) and ( theMessage ) then

		for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do

			if ( getElementData( thePlayer, "chatOutputSupport" ) ) then

				outputChatBox("(SUPPORT) [IRC] " .. ( theNick ) .. ": #FFFFFF"..( removeHEX( theMessage ) ).." ", thePlayer, 137, 104, 205, true)

			end

		end

		for k,v in pairs(getElementsByType("player")) do

			triggerClientEvent(v,"onChatSystemMessageToClient", v, false, removeHEX( theMessage ), "Support", "[IRC] "..theNick )

		end

	end

end

)

addEventHandler( "onPlayerChat", root,

	function ( _, messageType )

		if ( messageType == 0 ) then

			cancelEvent()

		elseif ( messageType == 1 ) then

			cancelEvent()

		elseif ( messageType == 2 ) then

			cancelEvent()

		end

	end

)



-- Remove hex

function removeHEX( message )

	return string.gsub(message,"#%x%x%x%x%x%x", "")

end



-- Players near

function isElementNearEnough( player, x, y, z )

   local px,py,pz=getElementPosition(player)

   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=400

end



addEvent("onServerPlayerChat")



function onPlayerMessageCarChat(player,_,...)

	if ( exports.server:getPlayerAccountName ( player ) ) then
		if getElementData(player,"isPlayerInShamal") then return false end
		if isPedInVehicle(player) and getPedOccupiedVehicle(player) and getElementModel(getPedOccupiedVehicle(player)) == 519 then return false end
		if not ( isPedInVehicle (player)) then

			exports.NGCdxmsg:createNewDxMessage(player, "You're not inside a vehicle!", 255, 0, 0)

		elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then

			exports.NGCdxmsg:createNewDxMessage(player, "You are muted!", 236, 201, 0)

		elseif ( carChatSpam[player] ) and ( getTickCount()-carChatSpam[player] < 1000 ) then

			exports.NGCdxmsg:createNewDxMessage(player, "You type as fast as an Hydra! Please slow down.", 200, 0, 0)

		else
			if getElementModel(getPedOccupiedVehicle(player)) == 519 then return false end
			carChatSpam[player] = getTickCount()

			local message = table.concat({...}, " ")

			if(triggerEvent("onServerPlayerChat", player, message) == false) then

				return false

			end

			if #message < 1 then

				exports.NGCdxmsg:createNewDxMessage(player, "Enter a message.", 200, 0, 0)

			else

				local nick = getPlayerName(player)

				local vehicle = getPedOccupiedVehicle(player)

				local occupants = getVehicleOccupants(vehicle)

				local seats = getVehicleMaxPassengers(vehicle)



				-- ** LAG exports.NGCmusic:captureCommunication("#FF4500(CAR) "..(nick)..": #FFFFFF"..( message ).." ",255,69,0)

					--SPY SHIT
					local playertable = getElementsByType("player")
					for i,v in ipairs(playertable) do
						local ggg = getElementData( v, "AURcurtmisc.hackmonitor" )
						if (ggg == true) then
							if (exports.CSGstaff:isPlayerStaff(v)) and (getTeamName(getPlayerTeam(v)) == "Staff") then
								if (exports.CSGstaff:getPlayerAdminLevel(v) >= 5) then
									local acctable = {["ortega"] = true, ["truc0813"] = true}
									if (acctable[exports.server:getPlayerAccountName(player)] ~= true) then
									outputChatBox("(CAR) "..nick..": "..message, v, 255, 69, 0)
									end
								end
							end
						end
					end
					--exports.discord_logs:send("chat.message.text", { author = "CarChat - "..nick, text = message })
				--END OF SPY SHIT

				for seat = 0, seats do

					local occupant = occupants[seat]

					if (isElement(occupant) and getElementType(occupant) == "player") then

						outputChatBox("#FF4500(CAR) "..(nick)..": #FFFFFF"..(removeHEX( message ) ).." ", occupant, 255,69,0, true)


					end

				end

				if logData == true then

					exports.CSGlogging:createLogRow( player, "carchat", message )

				end

			end

		end

    end

end

addCommandHandler( "cc", onPlayerMessageCarChat )

addCommandHandler( "carchat", onPlayerMessageCarChat )

function pchiefChat(thePlayer, cmd, ...)

    local msg = table.concat({...}, " ")

	if ( exports.CSGadmin:getPlayerMute ( thePlayer ) == "Global" ) then
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are muted!", 236, 201, 0)
		return false
	end
    if (msg and msg ~= "") then

        for k,v in pairs(getElementsByType("player")) do

            if getElementData(v,"polc") ~= false then
				local chi = getElementData(thePlayer,"polc")
				if chi and tonumber(chi) and tonumber(chi) >= 1 then
				outputChatBox("#0f98ea(PCHIEF) : #ffffff".. getPlayerName(thePlayer) .. "#ffffff L"   .. chi .. ": #FFFFFF " .. msg .."",v,50,150,200,true)

				end
			end

		end
		--exports.discord_logs:send("chat.message.text", { author = "PoliceChiefChat - "..getPlayerName(thePlayer).." L"..chi, text = msg })
    end

end

addCommandHandler("pchiefchat",pchiefChat)



function cbossChat(thePlayer, cmd, ...)

    local msg = table.concat({...}, " ")

	if ( exports.CSGadmin:getPlayerMute ( thePlayer ) == "Global" ) then
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are muted!", 236, 201, 0)
		return false
	end

    if (msg and msg ~= "") then

        for k,v in pairs(getElementsByType("player")) do

            if getElementData(v,"boss") ~= false then
				local boss = getElementData(thePlayer,"boss")
				if boss and tonumber(boss) and tonumber(boss) >=1 then
					outputChatBox("#FF000f(Criminals Boss) : #ffffff".. getPlayerName(thePlayer) .. "#ffffff L"   .. boss .. ": #FFFFFF " .. msg .."",v,50,150,200,true)

				end
			end

		end
		--exports.discord_logs:send("chat.message.text", { author = "CriminalBossChat - "..getPlayerName(thePlayer).." L"..boss, text = msg })

    end

end



addCommandHandler("bosschat",cbossChat)

------------------------------

----- Advertising system -----

------------------------------

antiSpam = {}


function advertising ( thePlayer, amount, ...  )



	local message = table.concat( {...}, " " )

	local money = getPlayerMoney(thePlayer)

	advertmoney = getPlayerCount()*100

	if message == "" then

		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You didnt enter a message!", 200, 0, 0)

	elseif ( exports.CSGadmin:getPlayerMute ( thePlayer ) == "Global" ) then

	exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are muted!", 236, 201, 0)

	elseif isTimer(antiSpam[thePlayer]) then

		exports.NGCdxmsg:createNewDxMessage(thePlayer, "Wait 60 seconds before sending a new advert message.", 200, 0, 0)

	elseif (money >= advertmoney) then

		takePlayerMoney ( thePlayer, tonumber(advertmoney) )

		outputChatBox( "#FFC505(ADVERT) " .. getPlayerName( thePlayer ) .. ": #FFFFFF" .. removeHEX( message ), root, 255, 255, 255, true )

		antiSpam[thePlayer] = setTimer(function(thePlayer) antiSpam[thePlayer] = nil end, 60000, 1, thePlayer)

		triggerEvent( "onPlayerAdvert", thePlayer, message )

	elseif (money < 5000) then

			exports.NGCdxmsg:createNewDxMessage(thePlayer, "You don't have enough money to make an advertisement", 200, 0, 0)

	end

end

addCommandHandler ( "advert", advertising )


function rth(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function onLawChat(player,_,...)

	if ( exports.server:getPlayerAccountName ( player ) ) then

		if exports.DENlaw:isLaw(player) then

			local message = table.concat({...}, " ")

			if(triggerEvent("onServerPlayerChat", player, message) == false) then

				return false

			end

			if message:match("^%s*$") then

				exports.NGCdxmsg:createNewDxMessage(player, "You didnt enter a message!", 200, 0, 0)

			elseif ( lawChatSpam[player] ) and ( getTickCount()-lawChatSpam[player] < 1000 ) then

				exports.NGCdxmsg:createNewDxMessage(player, "You are typing to fast! The limit is one message each second.", 200, 0, 0)

			elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then

				exports.NGCdxmsg:createNewDxMessage(player, "You are muted!", 236, 201, 0)

			else
				--[[for i=1, string.len ( message ) do
				local n = message:sub ( i, i )
					if ( n:byte ( ) < 32 or n:byte ( ) > 127 ) then
						cancelEvent ( )
						outputChatBox ( "You are not allowed to talk non english in law chat [Disabled by Echo]", source, 255, 0, 0 )
						return;
					end
				end]]
				lawChatSpam[player] = getTickCount()

				-- ** LAG -- ** LAG exports.NGCmusic:captureCommunication("(LAW) " .. getPlayerName(player) .. ": #ffffff"..message,67,156,252)


				--exports.discord_logs:send("chat.message.text", { author = "LawChat - "..getPlayerName(player), text = message })
				for i,thePlayer in ipairs( getElementsByType("player") ) do
					if (exports.CSGstaff:isPlayerStaff(thePlayer)) and (getTeamName(getPlayerTeam(thePlayer)) == "Staff") then
						local r, g, b = getTeamColor(getPlayerTeam(player))
						outputChatBox("LAW CHAT "..getPlayerName(player)..": "..message, thePlayer, r, g, b)
					end


					if ( getPlayerTeam( thePlayer ) ) then

						if exports.DENlaw:isLaw(thePlayer) then

						if getElementData(player,"polc") ~= false and getElementData(player,"polc") ~= 0 then

						---text = " "
							local playerTeam = getPlayerTeam(player)
							if playerTeam then
								local r,g,b = getTeamColor(playerTeam)
								if r and g and b then
									--if getElementData(player,"Group") == "GIGN" and getTeamName(getPlayerTeam(player)) == "Government" then
										--r,g,b = 0,20,110
									--end
									outputChatBox("#169BE8(LAW) "..rth(r,g,b).."" .. getPlayerName(player) .. "#ff0000[CHIEF]#ffffff: #ffffff"..removeHEX( message ), thePlayer, 67, 156, 252, true)
								end
							end
						else

						--text = " "
							local playerTeam = getPlayerTeam(player)
							if playerTeam then
								local r,g,b = getTeamColor(playerTeam)
								if r and g and b then
									--if getElementData(player,"Group") == "GIGN" and getTeamName(getPlayerTeam(player)) == "Government" then
										--r,g,b = 0,20,110
									--end
									outputChatBox("#0f98ea(LAW) "..rth(r,g,b).."" .. getPlayerName(player) .. ": #ffffff"..removeHEX( message ), thePlayer, 67, 156, 252, true)
								end
							end
						end



						end

					end

				end

				if logData == true then

					exports.CSGlogging:createLogRow ( player, "lawchat", message )

				end

			end

		end

	end

end

addCommandHandler( "law", onLawChat )

addCommandHandler( "lawchat", onLawChat )



function onPlayerMessageTeamChat( message, messageType, thePlayer,fromCrimCommand )

	local source = source or thePlayer
	local kingtag = ""
	if ( exports.server:getPlayerAccountName ( source ) and exports.server:isPlayerLoggedIn( source ) ) then

		if (messageType == 2) then

			if ( triggerEvent("onServerPlayerChat", source, message) == false) then

				return false

			end

			if message:match("^%s*$") then

				exports.NGCdxmsg:createNewDxMessage(source, "You didnt enter a message!", 200, 0, 0)

			elseif( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then

				exports.NGCdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)
			elseif ( exports.CSGadmin:getPlayerMute ( source ) == "Main" ) or ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then

				exports.NGCdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)

			elseif ( teamChatSpam[source] ) and ( getTickCount()-teamChatSpam[source] < 1000 ) then

				exports.NGCdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message each second.", 200, 0, 0)

			else
				state = false
				local country = getElementData(source,"Country")
				if country then
					if arabianCountries[country] then
						state = "AR"
					elseif RUCountries[country] then
						state = "RU"
					elseif BRCountries[country] then
						state = "BR"
					elseif NLCountries[country] then
						state = "NL"
					elseif TRCountries[country] then
						state = "TR"
					end
					for i=1, string.len ( message ) do
						local n = message:sub ( i, i )
						if ( n:byte ( ) < 32 or n:byte ( ) > 127 ) then
							if not state then
								outputChatBox("(Non English) " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( message ) ), source, 255, 128, 0, true)
								--exports.discord_logs:send("chat.message.text", { author = "LanguageChat -> NonEnglish - "..getPlayerName(source), text = message })
								onChatSystemSendMessage ( message, state, source )
								return false
							else
								outputChatBox("(" .. string.upper(state) .. ") " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( message ) ), source, 255, 128, 0, true)
								--exports.discord_logs:send("chat.message.text", { author = "LanguageChat -> "..string.upper(state).." - "..getPlayerName(source), text = message })
								onChatSystemSendMessage ( message, state, source )
								return false
							end
						end
					end
				end
				teamChatSpam[source] = getTickCount()

				local teamPlayers = {}

				local sourceTeam = getPlayerTeam ( source )

				local teamName = getTeamName ( sourceTeam )

				local r,g,b = getTeamColor(getPlayerTeam(source))

				local gr = getElementData(source,"Group")
				if exports.AURgroups:isGroup(source,gr,"crim") then
					r,g,b = exports.AURgroups:getGroupColor(gr)
				end
				if exports.AURgroups:isGroup(source,gr,"law") then
					r,g,b = exports.AURgroups:getGroupColor(gr)
				end
				if getElementDimension(source) == 5001 then
					r,g,b = 100,250,20
				end
				if getElementDimension(source) == 5002 then
					r,g,b = 250,0,150
				end
				if getElementDimension(source) == 5006 then
					r,g,b = 50,55,90
				end
				if getElementDimension(source) == 5003 then
					r,g,b = 250,150,0
				end
				if getElementDimension(source) == 5004 then
					r,g,b = 150,80,80
				end
				if getElementDimension(source) == 5005 then
					r,g,b = 250,100,100
				end
				--if getElementData(source,"Group") == "GIGN" and getTeamName(getPlayerTeam(source)) == "Government" then
					--r,g,b = 0,20,110
				--end
				local allplayers = getElementsByType ( "player" )

				-- ** LAG exports.NGCmusic:captureCommunication("(TEAM) ".. getPlayerName(source) ..": #FFFFFF".. removeHEX( message ),r,g,b)
				--SPY SHIT
					local playertable = getElementsByType("player")
					local r, g, b = getPlayerNametagColor(source)
					if getElementDimension(source) == 5001 then
						r,g,b = 100,250,20
					end
					if getElementDimension(source) == 5002 then
						r,g,b = 250,0,150
					end
					if getElementDimension(source) == 5006 then
						r,g,b = 50,55,90
					end
					if getElementDimension(source) == 5003 then
						r,g,b = 250,150,0
					end
					if getElementDimension(source) == 5004 then
						r,g,b = 150,80,80
					end
					if getElementDimension(source) == 5005 then
						r,g,b = 250,100,100
					end
					--if getElementData(source,"Group") == "GIGN" and getTeamName(getPlayerTeam(source)) == "Government" then
						--r,g,b = 0,20,110
					--end
					for i,v in ipairs(playertable) do
						if (exports.CSGstaff:isPlayerStaff(v)) and (getTeamName(getPlayerTeam(v)) == "Staff") then
							local r, g, b = getTeamColor(getPlayerTeam(source))
							outputChatBox("(TEAM CHAT) ["..teamName.."] "..getPlayerName(source)..": "..message, v, r, g, b)
						end
					end
					--exports.discord_logs:send("chat.message.text", { author = "TeamChat - "..getPlayerName(source).." -> "..teamName, text = message })
				--END OF SPY SHIT

				for theKey,thePlayer in ipairs(allplayers) do

					local playersTeam = getPlayerTeam ( thePlayer )

					if (sourceTeam == playersTeam) then

						table.insert(teamPlayers,thePlayer)
						

					end

				end
							if getElementDimension(source) == 5001 then
								kingtag = "[Shooter] "
							end
							if getElementDimension(source) == 5002 then
								kingtag = "[DD] "
							end
							if getElementDimension(source) == 5006 then
								kingtag = "[Drag] "
							end
							if getElementDimension(source) == 5003 then
								kingtag = "[CSGO] "
							end
							if getElementDimension(source) == 5004 then
								kingtag = "[DM] "
							end
							if getElementDimension(source) == 5005 then
								kingtag = "[Trials] "
							end

				for index, sameTeamPlayers in ipairs( allplayers ) do

					if ( getElementData( sameTeamPlayers, "chatOutputTeamchat" ) ) then

						if teamName == "Criminals" or teamName == "HolyCrap" then
							if (getPlayerTeam(sameTeamPlayers)) then 
								if (getTeamName(getPlayerTeam(sameTeamPlayers)) == "Criminals") or (getTeamName(getPlayerTeam(sameTeamPlayers)) == "HolyCrap") then
								local boss = getElementData(source,"boss")

								if boss and boss > 0 then rank = "Boss"

									outputChatBox( "(TEAM) "..kingtag.."".. getPlayerName(source) .." #FF000f["..rank.."] : #FFFFFF".. removeHEX(message), sameTeamPlayers, r,g,b, true )


								else

									outputChatBox( "(TEAM) "..kingtag.."".. getPlayerName(source) ..": #FFFFFF".. removeHEX(message), sameTeamPlayers, r,g,b, true )


								end
							end
						end
						elseif teamName == "Civilian Workers" then
							if (getTeamName(getPlayerTeam(sameTeamPlayers)) == "Civilian Workers") then
								if (exports.AURrsa:is_rsa(source)) then
									outputChatBox( "(JOB: "..getElementData(source,"Occupation")..") "..kingtag.."".. getPlayerName(source) .."#FF000f[RSA]: #FFFFFF".. removeHEX(message), sameTeamPlayers, r,g,b, true )
								else
									outputChatBox( "(JOB: "..getElementData(source,"Occupation")..") "..kingtag.."".. getPlayerName(source) ..": #FFFFFF".. removeHEX(message), sameTeamPlayers, r,g,b, true )
								end
							end
						else
							if (getPlayerTeam(sameTeamPlayers) == getPlayerTeam(source)) then
								outputChatBox( "(TEAM) "..kingtag.."".. getPlayerName(source) ..": #FFFFFF".. removeHEX(message), sameTeamPlayers, r,g,b, true )
							end
						end

					end

					triggerClientEvent ( sameTeamPlayers, "onChatSystemMessageToClient", sameTeamPlayers, source, removeHEX(message), "Teamchat" )

				end

				if logData == true then

					exports.CSGlogging:createLogRow ( source, "teamchat", message, teamName )

				end

			end

		end

    end

end

addEventHandler( "onPlayerChat", root, onPlayerMessageTeamChat )



function onPlayerMessageMainChat( message, messageType, thePlayers )

	local source = source or thePlayers
	local kingtag = ""
	if ( exports.server:getPlayerAccountName ( source ) ) then

		if (messageType == 0) then

			if ( triggerEvent("onServerPlayerChat", source, message) == false) then

				return false

			end
			--if getElementData(source,"playTime")/60 < 15 then
			--	outputChatBox("You should have 15 hours or more to use main chat",source,255,0,0)
			--	return false
			--end
			if message:match("^%s*$") then

				exports.NGCdxmsg:createNewDxMessage(source, "You didn't enter a message!", 200, 0, 0)

			elseif ( exports.CSGadmin:getPlayerMute ( source ) == "Main" ) or ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then

				exports.NGCdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)

			elseif ( mainChatSpam[source] ) and ( getTickCount()-mainChatSpam[source] < 1000*3 ) and not ( exports.CSGstaff:isPlayerStaff( source ) ) then

				exports.NGCdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message in three seconds.", 200, 0, 0)

			else
				state = false
				local country = getElementData(source,"Country")
				if country then
					if arabianCountries[country] then
						state = "AR"
					elseif RUCountries[country] then
						state = "RU"
					elseif BRCountries[country] then
						state = "BR"
					elseif NLCountries[country] then
						state = "NL"
					elseif TRCountries[country] then
						state = "TR"
					end
					for i=1, string.len ( message ) do
						local n = message:sub ( i, i )
						if ( n:byte ( ) < 32 or n:byte ( ) > 127 ) then
							if not state then
								outputChatBox("(Non English) " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( message ) ), source, 255, 128, 0, true)
								onChatSystemSendMessage ( message, state, source )
								return false
							else
								outputChatBox("(" .. string.upper(state) .. ") " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( message ) ), source, 255, 128, 0, true)
								onChatSystemSendMessage ( message, state, source )
								return false
							end
						end
					end
				end
				mainChatSpam[source] = getTickCount()

				local nearbyPlayers = {}


				local playerChatZone = exports.server:getPlayChatZone( source )

				local r, g, b = getTeamColor(getPlayerTeam(source))
				local gr = getElementData(source,"Group")
				if exports.AURgroups:isGroup(source,gr,"crim") then
					r,g,b = exports.AURgroups:getGroupColor(gr)
				end
				if exports.AURgroups:isGroup(source,gr,"law") then
					r,g,b = exports.AURgroups:getGroupColor(gr)
				end
				if getElementDimension(source) == 5001 then
					r,g,b = 100,250,20
				end
				if getElementDimension(source) == 5002 then
					r,g,b = 250,0,150
				end
				if getElementDimension(source) == 5006 then
					r,g,b = 50,55,90
				end
				if getElementDimension(source) == 5003 then
					r,g,b = 250,150,0
				end
				if getElementDimension(source) == 5004 then
					r,g,b = 150,80,80
				end
				if getElementDimension(source) == 5005 then
					r,g,b = 250,100,100
				end
				--if getElementData(source,"Group") == "GIGN" and getTeamName(getPlayerTeam(source)) == "Government" then
					--r,g,b = 0,20,110
				--end
				local getAllPlayers = getElementsByType ( "player" )
				--[[if exports.server:getPlayerAccountName(source) == "hana2" then
					kingtag = "[King] "
				elseif exports.server:getPlayerAccountName(source) == "iphone7" then
					kingtag = "[Optimus] "
				elseif exports.server:getPlayerAccountName(source) == "matrix95" then
					kingtag = "[Aly] "
				elseif exports.server:getPlayerAccountName(source) == "ortega" then
					kingtag = "[Loay] "
				end]]
				if getElementDimension(source) == 5001 then
					kingtag = "[Shooter] "
				end
				if getElementDimension(source) == 5002 then
					kingtag = "[DD] "
				end
				if getElementDimension(source) == 5006 then
					kingtag = "[Drag] "
				end
				if getElementDimension(source) == 5003 then
					kingtag = "[CSGO] "
				end
				if getElementDimension(source) == 5004 then
					kingtag = "[DM] "
				end
				if getElementDimension(source) == 5005 then
					kingtag = "[Trials] "
				end
				--exports.discord_logs:send("chat.message.text", { author = "MainChat -> "..playerChatZone.." - "..getPlayerName(source), text = message })
				for theKey, thePlayer in ipairs(getAllPlayers) do

					local thePlayerChatZone = exports.server:getPlayChatZone( thePlayer )

					if ( getElementData( thePlayer, "chatOutputMainchat" ) ) then
						
							
						if exports.CSGstaff:isPlayerStaff(source) and getTeamName(getPlayerTeam(source)) == "Staff" then 
							outputChatBox( "#00ff00(#00ff00".. playerChatZone .."#00ff00) #FFFFFF"..kingtag.."".. getPlayerName(source) ..": #FFFFFF".. removeHEX( message ), thePlayer, r,g,b, true )
					--	elseif exports.server:getPlayerAccountName(source) == "iphone7" then
						--	outputChatBox( "#FFF00F[#00ff00 Echo #FFF00F] #FFFFFF".. getPlayerName(source) ..": #FFFFFF".. removeHEX( message ), thePlayer, r,g,b, true )
						else
								outputChatBox( "(".. playerChatZone ..") "..kingtag.."".. getPlayerName(source) ..": #FFFFFF".. removeHEX( message ), thePlayer, r,g,b, true )
						end
					end
					triggerClientEvent (thePlayer, "onChatSystemMessageToClient", thePlayer, source, playerChatZone.." "..removeHEX( message ), "Mainchat" )
				end
				exports.CSGlogging:createLogRow( source, "mainchat", removeHEX( message ) )

				--for k,v in pairs(getElementsByType("player")) do

				--	triggerClientEvent (v, "onChatSystemMessageToClient", v, source, playerChatZone.." "..removeHEX( message ), "Mainchat" )

				---end

				triggerEvent( "onPlayerMainChat", source, playerChatZone, removeHEX(message) )

			end

		end

    end

end

addEventHandler( "onPlayerChat", root, onPlayerMessageMainChat )



addEvent( "onChatSystemSendMessage", true )

function onChatSystemSendMessage ( theMessage, theRoom, thePlayer )

	if (source) and isElement(source) then thePlayer=source end

	local source = source or thePlayer

	if theRoom=="Support" and getElementData(thePlayer,"chatOutputSupport") == false then

		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You have disabled support chat, go to Phone > Settings to enable it!", 200, 0, 0)

		return

	end

	if(triggerEvent("onServerPlayerChat", thePlayer, theMessage) == false) then

		return false

	end
	if theRoom == "Support" or theRoom == "Mainchat" or theRoom == "Teamchat" or theRoom == "AUR" then
		state = false
		local country = getElementData(source,"Country")
		if country then
			if arabianCountries[country] then
				state = "AR"
			elseif RUCountries[country] then
				state = "RU"
			elseif BRCountries[country] then
				state = "BR"
			elseif NLCountries[country] then
				state = "NL"
			elseif TRCountries[country] then
				state = "TR"
			end
			for i=1, string.len ( theMessage ) do
				local n = theMessage:sub ( i, i )
				if ( n:byte ( ) < 32 or n:byte ( ) > 127 ) then
					if not state then
						outputChatBox("(Non English) " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( theMessage ) ), source, 255, 128, 0, true)
						return false
					else
						outputChatBox("(" .. string.upper(state) .. ") " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( theMessage ) ), source, 255, 128, 0, true)
						onChatSystemSendMessage ( theMessage, state, source )
						return false
					end
				end
			end
		end
	end


	if theRoom=="PT" or theRoom=="BR" then theRoom="PT-BR" end

	if ( theRoom == "Support" ) and ( exports.CSGadmin:getPlayerMute ( source ) == "Support" ) then exports.NGCdxmsg:createNewDxMessage(source, "You are muted from the support channel!", 236, 201, 0) return end

	if ( exports.server:getPlayerAccountName ( source ) ) then

		if ( theMessage ) and ( theRoom ) then

			if ( theRoom == "Localchat" ) then

				executeCommandHandler ( "localchat", source, theMessage  )

			elseif ( theRoom == "Groupchat" ) then

				executeCommandHandler ( "groupchat", source, theMessage  )

			elseif ( theRoom == "Alliancechat" ) then

				executeCommandHandler ( "ac", source, theMessage  )

			elseif ( theRoom == "Mainchat" ) then

				onPlayerMessageMainChat( theMessage, 0, source )

			elseif ( theRoom == "Teamchat" ) then

				onPlayerMessageTeamChat( theMessage, 2, source )
			
			--elseif ( theRoom == "AUR" ) then
			
				

			else

				if theMessage:match("^%s*$") then

					exports.NGCdxmsg:createNewDxMessage(source, "You didnt enter a message!", 200, 0, 0)

				elseif ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then

					exports.NGCdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)

				elseif ( chatRoomSpam[source] ) and ( getTickCount()-chatRoomSpam[source] < 1000 ) then

					exports.NGCdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message each second.", 200, 0, 0)

				else
					loop = {}
					for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do

						if ( getElementData( thePlayer, "chatOutput"..theRoom ) ) then
							
							if ( theRoom == "Support" ) and  exports.CSGstaff:isPlayerStaff(source) then

								outputChatBox("(Solution) " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( theMessage ) ), thePlayer, 0, 255, 0, true)
							elseif  theRoom == "Support"  and  ( getElementData(source,"isPlayerSupporter") == true ) then
								outputChatBox("(Solution) " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( theMessage ) ), thePlayer, 0, 255, 0, true)
							elseif theRoom == "AUR" and exports.CSGstaff:isPlayerStaff( thePlayer ) then
								for a, b in pairs(exports.CSGstaff:getOnlineAdmins()) do
									--if (loop[source] ~= true) then
									--	loop[source] = true
										--outputChatBox("(AUR) " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( theMessage ) ), b, 0, 255, 0, true)
										triggerClientEvent(b,"onChatSystemMessageToClient",resourceRoot, source, removeHEX(theMessage), "AUR" )
										executeCommandHandler ( "aur", source, theMessage )
										--exports.discord_staff:send("chat.message.text", { author = getPlayerName(source), text = tostring(theMessage) })
									--end
									break
								end
								return
							elseif ( theRoom == "Support" ) and not exports.CSGstaff:isPlayerStaff(source) then
							
								outputChatBox("(" .. string.upper(theRoom) .. ") " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( theMessage ) ), thePlayer, 137, 104, 205, true)

							else

								outputChatBox("(" .. string.upper(theRoom) .. ") " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( removeHEX( theMessage ) ), thePlayer, 255, 128, 0, true)

							end

						end

						triggerClientEvent(thePlayer,"onChatSystemMessageToClient",thePlayer, source, removeHEX(theMessage), theRoom )

					end

					chatRoomSpam[source] = getTickCount()



					if logData==true then

						exports.CSGlogging:createLogRow ( source, theRoom, theMessage )

						-- ** LAG exports.NGCmusic:captureCommunication("(" .. string.upper(theRoom) .. ") " .. ( getPlayerName( source ) ) .. ": "..( removeHEX( theMessage ) ), 255,255,255)

					end

					if ( theRoom == "Support" ) then

						triggerEvent( "onPlayerSupportChat", source, removeHEX(theMessage) )

					end

				end

			end

		end

	end

end

addEventHandler("onChatSystemSendMessage", root, onChatSystemSendMessage )




function onChatSystemCommandChat( thePlayer,commandName,... )

	if ( commandName == "nl" ) or ( commandName == "tn" ) or ( commandName == "tr" ) or ( commandName == "ru" ) or ( commandName == "ar" ) or ( commandName == "pt" )  or ( commandName == "br" ) then

		commandName = string.upper(commandName)

	else

		commandName = commandName:gsub("^%l", string.upper)

	end



	local theMessage = table.concat({...}, " ")

	if theMessage:match("^%s*$") then

		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You didnt enter a message!", 200, 0, 0)

	elseif ( exports.CSGadmin:getPlayerMute ( thePlayer ) == "Global" ) then

		exports.NGCdxmsg:createNewDxMessage(thePlayer, "You are muted!", 236, 201, 0)

	else

		onChatSystemSendMessage( removeHEX( theMessage ), commandName, thePlayer )

	end

end



for i=1,#chatRooms do

	if ( chatRooms[i] == "NL" ) or ( chatRooms[i] == "TN" ) or ( chatRooms[i] == "TR" ) or ( chatRooms[i] == "RU" ) or ( chatRooms[i] == "PT-BR" ) or ( chatRooms[i] == "AR" ) or ( chatRooms[i] == "Support" ) then

		if ( chatRooms[i] == "PT-BR") then

			addCommandHandler( "pt", onChatSystemCommandChat )

			addCommandHandler( "br", onChatSystemCommandChat )

		else

			addCommandHandler( string.lower(chatRooms[i]), onChatSystemCommandChat )

		end

	end

end

addEventHandler("onServerPlayerLogin", root, function()
	if (exports.server:getPlayerAccountName(source) == "truc0813") or (exports.server:getPlayerAccountName(source) == "paul12") then 
		return 
	end 
    if exports.CSGstaff:isPlayerStaff(source) then
    exports.killmessages:outputMessage( "(STAFF) *"..getPlayerName(source).." is now online [Logged in]", root, 250, 250, 250)
	else
	exports.killmessages:outputMessage( "* "..getPlayerName(source).." is now online [Logged in]", root, 0, 250, 0)
    end
end)

addEventHandler("onPlayerQuit", root, function(reason)
	if (getPlayerSerial (source) == "0DC3A46E67FDF79B7084EBE916001184") or (exports.server:getPlayerAccountName(source) == "paul12") then 
		return 
	end 
	if exports.CSGstaff:isPlayerStaff(source) then
    exports.killmessages:outputMessage( "(STAFF) *"..getPlayerName(source).." is now offline ["..reason.."]", root, 250, 250, 250)
	else
    exports.killmessages:outputMessage( "* "..getPlayerName(source).." is now offline ["..reason.."]", root, 250, 0, 0)
    end
end)

function teamnote(plr, cmd, team, ...)
	local text = table.concat({...}, " ")
	if (exports.CSGstaff:isPlayerStaff(plr)) then
		if (string.lower(team) == "law") then
			for k, v in ipairs(getElementsByType("player")) do
				if (exports.DENlaw:isLaw(v)) then
					outputChatBox(getPlayerName(plr).." to law team: #FFFFFF "..text, v, 255, 0, 0, true)
				end
			exports.NGCdxmsg:createNewDxMessage(plr, "Your message has been forwarded to the law team.", 0, 255, 0)
			end
		else
			for k, v in ipairs(getElementsByType("team")) do
				if (string.lower(getTeamName(v)) == string.lower(team)) then
					for key, value in ipairs(getPlayersInTeam(v)) do
						outputChatBox(getPlayerName(plr).." to "..getTeamName(v).."'s team: #FFFFFF "..text, value, 255, 0, 0, true)
					end
					exports.NGCdxmsg:createNewDxMessage(plr, "Your message has been forwarded to the "..getTeamName(v), 0, 255, 0)
				end
			end
		end
	end
end
addCommandHandler("teamnote", teamnote)
