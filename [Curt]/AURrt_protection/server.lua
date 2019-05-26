setTimer(function()
	for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
		if (exports.CSGnewturfing2:isPlayerInRT(thePlayer) == true) then 
			if (getElementData(thePlayer, "isPlayerProtectedTeamRTCriminal") ~= true) then 
				setElementData(thePlayer, "isPlayerProtectedTeamRTCriminal", true)
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "Criminal team protection enabled.", 0, 230, 0)
			end 
		else
			if (getElementData(thePlayer, "isPlayerProtectedTeamRTCriminal") ~= false) then 
				setElementData(thePlayer, "isPlayerProtectedTeamRTCriminal", false)
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "Criminal team protection disabled.", 0, 230, 0)
			end 
		end 
	end 
end, 5000, 0)
