local tables = {
	{2246.16,-1923.84,13.54,268,90},
	{2203.22,-2036.78,13.54,45,310},
	{2445.7,-2033,13.54,268,91},
	{2519.89,-1958.32,13.62,265,91},
	{2450.68,-1785.64,13.54,269,91},
	{2383.8,-1467.01,24,270,91},
	{2335.98,-1319.29,24.09,272,91},
	{2475.52,-1202.5,36.26,272,91},
	{2520.6,-1107.33,56.2,268,91},
	{2392.33,-1211.42,27.15,271,91},
	{2169.24,-1492.09,23.98,268,91},
	{2276.51,-1672.32,15.21,272,91},
	{2369.51,-1641.01,13.49,270,91},
	{2423.98,-1643.3,13.49,271,91},
	{2441.06,-1688.67,13.8,264,96},
}

addEvent("drugLabGiven",true)
addEventHandler("drugLabGiven",root,function(plr,d1,d2,d3,taken,given)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		exports.CSGdrugs:takeDrug(plr,d1,taken)
		exports.CSGdrugs:takeDrug(plr,d2,taken)
		exports.CSGdrugs:giveDrug(plr,d3,given*2)
		exports.NGCdxmsg:createNewDxMessage(plr,"We have exchanged ("..taken.." hits) of "..d1.." & "..d2.." for "..given.."*2 hits of "..d3,0,255,0)
		exports.NGCdxmsg:createNewDxMessage(plr,"You are wanted by 2 stars!",0,255,0)
		exports.server:givePlayerWantedPoints(plr,25)
		local x,y,z = getElementPosition(plr)
		local zone = getZoneName(x,y,z)
		msgLaw(getPlayerName(plr).." (x"..getPlayerWantedLevel(plr)..") just crafted drugs at "..zone)
	else
		exports.NGCdxmsg:createNewDxMessage(plr,"You are lagging , try again later",255,0,0)
	end
end)


-- 941
local objects = {}
local labs = {}

function hitMarker(hitElement,dim)
	if not dim then return false end
	if hitElement and getElementType(hitElement) == "player" then
		if not isPedInVehicle(hitElement) then
			if getTeamName(getPlayerTeam(hitElement)) == "Criminals" then
				if not getElementData(hitElement,"isPlayerMakingDrugs") then
					setElementData(hitElement,"markerID",getElementData(source,"markerID"))
					setElementData(hitElement,"markerElement",source)
					setElementData(hitElement,"isPlayerMakingDrugs",true)
					triggerClientEvent(hitElement,"showDrugLab",hitElement)
				end
			else
				exports.NGCdxmsg:createNewDxMessage(hitElement,"You must be criminal to make drugs!",255,0,0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(hitElement,"You can't make drugs while inside a vehicle!",255,0,0)
		end
	end
end
local con = 0
for k,v in ipairs(tables) do
	local x,y,z,rot = v[1],v[2],v[3],v[4]
	local object = createObject(936,x,y,z-0.5,0,0,-rot)
	local marker = createMarker(x+1.5,y,z-1,"cylinder",1.5,255,0,0,50)
	con = con + 1
	setElementData(marker,"markerID",con)
	setElementData(marker,"rot",rot)
	addEventHandler("onMarkerHit",marker,hitMarker)
	table.insert(labs,marker)
end


addEvent("playerJustMadeDrugs",true)
addEventHandler("playerJustMadeDrugs",root,function(name)
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		exports.CSGdrugs:giveDrug(source,name,35)
		exports.server:givePlayerWantedPoints(source,25)
		triggerClientEvent(source,"destroyMakeShop",source)
		setElementData(source,"markerID",false)
		setElementData(source,"markerElement",false)
		setElementData(source,"isPlayerMakingDrugs",false)
		local x,y,z = getElementPosition(source)
		local zone = getZoneName(x,y,z)
		msgLaw(getPlayerName(source).." (x"..getPlayerWantedLevel(source)..") just made drugs at "..zone)
		exports.NGCdxmsg:createNewDxMessage(source,"You have made 35 hits of "..name.." + 2 wanted stars!",255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"You are lagging , try again later",255,0,0)
	end
end)

function removeLab(player)
	triggerClientEvent(player,"destroyCraftShop",player)
	triggerClientEvent(player,"destroyMakeShop",player)
	setElementData(player,"markerID",false)
	setElementData(player,"markerElement",false)
	setElementData(player,"isPlayerCrafting",false)
	setElementData(player,"isPlayerMakingDrugs",false)
end

addEventHandler("onPlayerWasted",root,function()
	local player = source
	triggerClientEvent(player,"destroyCraftShop",player)
	triggerClientEvent(player,"destroyMakeShop",player)
	setElementData(player,"markerID",false)
	setElementData(player,"markerElement",false)
	setElementData(player,"isPlayerCrafting",false)
	setElementData(player,"isPlayerMakingDrugs",false)
end)


addEvent ( "onPlayerNightstickHit" )
addEventHandler ( "onPlayerNightstickHit", root,
function ( theCop )
	if ( getPlayerTeam( source ) ) then
		if ( getElementData ( source, "isPlayerMakingDrugs" ) ) then
			if ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) then
				if getPedWeapon(theCop) == 3 then
					removeLab(source)
				end
			end
		end
	end
end
)

function msgLaw(msg)
	for k,v in ipairs(getElementsByType("player")) do
		if exports.DENlaw:isLaw(v) then
			exports.killmessages:outputMessage(msg,v,205,0,0,"arial")
		end
	end
end

addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		setElementData(v,"isPlayerCrafting",false)
		setElementData(v,"isPlayerMakingDrugs",false)
		setElementData(v,"markerID",false)
		setElementData(v,"markerElement",false)
	end
end)
