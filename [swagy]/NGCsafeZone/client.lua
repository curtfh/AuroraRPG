local screenWidth, screenHeight = guiGetScreenSize()
rectangleAlpha = 170
rectangleAlpha2 = 170
textAlpha = 255
textAlpha2 = 255
local screenW, screenH = guiGetScreenSize()

function dxDraw( text, wh, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if not wh then wh = 1.5 end
	dxDrawText ( text, x - wh, y - wh, w - wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true) -- black
	dxDrawText ( text, x + wh, y - wh, w + wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y + wh, w - wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y + wh, w + wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y, w - wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y, w + wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y - wh, w, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y + wh, w, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

--local LV = createColPolygon( 1559, 1801, 1559, 1801, 1558, 1910, 1674, 1910, 1681, 1806 ) -- LV Hospital
local LVfix = createColRectangle(1701.27,1809.1,20,54)
local LVfix2 = createColRectangle(1721.27,1819.1,15,43)
local LVfix3 = createColRectangle(1735.27,1824.1,17,39)
local LV = createColRectangle( 1558.21, 1703.07, 145,160 ) -- LV desert Hospital
local LVE = createColRectangle( -358, 1000, 80, 80 ) -- LV desert Hospital
local LVW = createColTube( 1240, 330, 8572, 100, 50 )  -- LV west Hospital
local LVW2 = createColTube( 1240, 330, 18, 100, 50 )  -- LV west Hospital
local LVD = createColRectangle (-1537.49, 2507.3, 52, 54) --SFLV
local SF2 = createColTube(  -255.15, 2602.57, 58,50,50 ) -- SF deck
local SF3 = createColTube(  -255.15, 2602.57, 8572,50,50 ) -- SF deck
local SF1 = createColRectangle( -2745, 576, 150, 120 ) -- SF Hospital
local jailPremCol = createColCircle(909.12, -2402.33,100)

local AP = createColSphere (-2195.87, -2303.28, 8574, 40) -- Angle Pine
local AP2 = createColSphere (-2195.87, -2303.28, 30.62, 40) -- Angle Pine

local AS = createColRectangle( 1162.87, -1384.79, 83, 93 ) --- All Saints Hospital
local JF = createColRectangle( 1980, -1454, 125, 80 ) -- Jefferson Hospital

local LVM = createColRectangle( 1937.48, 2139.54, 50, 60 ) -- LV mechanic
local LVMOD = createColRectangle(1979.84, 2052.53,17,10) -- LV MODshop
local LVPD = createColSphere (2269.787109375,2454.8581542969,10.8203125, 60) -- Angle Pine
local minerCol = createColSphere (-267.11,2082.23,-13.82, 240)
local jail = createColSphere (950.83, -2307.34, 738.97, 230)
local jail2 = createColSphere (748.13,-2454.58,910.1, 60)
local djstuff = createColSphere (570,-1853.15,7.42, 150)

local zones = { LVfix,LVfix2,LVfix3, LV, LVE, LVW,LVW2, AS, JF, SF1, SF2,SF3, LVM,AP,AP2,LVD,LVMOD,jailPremCol,minerCol,jail, jail2, djstuff}

function isElementWithinSafeZone( element )
	if ( not isElement( element ) ) then return false end
	if getElementDimension(element) > 3 then return end
	for i, zone in pairs( zones ) do
		if ( isElementWithinColShape( element, zone ) ) then
			setElementData(element,"isPlayerProtected",true)
			return true
		end
	end
	return false
end

addEventHandler("onClientRender",root,function()
	if isElementWithinSafeZone(localPlayer) then
		dxDraw("Protected Zone", 1.75, (screenW - 504) / 2, (screenH - 50) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,255,255, 195), 0.7, "pricedown", "center", "center", false, false, true, false, false)
		if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) then return end
		if ( exports.DENlaw:isPlayerLawEnforcer( localPlayer ) ) then
			if (getPedWeaponSlot(localPlayer) == 2  or getPedWeaponSlot(localPlayer) == 1) then
				return false
				else
				setPedWeaponSlot( localPlayer, 1 ) 
			end 
			if getPedWeapon ( localPlayer, 2 ) ~= 23 then 
				setPedWeaponSlot( localPlayer, 1 )
			end 
		elseif ((getTeamName(getPlayerTeam(localPlayer))) == "Paramedics" or getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" and exports.server:getPlayerOccupation(localPlayer) == "Firefighter") then
			setPedWeaponSlot( localPlayer, 9 )
		else
			setPedWeaponSlot( localPlayer, 0 )
			toggleControl("fire",false)
			toggleControl("aim_weapon",false)
		end
	end
end)

function zoneEntry( element, matchingDimension )
	if (matchingDimension) then
		setElementData(element,"isPlayerProtected",true)
	end
	if ( element ~= localPlayer or not matchingDimension ) then return end
	if getElementDimension(localPlayer) > 3 then return end
	exports.NGCdxmsg:createNewDxMessage( "You have entered the protected area!", 0, 255, 0 )
	if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) then return end
	if ( exports.DENlaw:isPlayerLawEnforcer( localPlayer ) ) then
		setPedWeaponSlot( localPlayer, 1 )
	elseif ( (getTeamName(getPlayerTeam(localPlayer))) == "Paramedics" or  (getTeamName(getPlayerTeam(localPlayer))) == "Civilian Workers" and exports.server:getPlayerOccupation(localPlayer) == "Firefighter") then
		setPedWeaponSlot( localPlayer, 9 )
	else
		setPedWeaponSlot( localPlayer, 0 )
		toggleControl("fire",false)
		toggleControl("aim_weapon",false)
	end
end

function zoneExit( element, matchingDimension )
	for i, zone in pairs( zones ) do
		if not ( isElementWithinColShape( element, zone ) ) then
			setElementData(element,"isPlayerProtected",false)
		end
	end
	if ( element ~= localPlayer or not matchingDimension ) then return end
	if getElementDimension(localPlayer) > 3 then return end
	exports.NGCdxmsg:createNewDxMessage( "You have left the protected area!", 0, 255, 0 )
	setElementData(localPlayer,"isPlayerProtected",false)
	if getElementData(localPlayer,"isPlayerArrested") then
		return
	else
		toggleControl("aim_weapon",true)
		if getElementData(localPlayer,"fire") then
			exports.NGCdxmsg:createNewDxMessage("You have been detected as user in F10 , please wait 10 seconds to be able to fire",255,0,0)
			return false
		end
		toggleControl("fire",true)
	end
end

for i, zone in pairs( zones ) do
	addEventHandler( "onClientColShapeHit", zone, zoneEntry )
	addEventHandler( "onClientColShapeLeave", zone, zoneExit )
	addEventHandler( "onClientPreRender", zone, zoneExit )
end


addEventHandler( "onClientPlayerWeaponSwitch", localPlayer,
	function ( prevSlot, newSlot )
		if getTeamName( getPlayerTeam( localPlayer ) ) ~= "Staff" and getElementAlpha(localPlayer) < 200 then
			if (exports.AURaghost:isPlayerInGhostMode(localPlayer)) then return end
			setPedWeaponSlot( localPlayer, 0 )
			exports.NGCdxmsg:createNewDxMessage( "[Please Wait]: You are not allowed to use weapons in the ghost mode!", 0, 255, 0 )
		end
		if ( not isElementWithinSafeZone( localPlayer ) ) then return end
		if (getElementDimension(localPlayer) ~= 2 or getElementDimension(localPlayer) ~= 0) then return end
		if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Staff" ) then return end
		if ( exports.DENlaw:isPlayerLawEnforcer( localPlayer ) ) then
			if (getPedWeaponSlot(localPlayer) == 2  or getPedWeaponSlot(localPlayer) == 1) then
				return false
				else
				setPedWeaponSlot( localPlayer, 1 ) 
				toggleControl("aim_weapon",true)
			end 
			if getPedWeapon ( localPlayer, 2 ) ~= 23 then 
				setPedWeaponSlot( localPlayer, 1 )
				toggleControl("aim_weapon",true)
			end 
			if getElementData(localPlayer,"fire") then
				exports.NGCdxmsg:createNewDxMessage("You have been detected as user in F10, please wait 10 seconds to be able to fire",255,0,0)
				return false
			end
			toggleControl("fire",true)
		elseif ( (getTeamName(getPlayerTeam(localPlayer))) == "Paramedics" or (getTeamName(getPlayerTeam(localPlayer))) == "Civilian Workers" and exports.server:getPlayerOccupation(localPlayer) == "Firefighter") then
			setPedWeaponSlot( localPlayer, 9 )

			toggleControl("aim_weapon",true)
			if getElementData(localPlayer,"fire") then
				exports.NGCdxmsg:createNewDxMessage("You have been detected as user in F10 , please wait 10 seconds to be able to fire",255,0,0)
				return false
			end
			toggleControl("fire",true)
		else
			exports.NGCdxmsg:createNewDxMessage( "[Exit the zone]: You are not allowed to use weapons in the protected area!", 0, 255, 0 )
			setPedWeaponSlot( localPlayer, 0 )
			toggleControl("fire",false)
			toggleControl("aim_weapon",false)
		end
	end
)

vehicleMsg = {}
vehicleTimer = {}

function addVehicleMsg(element)
	if vehicleMsg[element] == true then return false end
	if isTimer(vehicleTimer[element]) then return false end
	vehicleMsg[element] = true
	vehicleTimer[element] = setTimer(function(veh)
	vehicleMsg[veh] = false
	end,3000,1,element)
end

addEventHandler("onClientRender",getRootElement(),
function ()
	for i,v in ipairs(getElementsByType("vehicle")) do
		if vehicleMsg[v] == true then
			if isElementWithinSafeZone(v) then
				if getElementDimension(v) > 3 then return end
				local name = "You can't attack this vehicle in safe zone!"
				if ( not name ) then return end
				local x,y,z = getElementPosition(v)
				local cx,cy,cz = getCameraMatrix()
				if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 15 then
					local px,py = getScreenFromWorldPosition(x,y,z+1.3,0.06)
					if px then
						local width = dxGetTextWidth(name,1,"sans")
						local r,g,b = 255,0,0
						dxDrawBorderedText(name, px, py, px, py, tocolor(r, g, b, 255), 0.9, "sans", "center", "center", false, false)
					end
				end
			end
		end
	end
end)

addEventHandler("onClientRender",getRootElement(),
function ()
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"safezone") then
			if (getElementData(v,"wantedPoints") or 0) >= 10 then
				if getPlayerTeam(v) and getTeamName(getPlayerTeam(v)) == "Staff" then return false end
				if exports.DENlaw:isLaw(v) then return false end
				if getElementDimension(localPlayer) == 0 or getElementDimension(localPlayer) == 2 then
					if exports.DENlaw:isLaw(localPlayer) then
						local name = "You can't arrest this player yet"
						if ( not name ) then return end
						local x,y,z = getElementPosition(v)
						local cx,cy,cz = getCameraMatrix()
						if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 15 then
							local px,py = getScreenFromWorldPosition(x,y,z+1.3,0.06)
							if px then
								local width = dxGetTextWidth(name,1,"sans")
								local r,g,b = 255,0,0
								dxDrawBorderedText(name, px, py, px, py, tocolor(r, g, b, 255), 1, "sans", "center", "center", false, false)
							end
						end
					end
				end
			end
		end
	end
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

function isElementAllowed(element)
    if element and isElement(element) then
        if getElementType(element) == "player" then
            return true
        elseif getElementType(element) == "vehicle" then
            if getVehicleOccupant(element) and getElementType(getVehicleOccupant(element)) == "player" then
                return true
            end
        else
            return false
        end
    else
        return false
    end
end

function isPlayerDamaged(player)
    return (getTickCount() - getElementData(player, "ldt") < 10000)
end

--[[ Because Dwayne didn't compile it, we must use this to make sure no one has a copy of it
if ( fileExists( "safeZones.lua" ) ) then
	fileDelete( "safeZones.lua" )
end

function onDamage ()

	if (getElementType(source) == "player") then
		if (getElementData(source, "isPlayerProtected")) then
			cancelEvent()
		end
	end
end
addEventHandler("onClientPlayerDamage", root, onDamage)]]