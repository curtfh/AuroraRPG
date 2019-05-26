


-------------------- THIS CODE WILL FUCK MECHANIC JOB



local LVM = createColRectangle( 1937.48, 2139.54, 40, 40 ) -- LV mechanic
local LSM = createColRectangle( 1670.93, -1062.47, 20, 20 ) -- LV mechanic
local SFM = createColRectangle( -1995.35, 240.06, 20, 20 ) -- LV mechanic
local SFPM = createColTube( -1187.39, 24.41, 13, 20, 20 ) -- LV mechanic
local LVPM = createColTube( 1532.73, 1736.07, 9, 20, 20 ) -- LV mechanic
local LSPM = createColTube( 2007.49, -2447.35, 12, 20, 20 ) -- LV mechanic
local zones = {LVM,LSM,SFM,SFPM,LVPM,LSPM}


--[[
setTimer(function()
	for index,vehicle in ipairs(getElementsByType("vehicle")) do --LOOP through all Vehicles
		for i, zone in pairs( zones ) do
			if isElementWithinColShape(vehicle,zone) then
				if getElementHealth(vehicle) <= 255 then
					setElementCollisionsEnabled(vehicle, false)
					setElementAlpha(vehicle,150)
				else
					setElementCollisionsEnabled(vehicle, true)
					setElementAlpha(vehicle,250)
				end
			end
		end
	end
end,5000,0)

addEvent("showAbusersAtServer",true)
addEventHandler("showAbusersAtServer",root,function(target,msg)
	outputChatBox(msg,source,255,0,0)
end)


function zoneExit(hitElement,matchdim)
	if not matchdim then return false end
	if hitElement and getElementType(hitElement) == "vehicle" then
		setElementCollisionsEnabled(hitElement, true)
		setElementAlpha(hitElement,250)
	end
end


for i, zone in pairs( zones ) do
	addEventHandler( "onColShapeLeave", zone, zoneExit )
end]]


-- When a cop wants to arrest a player while robbing wat nog meer alleen de markers toch, en de int zelf pff we moeten een bankrob ik ga ff ig kijken of die mappers er zijn
addEvent ( "onPlayerNightstickHit" )
addEventHandler ( "onPlayerNightstickHit", root,
function ( theCop )
	if ( getPlayerTeam( source ) ) then
		if ( getElementData ( source, "safezone" ) ) then
			if getPedWeapon(theCop) == 3 then
				cancelEvent()
			end
		end
	end
end
)
