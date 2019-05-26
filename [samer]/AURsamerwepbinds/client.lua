
local settings = {
	["handgun"] = 2,
	["shotgun"] = 3,
	["smg"] = 4,
	["rifle"] = 5,
	["sniper"] = 6,
	["heavy"] = 7,
	["nade"] = 8,
	["special"] = 9,
}

local keysBound = {
	[exports.DENsettings:getPlayerSetting("weaponBinds1") or "1"] = "handgun",
	[exports.DENsettings:getPlayerSetting("weaponBinds2") or "2"] = "shotgun",
	[exports.DENsettings:getPlayerSetting("weaponBinds3") or "3"] = "smg",
	[exports.DENsettings:getPlayerSetting("weaponBinds4") or "4"] = "rifle",
	[exports.DENsettings:getPlayerSetting("weaponBinds5") or "5"] = "sniper",
	[exports.DENsettings:getPlayerSetting("weaponBinds6") or "6"] = "heavy",
	[exports.DENsettings:getPlayerSetting("weaponBinds7") or "7"] = "nade",
	[exports.DENsettings:getPlayerSetting("weaponBinds8") or "8"] = "special",
}

function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

local oldTickRate = 0

function doBinds(button, press)
	if (not press or not keysBound[button]) then
		return false
	end
	if (isPedInVehicle(localPlayer) or isPedWearingJetpack(localPlayer)) then
		return false
	end
	if (isMTAWindowActive() or isCursorShowing()) then
		return false
	end

	local currentTick = getTickCount ()

	local calc = currentTick - oldTickRate
	if (calc >= 1000) then 
		if (isPedAiming(localPlayer) == false) then 
			setPedWeaponSlot(localPlayer, settings[keysBound[button]])
			oldTickRate = currentTick
		end
	end 
end

if (exports.DENsettings:getPlayerSetting("weaponBinds")) then
	addEventHandler("onClientKey", root, doBinds)
end

function changeKeysBound(setting, value)
	if (setting == "weaponBinds") then
		removeEventHandler("onClientKey", root, doBinds)
		if (value) then
			addEventHandler("onClientKey", root, doBinds)
		end
	end
	if (string.sub(setting, 1, -2) ~= "weaponBinds") then
		return false
	end
	keysBound = {
		[exports.DENsettings:getPlayerSetting("weaponBinds1") or "1"] = "handgun",
		[exports.DENsettings:getPlayerSetting("weaponBinds2") or "2"] = "shotgun",
		[exports.DENsettings:getPlayerSetting("weaponBinds3") or "3"] = "smg",
		[exports.DENsettings:getPlayerSetting("weaponBinds4") or "4"] = "rifle",
		[exports.DENsettings:getPlayerSetting("weaponBinds5") or "5"] = "sniper",
		[exports.DENsettings:getPlayerSetting("weaponBinds6") or "6"] = "heavy",
		[exports.DENsettings:getPlayerSetting("weaponBinds7") or "7"] = "nade",
		[exports.DENsettings:getPlayerSetting("weaponBinds8") or "8"] = "special",	
	}
end
addEvent("onPlayerSettingChange", true)
addEventHandler("onPlayerSettingChange", localPlayer, changeKeysBound)