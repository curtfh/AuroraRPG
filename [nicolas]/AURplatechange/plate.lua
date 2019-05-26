function AURPlateText(thePlayer,commandName,text)
	local Vehicle = getPedOccupiedVehicle(thePlayer)
	if Vehicle then
		if text then
			setVehiclePlateText( Vehicle, text )
		else
			outputChatBox("You need write text.",255,255,255,thePlayer)
		end
	else
		outputChatBox("You need car to change plate!",255,255,255,thePlayer)
	end
end
addCommandHandler("changeplate",AURPlateText)