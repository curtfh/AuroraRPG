local screenWidth, screenHeight = guiGetScreenSize()
rectangleAlpha = 170
rectangleAlpha2 = 170
textAlpha = 255
textAlpha2 = 255
local screenW, screenH = guiGetScreenSize()
local localPlayer = getLocalPlayer()
local timers = {}
local LVcol = createColRectangle(866,656,2100,2300)
local respawnTimer = 5000


---House respawn UI

GUIEditor = {
    gridlist = {},
    window = {},
    button = {}
}
GUIEditor.window[1] = guiCreateWindow(0.36, 0.23, 0.28, 0.54, "AUR House Respawn - House Selection", true)
guiWindowSetSizable(GUIEditor.window[1], false)

GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.06, 0.95, 0.82, true, GUIEditor.window[1])
guiGridListAddColumn(GUIEditor.gridlist[1], "House", 0.3)
guiGridListAddColumn(GUIEditor.gridlist[1], "Location", 0.3)
guiGridListAddColumn(GUIEditor.gridlist[1], "City", 0.3)
GUIEditor.button[1] = guiCreateButton(0.02, 0.89, 0.29, 0.08, "Spawn", true, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
GUIEditor.button[2] = guiCreateButton(0.69, 0.89, 0.28, 0.08, "Close", true, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")

guiSetVisible(GUIEditor.window[1], false)


local markers = {}



hospitals = {
	--{ x, y, z, rot},
	--LS
	{ 1178.7457275391, -1323.8264160156, 14.135261535645, 270, "All Saints"}, --All Saints
	{ 2032.7645263672, -1416.2613525391, 16.9921875, 132, "Jefferson"}, --Jefferson
	{ 1242.409, 327.797, 19.755, 332, "Montgomery"}, --Montgomery
	--- { 2269.598, -75.157, 26.772, 181, "Palimino Creek"}, custom hospital
	--SF
	{ -2201.1604003906, -2307.6457519531, 30.625, 320, "Whetstone"}, --Whetstone
	{ -2655.1650390625, 635.66253662109, 14.453125, 180, "Santa Flora"}, --Santa Flora
	--LV
	{ 1607.2800292969, 1818.4868164063, 10.8203125, 360, "Las Venturas"}, --LV Airport
	{ -1514.902, 2525.023, 55.783, 0, "El Quebrados"}, --El Quebrados
	{ -254.074, 2603.394, 62.858, 270, "Las Payasadas"}, --Las Payasadas
	{ -320.331, 1049.375, 20.340, 360, "Fort Carson"}, --Fort Carson
}


local doors={
{-321.23, 1049.76, 8574,"Hospital"}, -- forst
{-320.6, 1052.83, 8574,"Base"}, -- forst
{-321.15, 1046.54, 8574, "House"}, -- frost

{ 1578.72, 1800.56, 8574 ,"Hospital"}, -- LV air
{ 1578.72, 1798.56, 8574 ,"House"}, -- LV air
{ 1578.92, 1802.68, 8574 ,"Base"}, -- LV air
{ 1579, 1796.62, 8574 ,"Turfing"}, -- LV air

{ 1228.62, 349.72, 8574,"Hospital"}, -- "Montgomery"
{  1228.91, 352.87, 8574,"Base"}, -- "Montgomery"
{ 1228.85, 346.65, 8574, "House"}, -- Montgomery

{  -271.37, 2599.71, 8574,"Hospital"}, -- "Las penderas"
{   -271.09, 2602.78, 8574,"Base"}, -- "Las penderas"
{  -271.15, 2596.63, 8574, "House"}, -- "Las penderas"


{  -1521.03, 2549.8, 8574,"Hospital"}, -- "El Quebrados"
{   -1521.03, 2552.8, 8574,"Base"}, -- "El Quebrados
{ -1521.14, 2546.61, 8574, "House"}, -- El Quebrabos

{  -2671.39, 649.68, 8574,"Hospital"}, -- "Santa flora"
{  -2670.98, 652.72, 8574,"Base"}, -- "Santa flora
{ -2671.15, 646.64, 8574, "House"}, -- Sante flora

{  -2221.17, -2300.32, 8574,"Hospital"}, -- "angel"
{  -2221.1, -2297.29, 8574,"Base"}, -- "angel
{ -2221.15, -2303.45, 8574, "House"}, -- angel

{  2028.98, -1400.21, 8574,"Hospital"}, -- "Jefferson
{  2028.91, -1397.18, 8574,"Base"}, -- "Jefferson
{  2028.85, -1403.48, 8574, "House"}, -- Jeffreson

{  1178.61, -1350.29, 8574,"Hospital"}, -- "Saints
{  1178.91, -1347.11, 8574,"Base"}, -- "Saints
{ 1178.85, -1353.38, 8574, "House"}, -- All Saints


}


function findNearestHostpital(thePlayer)
  local nearest = nil
  local min = 999999
  for key,val in pairs(hospitals) do
    local xx,yy,zz=getElementPosition(thePlayer)
    local x1=val[1]
    local y1=val[2]
    local z1=val[3]
	local pR=val[4]
	local hN=val[5]
    local dist = getDistanceBetweenPoints2D(xx,yy,x1,y1)
    if dist<min then
      nearest = val
      min = dist
    end
  end
  return nearest[1],nearest[2],nearest[3],nearest[4],nearest[5],nearest[6],nearest[7],nearest[8]
end


bindKey("f","down",function()
	if getElementData(localPlayer,"isPlayerProtected") then
		local x,y,z = getElementPosition(localPlayer)
		if z >= 4000 then
			if getElementData(localPlayer,"isPlayerInLvCol") then
				local x,y,z,rot = 1607.2800292969, 1818.4868164063, 10.8203125,350
				triggerServerEvent("spawnToHospital",localPlayer,x,y,z,rot)
			else
				local x,y,z,rot = findNearestHostpital(localPlayer)
				triggerServerEvent("spawnToHospital",localPlayer,x,y,z,rot)
			end
		end
	end
end)

function openHouseRespawn(houses)

	guiSetVisible(GUIEditor.window[1], true)
	showCursor(true)
	guiGridListClear(GUIEditor.gridlist[1])
	for k,v in pairs (houses) do
		local row = guiGridListAddRow(GUIEditor.gridlist[1])
		local zone = getZoneName(v.x, v.y, v.z)
		local city = getZoneName(v.x, v.y, v.z, true)
		guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v.housename, false, false)
		guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, zone, false, false)
		guiGridListSetItemText(GUIEditor.gridlist[1], row, 3, city, false, false)
	end
end
addEvent("AURspawn:openHousesPanel", true)
addEventHandler("AURspawn:openHousesPanel", root, openHouseRespawn)

function closePanel ()

	if (source == GUIEditor.button[2]) then
		guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
	end
end
addEventHandler("onClientGUIClick", root, closePanel)

function hitDoors(hitElement,dim)
	if not dim then return false end
	if hitElement ~= localPlayer then return false end
	if hitElement and getElementType(hitElement) == "player" then
		if getElementData(source,"type") == "Hospital" then
			if getElementData(hitElement,"isPlayerInLvCol") then
				local x,y,z,rot = 1607.2800292969, 1818.4868164063, 10.8203125,350
				triggerServerEvent("spawnToHospital",hitElement,x,y,z,rot)
			else
				local x,y,z,rot = findNearestHostpital(hitElement)
				triggerServerEvent("spawnToHospital",hitElement,x,y,z,rot)
			end
		elseif getElementData(source,"type") == "Base" then
			triggerEvent("setGroupSpawn",localPlayer)
		elseif getElementData(source,"type") == "House" then
			triggerServerEvent("AURspawn:openHouseRespawn", hitElement)
		elseif getElementData(source,"type") == "Turfing" then
			local tm = getTeamName(getPlayerTeam(localPlayer))
			local gr = getElementData(localPlayer,"Group")
			if tm == "Criminals" or tm == "HolyCrap" then
				if gr then
					triggerServerEvent("spawnTurfingPlayer",localPlayer)
				else
					exports.NGCdxmsg:createNewDxMessage("You aren't in group",255,0,0)
				end
			elseif (tm == "Government" or tm == "SWAT Team" or tm == "Military Forces") then 
				triggerServerEvent("spawnTurfingPlayer",localPlayer)
			else
				exports.NGCdxmsg:createNewDxMessage("Only Criminals can pass from this door",255,0,0)
			end
		end
	end
end

for k,v in ipairs(doors) do
	markers[k] = createMarker(v[1],v[2],v[3],"arrow",1.5,255,150,0)
	setElementData(markers[k],"type",v[4])
	addEventHandler("onClientMarkerHit",markers[k],hitDoors)
end


addEvent( "onServerWasted", true)
addEventHandler( "onServerWasted", root,
	function (name,model)
	if source ~= localPlayer then return false end
		setElementDimension(localPlayer,0)
		setElementInterior(localPlayer,0)
		if isTimer(timers[localPlayer]) then return false end
		if getElementData(localPlayer,"isPlayerVIP") then
			triggerServerEvent("spawnPlayer",localPlayer,model)
			ghostmode(true)
		else
			timers[localPlayer] = setTimer(function()
			triggerServerEvent("spawnPlayer",localPlayer,model)
			ghostmode(true)
			end,respawnTimer,1)
		end
		addHospitalText2("You will be respawned to hospital")
		rectangleAlpha = 170
		rectangleAlpha2 = 170
		textAlpha = 255
		textAlpha2 = 255
		found = false 
	--end
end)

function ghostmode(state)
	if state == true then
		for index,player in ipairs(getElementsByType("player")) do --LOOP through all Vehicles
			setElementCollidableWith(player, localPlayer, false) -- Set the Collison off with the Other vehicles.
		end
		if isTimer(mk) then killTimer(mk) end
		mk = setTimer(function() ghostmode(false) end,18000,1)
	else
		for index,player in ipairs(getElementsByType("player")) do --LOOP through all Vehicles
			setElementCollidableWith(player, localPlayer,true) -- Set the Collison off with the Other vehicles.
		end
	end
end



addEventHandler("onClientPlayerSpawn",root,function()
	if isTimer(timers[source]) then killTimer(timers[source]) end
end)


function dxDrawBorderedText ( text, wh, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
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


function addHospitalText(msg)
	message = msg
	fadeTimer = setTimer(fadeTheText, 500, 0)
	removeEventHandler("onClientRender", root, drawHospitalText)
	addEventHandler("onClientRender", root, drawHospitalText)
end
addEvent("addHospitalText", true)
addEventHandler("addHospitalText", root, addHospitalText)


function addHospitalText2(msg)
	message = msg
	fadeTimer2 = setTimer(fadeTheText2, 500, 0)
	removeEventHandler("onClientRender", root, drawHospitalText2)
	addEventHandler("onClientRender", root, drawHospitalText2)
end

function fadeTheText()
	textAlpha = textAlpha - 8.5
	rectangleAlpha = rectangleAlpha - 8.5
	if (rectangleAlpha <= 0) then
		if isTimer(fadeTimer) then killTimer(fadeTimer) end
		removeEventHandler("onClientRender", root, drawHospitalText)
	end
end

function fadeTheText2()
	textAlpha2 = textAlpha2 - 8.5
	rectangleAlpha2 = rectangleAlpha2 - 8.5
	if (rectangleAlpha2 <= 0) then
		if isTimer(fadeTimer2) then killTimer(fadeTimer2) end
		removeEventHandler("onClientRender", root, drawHospitalText2)
	end
end

function drawHospitalText()
	dxDrawBorderedText(message, 1.75, (screenW - 504) / 2, (screenH - 290) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,0,80, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
end


function drawHospitalText2()
	if isTimer(timers[localPlayer]) then
	local minx,maxx,left = getTimerDetails(timers[localPlayer])
	local minx = math.floor(minx / 1000)
	dxDrawBorderedText(message.." in "..minx.." seconds", 1.75, (screenW - 504) / 2, (screenH - 290) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,0,80, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
	end
end


function dxDrawFramedText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top + 1, width + 1, height + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top - 1, width + 1, height - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top + 1, width - 1, height + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top - 1, width - 1, height - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
end


function drawKit()
	for k,v in ipairs(doors) do
		local x,y,z = v[1],v[2],v[3]
		local camX, camY, camZ = getCameraMatrix()
		if getDistanceBetweenPoints3D(camX, camY, camZ, x,y,z) < 20 then
			local scX, scY = getScreenFromWorldPosition(x,y,z + 0.7)
			if scX then
				ty = v[4]
				if ty == "Hospital" then
					dxDrawFramedText("Enter to respawn in hospital.", scX, scY, scX, scY, tocolor(255, 155,0, 255), 1.0, "default-bold", "center", "center", false, false, false)
				elseif ty == "House" then
					dxDrawFramedText("Enter to respawn in your house.", scX, scY, scX, scY, tocolor(30, 20,180, 255), 1.0, "default-bold", "center", "center", false, false, false)
				elseif ty == "Turfing" then
				
					local thePlrTeam = getTeamName(getPlayerTeam(getLocalPlayer()))
					if (thePlrTeam == "Government" or thePlrTeam == "SWAT Team" or thePlrTeam == "Military Forces") then 
						dxDrawFramedText("Enter to respawn in LVPD.", scX, scY, scX, scY, tocolor(0, 148, 255, 255), 1.0, "default-bold", "center", "center", false, false, false)
					else
						dxDrawFramedText("Enter to respawn in your turf.", scX, scY, scX, scY, tocolor(255, 0, 0, 255), 1.0, "default-bold", "center", "center", false, false, false)
					end 
					
				elseif ty == "Base" then
					dxDrawFramedText("Enter to respawn in your base.", scX, scY, scX, scY, tocolor(0, 255, 0, 255), 1.0, "default-bold", "center", "center", false, false, false)
				end
			end
		end
	end
	if getElementData(localPlayer,"isPlayerProtected") then
		local x,y,z = getElementPosition(localPlayer)
		if z >= 4000 then
			dxDrawBorderedText("Press F to respawn in hospital yard", 1.75, (screenW - 504) / 2, (screenH - 220) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,255,255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
		end
	end
end

function onChange(d)
	if (d == "isPlayerProtected") then
		local found = false 

		for i, v in ipairs(getEventHandlers("onClientRender", root)) do
			if (v == drawKit) then
				found = true
			end
		end

		if (getElementData(localPlayer, d)) then
			if (not found) then
				addEventHandler("onClientRender", root, drawKit)
			end
		else
			if (found) then
				removeEventHandler("onClientRender", root, drawKit)
			end
		end
	end
end
addEventHandler("onClientElementDataChange", localPlayer, onChange)

addEvent("setSpawnRotation",true)
addEventHandler("setSpawnRotation",root,function(rot)
	setElementRotation(localPlayer,0,0,rot)
	setTimer(function(r)
		setPedRotation(localPlayer,r)
	end,2000,1,rot)
	setPedRotation(localPlayer,rot)

end)

function houseSpawnButton ()

	if (source == GUIEditor.button[1]) then
		local selectedHouseRow, selectedHouseColumn = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
		if (selectedHouseRow == false) then return exports.NGCdxmsg:createNewDxMessage("You have to select a house first!",255,0,0) end
		local houseName = guiGridListGetItemText(GUIEditor.gridlist[1], selectedHouseRow, selectedHouseColumn)
		if not (houseName) then return exports.NGCdxmsg:createNewDxMessage("You have to select a house first!",255,0,0) end
		triggerServerEvent("AURspawn:spawnAtHouse", resourceRoot, localPlayer, houseName)
	end
end	
addEventHandler("onClientGUIClick", root, houseSpawnButton)

if ( fileExists( "hospital.lua" ) ) then
	fileDelete( "hospital.lua" )
end
