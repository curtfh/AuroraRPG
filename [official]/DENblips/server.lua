function destroyPlayerGroupBlips (thePlayer)
	if ( thePlayer ) then
		triggerClientEvent( thePlayer, "deleteGroupBlip", thePlayer )
		return true
	else
		return false
	end
end

addCommandHandler("playerblips",function(p,cmd,state)
	if getPlayerTeam(p) and getTeamName(getPlayerTeam(p)) == "Staff" then
		if state == "true" or state == "false" then
			if state == "true" then s = true else s = false end
			setElementData(resourceRoot,"hideandseek",s)
			outputChatBox("Player blips changed in Dim 2000",p,0,255,0)
		else
			outputChatBox("Please use /playerblips true or false",p,0,255,0)
		end
	end
end)
