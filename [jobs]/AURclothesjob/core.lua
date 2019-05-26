
local thePed = {}

addEvent("setStorePedTask",true)
addEventHandler("setStorePedTask",root,function(skin)
	local step = math.random(0,1)
	if step == 1 then
		x,y,z = 208,-138.35,1003.5
	else
		x,y,z = 206.14,-138.15,1003.5
	end
	if isElement(thePed[source]) then destroyElement(thePed[source]) end
	thePed[source] = createPed(skin,x,y,z)
	setElementData(thePed[source],"showModelPed",true)
	setElementInterior(thePed[source],3)
	local dim = exports.server:getPlayerAccountID(source)
	setElementDimension(thePed[source],dim)
	triggerClientEvent(source,"togglePedGreeting",source,thePed[source])
	enableHLCForNPC(thePed[source],"walk")
	addNPCTask(thePed[source],{"walkToPos",207.09,-129.19,1003.5,0.5})
end)

addEvent("setStoreDim",true)
addEventHandler("setStoreDim",root,function()
	local dim = exports.server:getPlayerAccountID(source)
	setElementDimension(source,dim)
end)

addEvent("npc_hlc:onNPCTaskDone",true)
addEvent("setPedTask",true)
addEventHandler("setPedTask",root,function()
	if isElement(thePed[source]) then
		setElementPosition(thePed[source],207.58,-129.32,1003.5)
		setPedRotation(thePed[source],187)
		addNPCTask(thePed[source],{"walkToPos",207,-140.38,1003.5,0.5})
		local player = source
		addEventHandler("npc_hlc:onNPCTaskDone",thePed[source],function()
			if isElement(thePed[player]) then destroyElement(thePed[player]) end
		end)
	end
end)


addEvent("endStorePed",true)
addEventHandler("endStorePed",root,function()
	if isElement(thePed[source]) then
		destroyElement(thePed[source])
		exports.NGCdxmsg:createNewDxMessage(source,"Customer has left the shop, you left store corner",255,0,0)
	end
end)



addEvent("leaveStoreInterior",true)
addEventHandler("leaveStoreInterior",root,function()
	local dim = exports.server:getPlayerAccountID(source)
	if getElementDimension(source) == dim then
		setElementDimension(source,0)
	end
end)
antispam = {}
antispam2 = {}
addEvent("payPedTask",true)
addEventHandler("payPedTask",root,function(m)
	if isTimer(antispam[source]) then return false end
	--givePlayerMoney(source,m)
	antispam[source] = setTimer(function() end,10000,1)
	exports.AURpayments:addMoney(source,m,"Custom","Clothes Seller",0,"AURclothesjob")
	exports.NGCdxmsg:createNewDxMessage(source,"You have earned $"..m.." from selling this item",0,255,0)

end)


addEvent("payBonusTask",true)
addEventHandler("payBonusTask",root,function(m)
	if isTimer(antispam2[source]) then return false end
	--givePlayerMoney(source,m)
	antispam2[source] = setTimer(function() end,10000,1)
	exports.AURpayments:addMoney(source,m,"Custom","Clothes Seller",0,"AURclothesjob")
	exports.NGCdxmsg:createNewDxMessage(source,"You have earned $"..m.." from Store boss!!",0,255,0)

end)



local markerout = createMarker(206.92,-140.38,1004.5,"arrow",1.5,255,255,0)
local markerin = createMarker(-2242.38,145.32,36.32,"arrow",1.5,255,255,0)
setElementInterior(markerout,3)


addEventHandler("onMarkerHit",resourceRoot,function(h,d)
	if source == markerout then
		if d then
			if h and getElementType(h) == "player" then
				if not isPedInVehicle(h) then
					setElementInterior(h,0)
					setElementPosition(h,-2244.12,145.71,35.32)
					setPedRotation(h,93)
				end
			end
		end
	elseif source == markerin then
		if d then
			if h and getElementType(h) == "player" then
				if not isPedInVehicle(h) then
					if getElementData(h,"Occupation") == "Clothes Seller" and getTeamName(getPlayerTeam(h)) == "Civilian Workers" then
						setElementInterior(h,3)
						setElementPosition(h,207.09,-138.49,1003.5)
						setPedRotation(h,5)
					else
						exports.NGCdxmsg:createNewDxMessage(h,"You can't enter this store while you're not Clothes seller",255,0,0)
					end
				end
			end
		end
	end
end)
