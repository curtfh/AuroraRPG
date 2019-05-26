function copyPos (command)
	local x, y, z = getElementPosition(getLocalPlayer())
	outputChatBox(x..", "..y..", "..z, player)
	setClipboard (x..", "..y..", "..z)
end 
addCommandHandler("copypos", copyPos)

local colLV = createColRectangle(866,480,2300,2800)

function isElementWithinSafeZone(element)
    if (not isElement(element)) then return false end
    if (getElementDimension(element) ~= 0) or (getElementInterior(element) ~= 0) then return false end
    if (isElementWithinColShape(element, colLV )) then return true end
    return false
end

function zoneEntry(element, matchingDimension)
    if (element ~= localPlayer) or (not matchingDimension) then return end
    if (getElementDimension(element) ~= 0) then return end
	setElementData(element, "AURdeathmatch.value", true)
end
addEventHandler("onClientColShapeHit", colLV , zoneEntry)

function zoneLeave(element, matchingDimension)
    if (element ~= localPlayer) or (not matchingDimension) then return end
    if (getElementDimension(element) ~= 0) then return end
	setElementData(element, "AURdeathmatch.value", false)
end
addEventHandler("onClientColShapeLeave", colLV , zoneLeave)

function cursorInfo()
   local showing = isCursorShowing ()
   if showing then -- if the cursor is showing
      local screenx, screeny, worldx, worldy, worldz = getCursorPosition()

      outputChatBox( string.format( "Cursor screen position (relative): X=%.4f Y=%.4f", screenx, screeny ) ) -- make the accuracy of floats 4 decimals
      outputChatBox( string.format( "Cursor world position: X=%.4f Y=%.4f Z=%.4f", worldx, worldy, worldz ) ) -- make the accuracy of floats 4 decimals accurate
   else
      outputChatBox( "Your cursor is not showing." )
   end
end
addCommandHandler( "cursorpos", cursorInfo )

setAmbientSoundEnabled("general", false)
setAmbientSoundEnabled("gunfire", false)


function getMoneyClientSide ()
	outputChatBox("Money_C: $"..getPlayerMoney(localPlayer))
end 
addCommandHandler("moneyc", getMoneyClientSide)
local autodetec
function notinvisible ()
	setElementAlpha(localPlayer, 255)
	if (isTimer(autodetec)) then return end 
	autodetec = setTimer(function()
		for index,vehicle in ipairs(getElementsByType("vehicle")) do
			setElementCollidableWith(vehicle, localPlayer, false)
		end
		for index,player in ipairs(getElementsByType("player")) do
			setElementCollidableWith(player, localPlayer, false)
		end
	end, 1000, 0)
end 
addEvent("AURcurtmisc2.notinvisible", true)
addEventHandler("AURcurtmisc2.notinvisible", localPlayer, notinvisible)

function stopinvisible ()
	if (isTimer(autodetec)) then 
		killTimer(autodetec)
	end 
	for index,vehicle in ipairs(getElementsByType("vehicle")) do
		setElementCollidableWith(vehicle, localPlayer, true)
	end
	for index,player in ipairs(getElementsByType("player")) do
		setElementCollidableWith(player, localPlayer, true)
	end
end 
addEvent("AURcurtmisc2.stopinvisible", true)
addEventHandler("AURcurtmisc2.stopinvisible", localPlayer, stopinvisible)

local radart
function radarTester (theCmd, sizex, sizey)
	local x, y, z = getElementPosition(getLocalPlayer())
	if (radart) then destroyElement(radart) end
	radart = createRadarArea (x, y, sizex, sizey, 255, 255, 255, 175 )
	outputChatBox(x..", "..y..", "..sizex..", "..sizey)
end 
addCommandHandler("radartest", radarTester)

addCommandHandler( "devmodeaur",
function ()
    setDevelopmentMode ( true )
end
)

function isPedDrivingVehicle(ped)
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ isPedDrivingVehicle [ped/player expected, got " .. tostring(ped) .. "]")
    local isDriving = isPedInVehicle(ped) and getVehicleOccupant(getPedOccupiedVehicle(ped)) == ped
    return isDriving, isDriving and getPedOccupiedVehicle(ped) or nil
end

local disabled = false 
setTimer(function()
	if (isPedDrivingVehicle(localPlayer)) then 
		if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then return false end
		if (getElementModel(getPedOccupiedVehicle(localPlayer)) == 520) then
			if (getElementData(localPlayer, "isPlayerInLvCol")) then  
				blowVehicle(getPedOccupiedVehicle(localPlayer), true)
				exports.AURstickynote:displayText("hydranotefuckoff", "text", "Hydra is diabled in LV Gangwars. So we blow up your hydra. Don't try to exploit it.", 200, 0, 0)
				setTimer(function()
					exports.AURstickynote:displayText("hydranotefuckoff", "text", "", 200, 0, 0)
				end, 60*1000, 1)
			end
		end
	end
end, 1000, 0)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
		if thePlayer == getLocalPlayer() then
			if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then return false end
			if (getElementModel(source) == 520) then
				if (getElementData(localPlayer, "isPlayerInLvCol")) then  
					blowVehicle(source, true)
					exports.AURstickynote:displayText("hydranotefuckoff", "text", "Hydra is diabled in LV Gangwars. So we blow up your hydra. Don't try to exploit it.", 200, 0, 0)
					setTimer(function()
						exports.AURstickynote:displayText("hydranotefuckoff", "text", "", 200, 0, 0)
					end, 60*1000, 1)
				end 
			end
        end
    end
)