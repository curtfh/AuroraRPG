addEventHandler("onServerPlayerLogin", root, function()
	if (getElementData(source, "AURpartyinvitation.enabled") == true) then 
		triggerClientEvent (source, "AURpartyinvitation.requestInvitation", source)
	end
end)

addCommandHandler("staffforceinvidshow", function()
	for k, v in ipairs(getElementsByType("player")) do 
		triggerClientEvent (v, "AURpartyinvitation.requestInvitation", v)
	end
end)