local theTimer
local isEnabled = true
local disallowPlayerAccounts = {}

function triggerPlayerEscape (player)
	if (getElementData(player, "isPlayerJailed")) then 
		if (isEnabled == false) then 
			local remaining, executesRemaining, totalExecutes = getTimerDetails(theTimer)
			exports.NGCdxmsg:createNewDxMessage(player, "The Prison is in lockdown. Please wait "..math.floor((remaining/1000)/60).." minutes.",255, 0, 0)
			return 
		end 
		local oldWantedPoints = 0
		local userID = exports.server:getPlayerAccountID(player)
		if (isTimer(disallowPlayerAccounts[userID])) then 
			local remaining, executesRemaining, totalExecutes = getTimerDetails(disallowPlayerAccounts[userID])
			exports.NGCdxmsg:createNewDxMessage(player, "Your now in maximum security prison. Please wait "..math.floor((remaining/1000)/60).." minutes.",255, 0, 0)
			return
		end
		oldWantedPoints = getElementData(player, "wantedPoints")
		exports.NGCdxmsg:createNewDxMessage(player, "Attempting to escape...",255, 0, 0)
		disallowPlayerAccounts[userID] = setTimer(function()
			killTimer(disallowPlayerAccounts[userID])
			disallowPlayerAccounts[userID] = nil
		end, 7200000, 1)
		setTimer(function()
			triggerEvent ("onAdminUnjailPlayer", player, player)
			actualWL = oldWantedPoints+60
			exports.NGCdxmsg:createNewDxMessage(player, "You are attempting to escape the prison.",255, 0, 0)
			setElementData(player, "wantedPoints", actualWL)
			setTimer(function(actualWL)
				setElementData(player, "wantedPoints", actualWL)
				exports.AURcriminalp:giveCriminalPoints(player, "Race", 5)
				if doesPedHaveJetPack(player) then
					removePedJetPack(player)
				end 
				exports.NGCdxmsg:createNewDxMessage(player, "The law enforcement has been noticed. Please beware.",255, 0, 0)
--				exports.CSGwanted:addWanted(player, 39, getRandomPlayer())
				setTimer(function(actualWL) setElementData(player, "wantedPoints", actualWL) end, 2000, 1, actualWL)
			end, 3000, 1, actualWL)
			triggerClientEvent (player, "AURjailbreak.setAlarm", player)
		end, 2000, 1)
		
		for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
			if (getPlayerTeam(thePlayer) == false) then
			else
				if (getTeamName(getPlayerTeam(thePlayer)) == "Military Forces") then 
					outputChatBox("(LAW) Los Santos Prison Radio: "..getPlayerName(player).." has escaped from the prison. We are requesting 10-32C at Los Santos Prison.", thePlayer, 255, 0, 255)
				elseif (getTeamName(getPlayerTeam(thePlayer)) == "SWAT Team") then 
					outputChatBox("(LAW) Los Santos Prison Radio: "..getPlayerName(player).." has escaped from the prison. We are requesting 10-32C at Los Santos Prison.", thePlayer, 255, 0, 255)
				elseif (getTeamName(getPlayerTeam(thePlayer)) == "Government") then 
					outputChatBox("(LAW) Los Santos Prison Radio: "..getPlayerName(player).." has escaped from the prison. We are requesting 10-32C at Los Santos Prison.", thePlayer, 255, 0, 255)
				end 
			end
		end
		
	end
end 
addEvent("AURjailbreak.triggerPlayerEscape", true)
addEventHandler("AURjailbreak.triggerPlayerEscape", resourceRoot, triggerPlayerEscape)

theTimer = setTimer(function()
	if (isEnabled == true) then 
		isEnabled = false
	else
		isEnabled = true
	end 
end, 300000, 0)