mark = {
	{1349.43213, 2337.31641, 16.45954},
	{2046.27527, 2843.60376, 12.39992},
	{1200.69067, 784.77832, 10.81881},
	{2891.86621, 1152.42590, 10.89844},
	{1594.3298339844,-1555.9375,13.586387634277},
	{1035.24963, 895.07257, 14.05469},
	{961.72034, 2402.42578, 10.82031},
	{2173.41064, 697.40460, 11.31995},
	{1044.13440, 802.95380, 10.79117},
	{887.86768, 876.83826, 13.35156},
}

bag = {
	{1540.12463, 1336.23621 ,10.87500},
	{2020.26062, 1225.58337, 10.82031},
	{1760.71716, 1731.45935 ,10.14952},
	{2095.62646 ,1288.78992 ,10.82031},
	{1975.59705, 1789.38562, 12.51975},
	{1953.64221 ,1342.71106, 15.37461},
	{1649.67114, 1124.87964, 10.82031},
	{1439.33826 ,1851.10291, 10.82031},
	{2165.79541 ,1014.68079 ,10.82031},
	{2195.37524, 2065.59180, 10.82031},
}


function createBag()
	local mt = math.random(#bag)
	ob = createObject(1210,bag[mt][1],bag[mt][2],bag[mt][3])
	setElementCollisionsEnabled(ob,false)
	time = setTimer(roo,100,0,ob)
	mar = createMarker(bag[mt][1],bag[mt][2],bag[mt][3],"corona",0.5,255,0,0,120)
	bl = createBlipAttachedTo(mar,17)
	setElementData(mar,"num",mt)
	exports.NGCdxmsg:createNewDxMessage(root,"The secret bag  Has Been Started",0,255,0,true)
end
addEventHandler("onResourceStart",resourceRoot,createBag)
addEventHandler("onMarkerHit",mar,
	function (hitElement, matchingDimension)
			if (getElementType(hitElement) == "player") then
			    if isPlayerInTeam(hitElement, "Staff") then return end
				local x,y,z = getElementPosition(player)
				local data = getElementData(mar,"num")
				local data = tonumber(data)
				destroyElement(mar)
				destroyElement(ob)
				destroyElement(bl)
				killTimer(time)
				setElementData(player,"bag",true)
				atBag = createObject(1210,x,y,z)
				setElementData(atBag,"num",data)
				exports.bone_attach:attachElementToBone(atBag,player,12,0,0.05,0.27,0,180,0)
				bli = createBlipAttachedTo(player,17)
				exports.NGCdxmsg:createNewDxMessage(root,"" .. getPlayerName(player) .. " Has Take The Secret Bag",0,255,0,true)
				marker = createMarker(mark[data][1],mark[data][2],mark[data][3],"cylinder",1.5,255,255,0,255,player)
				marBli = createBlipAttachedTo(marker,12,2,255,0,0,255,0,99999.0,player)
			end
		end
	end
)

function roo(ele)
	local x,y,z = getElementRotation(ele)
	setElementRotation(ele,x,y,z + 5)
end

addEventHandler("onPlayerWasted",root,
	function ()
		if getElementData(source,"bag") and getElementData(source,"bag") == true then
			local data = getElementData(atBag,"num")
			local data = tonumber(data)
			local x,y,z = getElementPosition(source)
			setElementData(source,"bag",false)
			destroyElement(atBag)
			destroyElement(marker)
			destroyElement(bli)
			destroyElement(marBli)
			ob = createObject(1210,x,y,z)
			setElementCollisionsEnabled(ob,false)
			time = setTimer(roo,100,0,ob)
			mar = createMarker(x,y,z,"corona",0.5,255,0,0,120)
			setElementData(mar,"num",data)
			bl = createBlipAttachedTo(mar,17)
		end
	end
)

addEventHandler("onMarkerHit",root,
	function (player)
		if ( source == marker ) then
			if getElementType(player) == "player" then
				setElementData(player,"bag",false)
				destroyElement(marker)
				destroyElement(marBli)
				destroyElement(bli)
				destroyElement(atBag)
				exports.NGCdxmsg:createNewDxMessage(root,"" .. getPlayerName(player) .. " Has Won 18000$ From The Secret Bag",255,0,0,true)
				givePlayerMoney(player,18000)
				triggerClientEvent(player,"onShowMoney",player)
				setTimer(createBag,900000,1)
			end
		end
	end
)

addEventHandler("onVehicleStartEnter",root,
	function (player)
		if getElementData(player,"bag") and getElementData(player,"bag") == true then
			cancelEvent()
			exports.NGCdxmsg:createNewDxMessage(player,"You Can't Enter The Vehicle You Have The Secret Bag",255,0,0,true)
		end
	end
)

addEventHandler("onPlayerQuit",root,
	function ()
		if getElementData(source,"bag") and getElementData(source,"bag") == true then
			local data = getElementData(atBag,"num")
			local data = tonumber(data)
			local x,y,z = getElementPosition(source)
			setElementData(source,"bag",false)
			destroyElement(atBag)
			destroyElement(marker)
			destroyElement(bli)
			destroyElement(marBli)
			ob = createObject(1210,x,y,z)
			setElementCollisionsEnabled(ob,false)
			time = setTimer(roo,100,0,ob)
			mar = createMarker(x,y,z,"corona",0.5,255,0,0,120)
			setElementData(mar,"num",data)
			bl = createBlipAttachedTo(mar,17)
		end
	end
)
