addEvent("onSetAccountNitro",true)
addEventHandler("onSetAccountNitro",root,function(save)
	veh = getPedOccupiedVehicle(source,0)
	if veh and isElement(veh) then
		removeVehicleUpgrade(veh, 1010)
	end
	local nitro = getElementData(source,"nos")
	if nitro == false or nitro == nil then
		local nos = exports.DENstats:getPlayerAccountData(source,"nos")
		if nos == nil or nos == false or nos == 0 then
			nitro = nos or 0
		end
	end
	exports.DENstats:setPlayerAccountData(source,"nos",nitro)
	if save then
	--outputDebugString(getPlayerName(source).." was saved on client quit "..nitro.." nos")
	end
end)

addEventHandler("onPlayerQuit",root,function()
	local nex = getElementData(source,"nos")
	if nex == false or nex == nil then nex = 0 end
	exports.DENstats:setPlayerAccountData(source,"nos",nex)
--	outputDebugString(getPlayerName(source).." has quit with "..nex.." nos")
end)


addEventHandler("onServerPlayerLogin",root,function()
	local nos55 = exports.DENstats:getPlayerAccountData(source,"nos")
	if nos55 == nil or nos55 == false or nos55 == 0 then
		setElementData(source,"nos",0)
	--	outputDebugString(getPlayerName(source).." has 0 nos")
	else
		setElementData(source,"nos",nos55)
	--	outputDebugString(getPlayerName(source).." has "..nos55.." nos")
	end
end)


addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		local n = getElementData(v,"nos")
		if n == false or n == nil then
			local nos2 = exports.DENstats:getPlayerAccountData(v,"nos")
			if nos2 == nil or nos2 == false or nos2 == 0 then
				local nit = 0
				setElementData(v,"nos",nit)
			else
				setElementData(v,"nos",nos2)
			end
		end
	end
end)
