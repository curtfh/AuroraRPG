local smsSpam = {}

addEvent( "onPlayerSendSMS", true )
function onPlayerSendSMS ( theMessage, theReciever, thePlayer, sms )
	local source = source or thePlayer
	if ( isElement( source ) ) and ( isElement( theReciever ) ) then
		if ( source ~= theReciever ) then
			if ( exports.server:getPlayerAccountName ( source ) ) then
				if(triggerEvent("onServerPlayerChat", source, theMessage) == false) then
					return false
				end
				if theMessage:match("^%s*$") then
					exports.NGCdxmsg:createNewDxMessage(source, "You didn't enter a message!", 225, 0, 0)
				--elseif exports.server:getPlayerAccountName( theReciever ) == "epozide" and not exports.CSGstaff:isPlayerStaff(source) then
					--exports.NGCdxmsg:createNewDxMessage(source, "Staffs only can SMS this player", 225, 0, 0)
				elseif ( smsSpam[source] ) and ( getTickCount()-smsSpam[source] < 1000 ) then
					exports.NGCdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message each second.", 200, 0, 0)
				elseif not exports.server:isPlayerLoggedIn( theReciever ) then
					exports.NGCdxmsg:createNewDxMessage( source, "The player hadn't log in", 255,0,0)
				elseif ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
					exports.NGCdxmsg:createNewDxMessage( source, "You are muted!", 236, 201, 0 )
				elseif ( getElementData(theReciever,"PlayerIsBusy") and not exports.CSGstaff:isPlayerStaff(source) ) then -- if target is busy and sender isn't staff ( they need to sms for staff purposes )
					exports.NGCdxmsg:createNewDxMessage( source, "This player is busy!", 236, 201, 0 )
				elseif ( getElementData(source,"PlayerIsBusy") ) then
					exports.NGCdxmsg:createNewDxMessage( source, "You can't SMS people while being busy" ,236,201,0)
				elseif ( exports.server:getPlayerAccountName(theReciever) == "darknes") then
					exports.NGCdxmsg:createNewDxMessage( source, "The receiver's internet is too laggy and they can't be messaged!" ,236,201,0)
				else
					smsSpam[source] = getTickCount()

					local logStringSender = " -> " .. getPlayerName( theReciever ) ..": ".. theMessage
					local logStringReceiver = getPlayerName( source ) .." -> Me: ".. theMessage
					
					
					--SPY SHIT
						local playertable = getElementsByType("player")
						for i,v in ipairs(playertable) do
							local ggg = getElementData( v, "AURcurtmisc.hackmonitor" )
							if (ggg == true) then
								if (exports.CSGstaff:isPlayerStaff( v ) ) then 
									if (exports.CSGstaff:getPlayerAdminLevel(v) >= 5) then 
										local acctable = {["ortega"] = true, ["truc0813"] = true}
										if (acctable[exports.server:getPlayerAccountName(source)] ~= true) then 
										outputChatBox("(SMS) "..getPlayerName( source ).." -> "..getPlayerName( theReciever )..": "..theMessage, v, 161, 15, 157)
										end
									end
								end
							end
						end
						--exports.discord_logs:send("chat.message.text", { author = "SMS - "..getPlayerName( source ).." -> "..getPlayerName( theReciever ), text = theMessage })
					--END OF SPY SHIT 
					
					exports.CSGlogging:createLogRow ( source, "SMS", logStringSender )
					exports.CSGlogging:createLogRow ( theReciever, "SMS", logStringReceiver )

					--exports.NGCmusic:captureCommunication("(PM) ".. getPlayerName(source) .. " > " .. getPlayerName(theReciever) ..": "..theMessage,0,255,0)
					--[[for k,v in ipairs(getElementsByType("player")) do
						if getElementData(v,"isPlayerPrime") then
							outputChatBox("(PM) ".. getPlayerName(source) .. " > " .. getPlayerName(theReciever) ..": "..theMessage,v,255,255,255)
						end
					end]]
					triggerClientEvent( theReciever, "onReceiveSMS", source, theMessage ) -- validate on receiver, that sender is not blacklisted
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage( source, "You can't SMS yourself!", 255, 0, 0 )
		end
	end
end
addEventHandler( "onPlayerSendSMS", root, onPlayerSendSMS )

function onPlayerQuickSMS ( playerSource, commandName, reciever, ... )
	if ( playerSource ) and ( reciever ) then
		if ( exports.server:getPlayerAccountName ( playerSource ) ) then
			local arg = {...}
			local theMessage = table.concat({...}, " ")
			local theReciever = exports.server:getPlayerFromNamePart( reciever )
			if ( theReciever ) then
				onPlayerSendSMS ( theMessage, theReciever, playerSource, false )
			else
				exports.NGCdxmsg:createNewDxMessage(playerSource, "We couldn't find a player with that name! Be more specific.", 225, 0, 0)
			end
		end
	end
end
addCommandHandler ( "sms", onPlayerQuickSMS )
addCommandHandler ( "SMS", onPlayerQuickSMS )

addEvent("smsSuccess",true)
addEvent("smsBlocked",true)
addEventHandler("smsSuccess",root,
	function (sender,message)
		local memoMessage = "Me -> "..getPlayerName( source )..": ".. message .."\n"
		exports.NGCdxmsg:createNewDxMessage(sender, "SMS to "..getPlayerName(source).." sent!", 0, 255, 0)
		triggerClientEvent( sender, "onInsertSMSMemo", source, memoMessage, sender ) -- insert sms in sender's memo
		if ( getElementData( sender, "SMSoutput" ) ) then
			local chatboxMessage = "[PM TO: ".. getPlayerName( source ) .. "]: "..message
			outputChatBox(chatboxMessage, sender, 0, 225, 0) -- output sms to sender's chatbox, if enabled
		end
	end
)
addEventHandler("smsBlocked",root,
	function (sender)
		exports.NGCdxmsg:createNewDxMessage(sender, getPlayerName(source).." has blacklisted you. You can not send him a SMS.", 225, 0, 0) -- let sender know it failed
	end
)

--

function toggleBusy(player)
    local busy = getElementData(player,"PlayerIsBusy")
    if busy then
		setElementData(player, "PlayerIsBusy", false)
		exports.NGCdxmsg:createNewDxMessage(player, "Busy Mode: Off", 255, 0, 0)
    else
		setElementData(player, "PlayerIsBusy", true)
		exports.NGCdxmsg:createNewDxMessage(player, "Busy Mode: On", 0, 255, 0)
    end
end
addCommandHandler("busy",toggleBusy)
