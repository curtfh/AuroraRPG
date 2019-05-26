

local distance = 75 --distance from where you can hear the shot
local explostionDistance = 150

local cSoundsEnabled = false
local reloadSoundEnabled = false
local explosionEnabled = false

function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end
--shoot sounds
function playSounds(weapon, ammo, ammoInClip)
	if(cSoundsEnabled)then
		local x,y,z = getElementPosition(source)
		if weapon == 31 then --m4
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/m4.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/m4.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 22 then --pistol
			if(ammoInClip == 0 and reloadSoundEnabled)then
				pistolReload("sounds/weapon/pistole.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/pistole.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 24 then --deagle
			if(ammoInClip == 0 and reloadSoundEnabled)then
				pistolReload("sounds/weapon/deagle.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/deagle.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 25 or weapon == 26 or weapon == 27 then --shotguns
			if(weapon == 25)then
				local sound = playSound3D("sounds/weapon/shotgun.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
				shotgunReload(x,y,z)
			else
				local sound = playSound3D("sounds/weapon/shotgun.wav", x,y,z)
				local shellSound = playSound3D("sounds/reload/shotgun_shell.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 28 then --uzi
			if(ammoInClip == 0)then						
				mgReload("sounds/weapon/uzi.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/uzi.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 29 then --mp5
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/mp5.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/mp5.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 32 then --tec-9
			if(ammoInClip == 0)then						
				tec9Reload(x,y,z)
			else
				local sound = playSound3D("sounds/weapon/tec-9.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 30 then --ak
			if(ammoInClip == 0 and reloadSoundEnabled)then
				mgReload("sounds/weapon/ak.wav", x,y,z)
			else
				local sound = playSound3D("sounds/weapon/ak.wav", x,y,z)
				setSoundMaxDistance(sound, distance)
			end
		elseif weapon == 33 or weapon == 34 then --snipers
			local sound = playSound3D("sounds/weapon/sniper.wav", x,y,z)
			setSoundMaxDistance(sound, distance)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", getRootElement(), playSounds)

--reload sounds
function mgReload(soundPath, x,y,z)
	local sound = playSound3D(soundPath, x,y,z)
	setSoundMaxDistance(sound, distance)
				
	local clipinSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	end, 1250, 1)
end

function tec9Reload(x,y,z)
	local sound = playSound3D("sounds/weapon/tec-9.wav", x,y,z)
	setSoundMaxDistance(sound, distance)
				
	local clipinSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/mg_clipin.wav", x,y,z)
	end, 1000, 1)
end

function pistolReload(soundPath, x,y,z)
	local sound = playSound3D(soundPath, x,y,z)
	setSoundMaxDistance(sound, distance)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/pistol_reload.wav", x,y,z)
	end, 500, 1)
end

function shotgunReload(x,y,z)
	setTimer(function()
		local relSound = playSound3D("sounds/reload/shotgun_reload.wav", x,y,z)
		local shellSound = playSound3D("sounds/reload/shotgun_shell.wav", x,y,z)
	end, 500, 1)
end

--explosion sounds
addEventHandler("onClientExplosion", getRootElement(), function(x,y,z, theType)
	if(explosionEnabled)then
		if(theType == 0)then--Grenade
			local explSound = playSound3D("sounds/explosion/explosion1.wav", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		elseif(theType == 4 or theType == 5 or theType == 6 or theType == 7)then --car, car quick, boat, heli
			local explSound = playSound3D("sounds/explosion/explosion3.wav", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		end
	end
end)


--window etc.
local screenX, screenY = guiGetScreenSize()
function optionsWindow() 
	cSoundsWindow = guiCreateWindow(372, 236, 605, 284, "AuroraRPG Sound System", false)
	 centerWindow( cSoundsWindow )
	tabpanel1 = guiCreateTabPanel(13, 37, 578, 206, false, cSoundsWindow)

       tab1 = guiCreateTab("AuroraRPG custom sounds Options", tabpanel1)
	   image1 = guiCreateStaticImage(175, 0, 225, 68, ":AURwepsound/aur.png", false, tab1)
	checkBoxEnableCSounds = guiCreateCheckBox(78, 107, 15, 15, "", cSoundsEnabled, false, tab1)
	label1 = guiCreateLabel(31, 79, 116, 18, "Enable shoot sounds", false, tab1)
	guiSetFont(label1, "default-bold-small")
	checkBoxEnableRelSounds = guiCreateCheckBox(281, 107, 15, 15, "", reloadSoundEnabled, false, tab1)
	label2 = guiCreateLabel(230, 79, 123, 17, "Enable reload sounds", false, tab1)
	guiSetFont(label2, "default-bold-small")
	checkBoxEnableExplSounds = guiCreateCheckBox(476, 106, 15, 15, "", explosionEnabled, false,tab1)
	label3 = guiCreateLabel(425, 78, 137, 18, "Enable explosion sounds", false, tab1)
	guiSetFont(label3, "default-bold-small")
	btnCloseCSoundsWindow = guiCreateButton(244, 249, 119, 25, "Close GUI", false, cSoundsWindow)
	 guiSetFont(btnCloseCSoundsWindow, "default-bold-small")
	
	addEventHandler("onClientGUIClick", checkBoxEnableCSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableCSounds))then
				cSoundsEnabled = true
			else
				cSoundsEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", checkBoxEnableRelSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableRelSounds))then
				reloadSoundEnabled = true
			else
				reloadSoundEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", checkBoxEnableExplSounds, function(btn, state)
		if(state == "up")then
			if(guiCheckBoxGetSelected(checkBoxEnableExplSounds))then
				explosionEnabled = true
			else
				explosionEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", btnCloseCSoundsWindow, closeCSoundsWindow, false)
	
	guiSetVisible(cSoundsWindow, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), optionsWindow)

function closeCSoundsWindow()
	if(guiGetVisible(cSoundsWindow))then
		guiSetVisible(cSoundsWindow, false)
		showCursor(false)
	else
		guiSetVisible(cSoundsWindow, true)
		showCursor(true)
	end	
end
addCommandHandler("wpsound", closeCSoundsWindow)





