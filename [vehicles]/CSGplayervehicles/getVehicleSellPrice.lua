function getVehicleSellPrice(price,player) -- bought price, player
	if not isElement(player) then
		player = localPlayer
	end
	local sellPrice = ( price * 0.90 )
	if exports.server:isPlayerVIP(player) then
		sellPrice = ( price * 0.85 )
	end
	return sellPrice
end
