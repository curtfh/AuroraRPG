local chat_range=100

local showtime = tonumber(get("chatbubbles.DefaultTime"))

local characteraddition = tonumber(get("chatbubbles.PerCharacterAddition"))

local maxbubbles = get("chatbubbles.MaxBubbles")

if maxbubbles == "false" then maxbubbles = false else maxbubbles = tonumber(maxbubbles) end

local hideown = get("chatbubbles.HideOwn")

if hideown == "true" then hideown = true else hideown = false end



local localChatSpam = {}



addEventHandler( "onPlayerJoin",root,

	function ()

		bindKey( source, "u", "down", "chatbox", "Localchat" )

	end

)



addEventHandler( "onResourceStart", resourceRoot,

	function ()

		for index, player in pairs( getElementsByType( "player" ) ) do

			bindKey( player, "u", "down", "chatbox", "Localchat" )

		end

	end

)



function onPlayerMessagelocalChat(player,_,...)

	if ( exports.server:getPlayerAccountName ( player ) ) then

		local px,py,pz = getElementPosition(player)

		local message = table.concat({...}, " ")

		if ( triggerEvent( "onServerPlayerChat", player, message ) == false ) then

			return false

		end

		if ( exports.server:getPlayerAccountName ( player ) ) then

			if message:match("^%s*$") then

				exports.NGCdxmsg:createNewDxMessage(player, "You didn't enter a message", 200, 0, 0)

			elseif ( localChatSpam[player] ) and ( getTickCount()-localChatSpam[player] < 1000 ) then

				exports.NGCdxmsg:createNewDxMessage(player, "You are typing to fast! The limit is one message each second.", 200, 0, 0)

			elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then

				exports.NGCdxmsg:createNewDxMessage(player, "You are muted!", 236, 201, 0)

			else

				localChatSpam[player] = getTickCount()

				local message, nonFilterdMessage = exports.server:cleanStringFromBadWords( message )

				local nick = getPlayerName(player)

				local r,g,b = getTeamColor(getPlayerTeam(player))

				local gr = getElementData(player,"Group")
				if exports.AURgroups:isGroup(player,gr,"crim") then
					r,g,b = exports.AURgroups:getGroupColor(gr)
				end
				if exports.AURgroups:isGroup(player,gr,"law") then
					r,g,b = exports.AURgroups:getGroupColor(gr)
				end

				local playertable = getElementsByType("player")

				local newplayertable = {}



				--exports.NGCmusic:captureCommunication("(LOCAL) "..nick..": #ffffff"..message,r,g,b)

				for i,v in ipairs(playertable) do

					if getElementDimension(v) == getElementDimension(player) and exports.denchatsystem:isPlayerInRangeOfPoint(v,px,py,pz,chat_range) then

						table.insert(newplayertable , v)

					end

				end




				local thecount = #newplayertable
				--SPY SHIT
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
									local gr = getElementData(player,"Group")
								if exports.AURgroups:isGroup(player,gr,"crim") then
									r,g,b = exports.AURgroups:getGroupColor(gr)
								end
								if exports.AURgroups:isGroup(player,gr,"law") then
									r,g,b = exports.AURgroups:getGroupColor(gr)
								end
										outputChatBox("(LOCAL) ["..thecount.."] "..nick..": "..message, v, r, g, b)
								end
								end
							end
						end
					end
					exports.discord_logs:send("chat.message.text", { author = "LocalChat - ["..thecount.."] "..nick, text = message })
				--END OF SPY SHIT

				local r_,g_,b_ = getPlayerNametagColor(player)
						local gr = getElementData(player,"Group")
								if exports.AURgroups:isGroup(player,gr,"crim") then
									r,g,b = exports.AURgroups:getGroupColor(gr)
								end
								if exports.AURgroups:isGroup(player,gr,"law") then
									r,g,b = exports.AURgroups:getGroupColor(gr)
								end
				for _,v in ipairs(newplayertable ) do

					if getElementAlpha( v ) == 0 then thecount = thecount -1 end

					if ( getElementData( v, "chatOutputLocalchat" ) ) then
						
							outputChatBox( "(LOCAL) ["..thecount.."]"..nick..": #ffffff"..message,v,r,g,b,true)

					end

					triggerClientEvent( v, "onChatSystemMessageToClient", v, player, message, "Localchat" )

				end

				triggerClientEvent("onChatbubblesMessageIncome", player, message, 1)

				exports.CSGlogging:createLogRow ( player, "localchat", nonFilterdMessage )

			end

		end

	end

end

addCommandHandler( "Localchat", onPlayerMessagelocalChat, false,false )

addCommandHandler( "local", onPlayerMessagelocalChat,false,false )



addEvent("onAskForBubbleSettings",true)

function returnSettings()

	local settings =

	{

		showtime,

		characteraddition,

		maxbubbles,

		hideown

	}

	triggerClientEvent( source, "onBubbleSettingsReturn", root, settings )

end

addEventHandler( "onAskForBubbleSettings",root,returnSettings )

function transformMe(message, messageType)
    if messageType ~= 1 then
        return
    end

    local px, py, pz = getElementPosition(source)

    if (message == "") then
        cancelEvent( )
        return outputChatBox( "Type a message please!", source, 255, 0, 0 )
    end

	if ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
		cancelEvent( )
	return exports.NGCdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)
	end

    local nick = getPlayerName( source )
    for _, v in ipairs(getElementsByType("player")) do
        if isPlayerInRangeOfPoint(v,px,py,pz,100) then
            outputChatBox("* "..nick.." "..message, v, 255, 192, 203, false)
        end
    end
end
addEventHandler( "onPlayerChat", root, transformMe )
