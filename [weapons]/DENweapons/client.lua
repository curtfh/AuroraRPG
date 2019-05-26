local LSCol = createColCircle(1387.45,-1292.89,18,25)
local LVCol = createColCircle(2179.53,951.39,11.09,25)

local markers = {
{1385.95,-1287.31,18,0,0},
{1386.1,-1288.78,18,0,0},
{1386.28,-1290.32,18,0,0},
{1386.05,-1291.71,18,0,0},
{1386.01,-1293.34,18,0,0},
{1386.31,-1294.8,18,0,0},
{1386.13,-1296.33,18,0,0},
{1386.39,-1297.97,18,0,0},
{2179.19,955.98,11.09,0,0},
{2179.19,954.45,11.09,0,0},
{2179.19,952.93,11.09,0,0},
{2179.19,951.42,11.09,0,0},
{2179.19,949.94,11.09,0,0},
{2179.19,948.47,11.09,0,0},
{2179.19,946.98,11.09,0,0},
{2179.19,945.30,11.09,0,0},
{289.24, -24.93, 1001.51, 1, 2},
{290.67, -25.15, 1001.51, 1, 2},
{292.22, -25.22, 1001.51, 1, 2},
{293.69, -25.00, 1001.51, 1, 2},
{295.21, -25.17, 1001.51, 1, 2},
{296.76, -25.07, 1001.51, 1, 2},
{298.17, -25.15, 1001.51, 1, 2},
{299.63, -25.16, 1001.51, 1, 2},
}

local pedCoords = {
[1] = {1410.51,-1285.26,18,88,0,0},
[2] = {1410.37,-1290.81,18,88,0,0},
[3] = {1410.21,-1296.98,18,79,0,0},
[4] = {1407.12,-1295.75,18,87,0,0},
[5] = {1407.02,-1292.12,18,89,0,0},
[6] = {1406.91,-1288.79,18,89,0,0},
[7] = {1402.39,-1283.66,18,89,0,0},
[8] = {1402.82,-1291,18,87,0,0},
[9] = {1402.05,-1296.67,18,79,0,0},
[10] = {1397.61,-1294.63,18,88,0,0},
[11] = {1395.01,-1288.48,18,87,0,0},
[12] = {1394.2,-1285.74,18,94,0,0}
}

local pedCoords2 = {
[1] = {2187.28,950.59,11.09,88},
[2] = {2187.31,946.99,11.09,85},
[3] = {2198.08,945.82,11.09,86},
[4] = {2197.93,949.33,11.09,91},
[5] = {2197.69,952.93,11.09,91},
[6] = {2197.46,956.2,11.09,91},
[7] = {2194.33,956.12,11.09,91},
[8] = {2190.75,957.31,11.09,91},
[9] = {2189.11,948.25,11.09,86},
[10] = {2186.39,953.89,11.09,41},
[11] = {2184.34,949.06,11.09,86},
[12] = {2199.35,950.53,11.09,90},
}

local pedCoords3 = {
[1] = {296.56, -11.83, 1001.51, 4, 5},
[2] = {292.73, -14.73, 1001.51, 4, 5},
[3] = {288.87, -12.69, 1001.51, 4, 5},
[4] = {290.76, -7.56, 1001.51, 4, 5},
[5] = {295.71, -6.91, 1001.51, 4, 5},
[6] = {295.72, -16.34, 1001.51, 4, 5},
[7] = {290.51, -17.84, 1001.51, 4, 5},
[8] = {285.87, -17.87, 1001.51, 4, 5},
[9] = {289.3, -12.77, 1001.51, 4, 5},
[10] = {298.1, -7.06, 1001.51, 4, 5},
[11] = {294.38, -19.18, 1001.51, 4, 5},
[12] = {288.65, -19.67, 1001.51, 4, 5}
}

local sx,sy = guiGetScreenSize()
local isPlayerDoingTest = false
local playerTestWeapon = nil
local theTestPeds = {}
local theTestPedsCount = 0

function createRangeWindow()
	guiRangeWindow = guiCreateWindow(133,280,365,344,"AUR ~ Ammu Nation Weapon Training",false)
	guiRangeLabel1 = guiCreateLabel(9,28,346,17,"Ammu Nation Weapon Trainings",false,guiRangeWindow)
	guiLabelSetColor(guiRangeLabel1,238	,154	,0)
	guiLabelSetHorizontalAlign(guiRangeLabel1,"center",false)
	guiSetFont(guiRangeLabel1,"default-bold-small")
	guiRangeLabel2 = guiCreateLabel(9,51,347,247,"Welcome to AUR Ammu-nation weapon range!\nHere you can improve your weapon skills.\nThe higher they are, the more advantages you will\nhave when using the weapon you trained with.\nWhen reaching 100% skill level with some weapons,\nyou will unlock the dual weapon mode.\nThis is possible with the Colt 45.\n\nObviously, you must use the same weapon you started with.\nShooting with other weapons will not work.\n\nEach shooting range round costs 250$ and if you succeed in\nkilling all the targets before the time ends,\nyou will increase your weapon skill by 50%.\n\nGood luck!",false,guiRangeWindow)
	guiLabelSetHorizontalAlign(guiRangeLabel2,"center",false)
	beginBtn = guiCreateButton(9,307,168,28,"Start Training!",false,guiRangeWindow)
	cancelBtn = guiCreateButton(184,307,168,28,"No Thanks!",false,guiRangeWindow)

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(guiRangeWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(guiRangeWindow,x,y,false)

	guiWindowSetMovable (guiRangeWindow, true)
	guiWindowSetSizable (guiRangeWindow, false)
	guiSetVisible (guiRangeWindow, false)

	addEventHandler("onClientGUIClick",beginBtn,startFiringRange, false)
	addEventHandler("onClientGUIClick",cancelBtn,function(btn,state) if btn == "left" and state == "up" then guiSetVisible(guiRangeWindow,false) showCursor(false) end end, false)
end

local theMarkers = {}

addEventHandler("onClientResourceStart",resourceRoot,
function()
	createRangeWindow()
	--[[for i,v in pairs(markers) do
		theMarkers[i] = createMarker(v[1],v[2],v[3]-1,"cylinder",1,math.random(0,225),math.random(0,225),math.random(0,225),100)
		addEventHandler("onClientMarkerHit",theMarkers[i],openRangeGUI,false)
		setElementInterior(theMarkers[i],v[4])
		setElementDimension(theMarkers[i],v[5])
	end]]--
end)

function openRangeGUI( hitElement, matchingDimension )
	local x, y, z = getElementPosition(hitElement)
	local ax, ay, az = getElementPosition(source)
	if ( z-3 < az ) and ( z+3 > az ) then
		if ( hitElement == localPlayer ) and ( matchingDimension ) and not ( isPlayerDoingTest ) then
			guiSetVisible(guiRangeWindow,true)
			showCursor(true)
		end
	end
end

function isElementWithinRange( element,zone )
	if ( not isElement( element ) ) then return false end
	if ( getElementDimension( element ) ~= 0 or getElementInterior( element ) ~= 0 ) then return false end
	if ( isElementWithinColShape( element, zone ) ) then
		return true
	end
	return false
end

function startFiringRange()
	guiSetVisible(guiRangeWindow,false)
	showCursor(false)
	if ( getPlayerMoney(localPlayer) >= 250 ) then
		triggerServerEvent("takePlayerTrainingMoney", localPlayer)
		if isElementWithinRange(localPlayer,LSCol) then
			for i=1,#pedCoords do
				theTestPeds[i] = createPed(math.random(168,189),pedCoords[i][1],pedCoords[i][2],pedCoords[i][3] +0.5, 269)
				theTestPedsCount = theTestPedsCount +1
				setElementData( theTestPeds[i], "weaponTrainPed", true )
				setElementInterior( theTestPeds[i], 0 )
				setPedRotation(theTestPeds[i],pedCoords[i][4])
				setElementDimension( theTestPeds[i], getElementDimension(localPlayer) )
			end
			addEventHandler( "onClientRender", root, onClientRenderWeaponTraining )
			shootingTimer = setTimer ( onWeaponTrainingEnd, 120000, 1, false )
			isPlayerDoingTest = true
		elseif isElementWithinRange(localPlayer,LVCol) then
			for i=1,#pedCoords2 do
				theTestPeds[i] = createPed(math.random(168,189),pedCoords2[i][1],pedCoords2[i][2],pedCoords2[i][3] +0.5, 269)
				theTestPedsCount = theTestPedsCount +1
				setElementData( theTestPeds[i], "weaponTrainPed", true)
				setElementInterior( theTestPeds[i], 0 )
				setPedRotation(theTestPeds[i],pedCoords[i][4])
				setElementDimension( theTestPeds[i], getElementDimension(localPlayer) )
			end
			addEventHandler( "onClientRender", root, onClientRenderWeaponTraining )
			shootingTimer = setTimer ( onWeaponTrainingEnd, 120000, 1, false )
			isPlayerDoingTest = true
		elseif (getElementInterior(localPlayer) == 1) then
			for i=1,#pedCoords3 do
				theTestPeds[i] = createPed(math.random(168,189),pedCoords3[i][1],pedCoords3[i][2],pedCoords3[i][3] +0.5, 179)
				theTestPedsCount = theTestPedsCount +1
				setElementData( theTestPeds[i], "weaponTrainPed", true)
				setElementInterior( theTestPeds[i], 1 )
				setElementDimension( theTestPeds[i], getElementDimension(localPlayer) )
			end
			addEventHandler( "onClientRender", root, onClientRenderWeaponTraining )
			shootingTimer = setTimer ( onWeaponTrainingEnd, 120000, 1, false )
			isPlayerDoingTest = true
		end
	else
		exports.NGCdxmsg:createNewDxMessage("You don't have enough money for the training!",255,0,0)
	end
end

function onClientRenderWeaponTraining ()
	remaining, executesRemaining, totalExecutes = getTimerDetails( shootingTimer )
	dxDrawText(tostring(theTestPedsCount).." peds are alive ",sx*(1118.0/1440),sy*(244.0/900),sx*(1423.0/1440),sy*(275.0/900),tocolor(255,255,255,255),0.8,"bankgothic","right","top",false,false,false)
	dxDrawText(tostring(math.floor((remaining/1000))).." seconds remaining ",sx*(1118.0/1440),sy*(204.0/900),sx*(1423.0/1440),sy*(235.0/900),tocolor(255,255,255,255),0.8,"bankgothic","right","top",false,false,false)
	if ( theTestPedsCount <= 0 ) or not ( isTimer( shootingTimer ) ) then
		onWeaponTrainingEnd( true )
	end
end

function onWeaponTrainingEnd ( state )
	for i=1,#theTestPeds do
		destroyElement(theTestPeds[i])
		theTestPeds[i] = nil
	end

	isPlayerDoingTest = false

	if ( isTimer ( shootingTimer ) ) then killTimer( shootingTimer ) end
	removeEventHandler( "onClientRender", root, onClientRenderWeaponTraining )

	if ( state ) then
		exports.NGCdxmsg:createNewDxMessage("You finished the weapon training!",255,0,0)
		triggerServerEvent( "onFinishWeaponTraining", localPlayer, tonumber(playerTestWeapon) )
	else
		exports.NGCdxmsg:createNewDxMessage("You failed the weapon training!",255,0,0)
	end

	playerTestWeapon = nil
	theTestPedsCount = 0
end

addEventHandler("onClientPedWasted", root,
	function( killer, weapon, bodypart )
		if ( getElementData ( source, "weaponTrainPed" ) ) and ( killer == localPlayer ) then
			for k,v in pairs(theTestPeds) do
						theTestPedsCount = theTestPedsCount -1
						return

			end
		end
	end
)

local allowedWeapons = { [22]=true, [23]=true, [24]=true, [25]=true, [26]=true, [27]=true, [28]=true, [29]=true, [32]=true, [30]=true, [31]=true, [33]=true, [34]=true  }

addEventHandler("onClientPedDamage", root,
	function( attacker, weapon, bodypart )
		if ( isElement( attacker ) ) then
			if ( getElementData ( source, "weaponTrainPed" ) ) and ( attacker == localPlayer ) then
				if not ( ( allowedWeapons[getPedWeapon ( localPlayer )] ) ) then
					exports.NGCdxmsg:createNewDxMessage("You can't use this weapon to train!",255,0,0)
					cancelEvent()
					return
				elseif ( playerTestWeapon == nil ) then
					playerTestWeapon = getPedWeapon ( localPlayer )
					return
				elseif ( playerTestWeapon ~= getPedWeapon ( localPlayer ) ) then
					exports.NGCdxmsg:createNewDxMessage("You need to use the same weapon for the whole training!",255,0,0)
					cancelEvent()
					return
				end
			elseif ( getElementData ( source, "weaponTrainPed" ) ) then
				cancelEvent()
			end
		end
	end
)
--[[
local antiSpamNades = {}
function projectileCreation(creator)
	if creator and creator == localPlayer then
		if getPedWeapon(creator,7) == 35 then
			if getElementDimension(localPlayer) > 4999 then return false end
			local theType = getProjectileType(source)
			if (theType == 19) then
				if isTimer(antiSpamNades[creator]) then
					if ( creator == localPlayer ) then
						exports.NGCdxmsg:createNewDxMessage( "Its not allowed to spam RPG wait 5 seconds!", 225, 0, 0 )
					end
					setElementPosition( source,0,0,10000 )
					triggerServerEvent("givePlayerRefundRPG",localPlayer)
				else
					antiSpamNades[creator] = setTimer(function () end, 5000,1)
				end
			end
		end
	end
end
addEventHandler("onClientProjectileCreation", getRootElement(), projectileCreation)
]]

--[[
local preventionDataKey = "DELETE_PROJECTILE"
local lastThrow = nil
local enableTime = nil
local COOLDOWN_TIME = 5000

local abilityWeapon = {
	["NadeSpammer"] = 16,
}

function onWeaponFire(creator)
	if(creator == localPlayer) then
		if isPedInVehicle(localPlayer) or getElementDimension(localPlayer) > 4999 then return false end
		local theType = getProjectileType(source)
		if (theType == 16) then
			local tick = getTickCount()
			if(enableTime and tick < enableTime) then
				deleteProjectile(source)
				setElementData(source, preventionDataKey, true)
			else
				if canSpamNades() == false then
					toggleControl("fire", false)
					setTimer(toggleControl, COOLDOWN_TIME, 1, "fire", true)
					enableTime = tick+COOLDOWN_TIME-50
				end
			end
		end
	else
		addEventHandler("onClientElementDataChange", source, onProjectileDataChange)
	end
end
addEventHandler("onClientProjectileCreation", root, onWeaponFire)

-- toggle 'fire' when switching to other weapons such as detonator, and set it back to disabled when switching to projectile
function onSwitchWeapon(prev, new)
	if(not enableTime) then return end
	local tick = getTickCount()
	if(tick < enableTime) then
		if (new == 8) then
			toggleControl('fire', false)
		else
			toggleControl('fire', true)
		end
	else
		toggleControl('fire', true)
		enableTime = nil
	end
end
addEventHandler("onClientPlayerWeaponSwitch", localPlayer, onSwitchWeapon)

function canSpamNades()
	if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Staff" then
		return true
	else
		return false
	end
end

function deleteProjectile(proj)
	setElementDimension(source, 1999)
	setElementPosition(source, 500, 500, -200)
end

function onProjectileDataChange(key, old)
	if(key == preventionDataKey) then
		deleteProjectile(source)
	end
end]]
--------------------
local RPGpreventionDataKey = "DELETE_PROJECTILE"
local RPGlastThrow = nil
local RPGenableTime = nil
local RPGCOOLDOWN_TIME = 5000

local RPGabilityWeapon = {
	["RPG"] = 35,
}

function onWeaponFireRPG(creator)
	if(creator == localPlayer) then
		if isPedInVehicle(localPlayer) or getElementDimension(localPlayer) > 4999 then return false end
		if (type(source) == "boolean") then return false end 
		local theType = getProjectileType(source)
		if (theType == 19 or theType == 20) then
			local tick = getTickCount()
			if(RPGenableTime and tick < RPGenableTime) then
				RPGdeleteProjectile(source)
				setElementData(source, RPGpreventionDataKey, true)
			else
				if canSpamRPGNades() == false then
					toggleControl("fire", false)
					setTimer(toggleControl, RPGCOOLDOWN_TIME, 1, "fire", true)
					RPGenableTime = tick+RPGCOOLDOWN_TIME-50
				end
			end
		end
	else
		addEventHandler("onClientElementDataChange", source, onProjectileDataChangeRPG)
	end
end
addEventHandler("onClientProjectileCreation", root, onWeaponFireRPG)

-- toggle 'fire' when switching to other weapons such as detonator, and set it back to disabled when switching to projectile
function onSwitchWeaponRPG(prev, new)
	if(not RPGenableTime) then return end
	local tick = getTickCount()
	if(tick < RPGenableTime) then
		if (new == 7) then
			if getPedWeapon(localPlayer,7) == 38 then
				toggleControl('fire', true)
			else
				toggleControl('fire', false)
			end
		else
			toggleControl('fire', true)
		end
	else
		toggleControl('fire', true)
		RPGenableTime = nil
	end
end
addEventHandler("onClientPlayerWeaponSwitch", localPlayer, onSwitchWeaponRPG)

function canSpamRPGNades()
	if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Staff" then
		return true
	else
		return false
	end
end

function RPGdeleteProjectile(proj)
	setElementDimension(source, 1999)
	setElementPosition(source, 500, 500, -200)
end

function onProjectileDataChangeRPG(key, old)
	if(key == RPGpreventionDataKey) then
		RPGdeleteProjectile(source)
	end
end
