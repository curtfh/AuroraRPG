--[[
Server Name: AuroraRPG
Resource Name: AURjob_miner
Version: 1.0
Developer/s: Curt
]]--
local marker
local blipMarkerAttached
local cached_table
local mines = 0
local bombobject
local detectorjetpack 
local theTimerDone 
local stuck = false
local cursorCheckTimer
local alreadyMinedPlant = false
local abuseLimitTimer

local screenW, screenH = guiGetScreenSize()
GUIEditor = {
    button = {},
    buttonMine = {},
    window = {},
    staticimage = {}
}


function getPositionInfrontOfElement(element, meters)
    if (not element or not isElement(element)) then return false end
    local meters = (type(meters) == "number" and meters) or 3
    local posX, posY, posZ = getElementPosition(element)
    local _, _, rotation = getElementRotation(element)
    posX = posX - math.sin(math.rad(rotation)) * meters
    posY = posY + math.cos(math.rad(rotation)) * meters
    rot = rotation + math.cos(math.rad(rotation))
    return posX, posY, posZ-1 , rot
end		

function theMiningGUIChocies ()
	mines = 0
	GUIEditor.window[1] = guiCreateWindow((screenW - 204) / 2, (screenH - 209) / 2, 204, 209, "AuroraRPG - Mining", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.button[1] = guiCreateButton(10, 34, 186, 56, "Plant a bomb", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(10, 100, 186, 56, "Peaceful Mine", false, GUIEditor.window[1])
	GUIEditor.button[3] = guiCreateButton(10, 170, 184, 29, "Close", false, GUIEditor.window[1])
	addEventHandler("onClientGUIClick", GUIEditor.button[1], plantingBombMine, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[1], openCloseGUI1, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[3], openCloseGUI1, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[2], openCloseGUI2, false)
end 

function theMiningGUI ()
	if (isElement(GUIEditor.window[2])) then 
		guiSetVisible(GUIEditor.window[2], true)
		return
	end 
	GUIEditor.window[2] = guiCreateWindow((screenW - 636) / 2, (screenH - 546) / 2, 636, 546, "AuroraRPG - Mining", false)
	guiWindowSetSizable(GUIEditor.window[2], false)
	GUIEditor.buttonMine[2] = guiCreateButton(30, 36, 276, 229, "", false, GUIEditor.window[2])
	GUIEditor.staticimage[1] = guiCreateStaticImage((276 - 221) / 2, (229 - 191) / 2, 221, 191, "rock1.png", false, GUIEditor.buttonMine[2])
	GUIEditor.buttonMine[3] = guiCreateButton(333, 36, 276, 229, "", false, GUIEditor.window[2])
	GUIEditor.staticimage[2] = guiCreateStaticImage((276 - 192) / 2, (229 - 168) / 2, 192, 168, "rock2.png", false, GUIEditor.buttonMine[3])
	GUIEditor.buttonMine[4] = guiCreateButton(30, 275, 276, 229, "", false, GUIEditor.window[2])
	GUIEditor.staticimage[3] = guiCreateStaticImage((276 - 211) / 2, (229 - 186) / 2, 211, 186, "rock2.png", false, GUIEditor.buttonMine[4])
	GUIEditor.buttonMine[5] = guiCreateButton(333, 275, 276, 229, "", false, GUIEditor.window[2])
	GUIEditor.staticimage[4] = guiCreateStaticImage((276 - 208) / 2, (229 - 190) / 2, 208, 190, "rock1.png", false, GUIEditor.buttonMine[5])
	GUIEditor.buttonMine[1] = guiCreateButton(241, 514, 148, 23, "Close", false, GUIEditor.window[2])  
	
	addEventHandler("onClientGUIClick", GUIEditor.buttonMine[1], openCloseGUI2, false)
	guiSetEnabled(GUIEditor.staticimage[1], false)
	guiSetEnabled(GUIEditor.staticimage[2], false)
	guiSetEnabled(GUIEditor.staticimage[3], false)
	guiSetEnabled(GUIEditor.staticimage[4], false)
	addEventHandler("onClientGUIClick", GUIEditor.buttonMine[2], mineButton, false)
	addEventHandler("onClientGUIClick", GUIEditor.buttonMine[3], mineButton, false)
	addEventHandler("onClientGUIClick", GUIEditor.buttonMine[4], mineButton, false)
	addEventHandler("onClientGUIClick", GUIEditor.buttonMine[5], mineButton, false)
end 

function plantingBombMine ()
	if isPedInVehicle (getLocalPlayer()) then
		return
	end 
	if (alreadyMinedPlant == true) then 
		exports.NGCdxmsg:createNewDxMessage("Cannot plant it again.", 255, 250, 0)
		return 
	end
	if (isTimer(abuseLimitTimer)) then 
		return false
	end
	alreadyMinedPlant = true
	setPedAnimation(getLocalPlayer(), "bomber", "bom_plant_loop", -1, true, false, false, false)
	setElementFrozen (getLocalPlayer(), true)
	exports.CSGprogressbar:createProgressBar("Planting Bomb...", 350, "aurjob_miner.donePlantingBomb")
	local x, y, z, rot = getPositionInfrontOfElement(getLocalPlayer(), 1)
	bombobject = createObject (1252, x, y, z)
	destroyElement(marker)
	abuseLimitTimer = setTimer(checkCursor, 400, 1)
	detectorjetpack = setTimer(function()
		triggerServerEvent("aurjob_miner.jetpackdetector", resourceRoot)
		setElementFrozen (getLocalPlayer(), true)
	end, 2000, 0)
	toggleAllControls (false, false, false) 
end 

function mineButton ()
	if (isElement(source)) then 
		if (isTimer(abuseLimitTimer)) then 
			return false
		end
		destroyElement(source)
		guiSetVisible(GUIEditor.window[2], false)
		showCursor(false)
		exports.CSGprogressbar:createProgressBar("Mining...", 80, "aurjob_miner.donePeacefulMining")
		abuseLimitTimer = setTimer(checkCursor, 400, 1)
		setPedAnimation(getLocalPlayer(), "baseball", "bat_4", -1, true, false, false, false)
		mines = mines + 1
	end
end 

function checkCursor ()
	if (isCursorShowing(getLocalPlayer())) then 
		showCursor(true)
	end 
end 


function openCloseGUI1 ()
	if isPedInVehicle (getLocalPlayer()) then
		return
	end 
	if (isElement(GUIEditor.window[2])) then 
		openCloseGUI2()
	else 
		if (isElement(GUIEditor.window[1])) then 
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			setElementFrozen (getLocalPlayer(), false)
			toggleAllControls (false, false, false) 
			if (isTimer(cursorCheckTimer)) then 
				killTimer(cursorCheckTimer)
			end 
		else
			showCursor(true)
			 if (not isTimer(cursorCheckTimer)) then 
				cursorCheckTimer = setTimer(checkCursor, 1000, 0)
			end 
			theMiningGUIChocies()
			setElementFrozen (getLocalPlayer(), true)
			toggleAllControls (true, true, true) 
		end 
	end 	
end 

function openCloseGUI2 ()
	if isPedInVehicle (getLocalPlayer()) then
		return
	end 
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
	end 
	if (isElement(GUIEditor.window[2])) then 
		if (mines == 4) then 
			destroyElement(GUIEditor.window[2])
			startJob()
			showCursor(false)
			setElementFrozen (getLocalPlayer(), false)
			toggleAllControls (false, false, false) 
			if (isTimer(cursorCheckTimer)) then 
				killTimer(cursorCheckTimer)
			end 
		else 
			if (guiGetVisible(GUIEditor.window[2]) == true) then 
				guiSetVisible(GUIEditor.window[2], false)
				showCursor(false)
				setElementFrozen (getLocalPlayer(), false)
				toggleAllControls (false, false, false) 
				if (isTimer(cursorCheckTimer)) then 
					killTimer(cursorCheckTimer)
				end 
			else 
				guiSetVisible(GUIEditor.window[2], true)
				showCursor(true)
				setElementFrozen (getLocalPlayer(), true)
				toggleAllControls (true, true, true) 
				if (not isTimer(cursorCheckTimer)) then 
					cursorCheckTimer = setTimer(checkCursor, 1000, 0)
				end 
			end 
		end 
	else
		showCursor(true)
		theMiningGUI()
		setElementFrozen (getLocalPlayer(), true)
		toggleAllControls (true, true, true) 
	end 
end 

function stop (theTable)
	if (isTimer(theTimerDone)) then
		killTimer(theTimerDone)
	end
	if (isElement(marker)) then 
		destroyElement(marker)
		destroyElement(blipMarkerAttached)
	end 
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
	end 
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
	end 
	mines = 0
end 
addEvent("aurjob_miner.stop", true)
addEventHandler("aurjob_miner.stop", localPlayer, stop)

function startJob (theTable)
	if isPedInVehicle (getLocalPlayer()) then
		return
	end 
	if (theTable == nil or theTable == "") then 
		if (cached_table ~= nil or cached_table ~= "") then
			theTable = cached_table
		end 
	else 
		theTable = fromJSON(theTable)
		cached_table = theTable
	end 
	
	
	if (isElement(marker)) then 
		destroyElement(marker)
		destroyElement(blipMarkerAttached)
	end 
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
		mines = 0
	end 
	local randomPick = math.random(#theTable)
	marker = createMarker (theTable[randomPick][1], theTable[randomPick][2], theTable[randomPick][3]-1, "cylinder", 1.5, 255, 250, 0, 200)
	blipMarkerAttached = createBlipAttachedTo(marker, 0, 3, 204, 22, 173)
	exports.NGCdxmsg:createNewDxMessage("Go to the big color purple blip to start mining.", 255, 250, 0)
	addEventHandler("onClientMarkerHit", marker, onMiningMarkerHit)
end 
addEvent("aurjob_miner.JobStart", true)
addEventHandler("aurjob_miner.JobStart", localPlayer, startJob)

function onMiningMarkerHit (player)
	if isPedInVehicle (getLocalPlayer()) then
		return
	end 
	if (player ~= getLocalPlayer()) then return end
	if (not isPedOnGround(player)) then return end
	if (isElement(marker)) then 
		local px,py,pz = getElementPosition (player)
		local mx, my, mz = getElementPosition (source)
		if ((pz-1.5 < mz) and (pz+1.5 > mz)) then
			openCloseGUI1 ()
		end 
	end 
end 

function donePeacefulMining ()
	if isPedInVehicle (getLocalPlayer()) then
		return
	end 
	if (isTimer(abuseLimitTimer)) then 
		return false
	end
	if (isElement(GUIEditor.window[2])) then 
		guiSetVisible(GUIEditor.window[2], true)
		showCursor(true)
		setPedAnimation(getLocalPlayer(), false)
		triggerServerEvent("aurjob_miner.doneWork", resourceRoot, false)
	end 
end 
addEvent("aurjob_miner.donePeacefulMining", true)
addEventHandler("aurjob_miner.donePeacefulMining", localPlayer, donePeacefulMining)

function handleInterrupt( status, ticks )
	if (status == 0) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago" )
			if (stuck == false) then 
				stuck = true
			end 
	elseif (status == 1) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago and has just ended" )
		if (stuck == true) then 
			stuck = false
		end
	end
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)

function donePlantingBomb ()
	if isPedInVehicle (getLocalPlayer()) then
		return
	end 
	if (isTimer(detectorjetpack)) then 
		killTimer(detectorjetpack)
	end 
	if (isTimer(abuseLimitTimer)) then 
		return false
	end
	toggleAllControls (true, true, true) 
	exports.NGCdxmsg:createNewDxMessage("Get out of the way the bomb will explode in 10 seconds.", 255, 0, 0)
	if (isElement(marker)) then  
		destroyElement(marker)
	end
	setElementFrozen (getLocalPlayer(), false)
	setPedAnimation(getLocalPlayer(), false)
	if (isTimer(theTimerDone)) then 
		destroyElement(blipMarkerAttached)
		startJob()
		exports.NGCdxmsg:createNewDxMessage("Cannot generate final job due to timer is still enabled.", 255, 0, 0)
		return 
	end
	theTimerDone = setTimer(function()
		if (stuck == true) then
			setElementFrozen (getLocalPlayer(), false)
			destroyElement(blipMarkerAttached)
			startJob()
			killTimer(theTimerDone)
			exports.NGCdxmsg:createNewDxMessage("Cannot generate payment due to your lagging.", 255, 0, 0)
			return
		end
		alreadyMinedPlant = false
		local x,y,z = getElementPosition(bombobject)
		createExplosion (x, y, z, 2, true, 1, false)
		setElementFrozen (getLocalPlayer(), false)
		destroyElement(bombobject)
		destroyElement(blipMarkerAttached)
		exports.NGCdxmsg:createNewDxMessage("Boom!", 255, 0, 0)
		startJob()
		killTimer(theTimerDone)
		triggerServerEvent("aurjob_miner.doneWork", resourceRoot, true)
	end, 10000, 1)
end 
addEvent("aurjob_miner.donePlantingBomb", true)
addEventHandler("aurjob_miner.donePlantingBomb", localPlayer, donePlantingBomb)