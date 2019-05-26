toggleControl ("aim_weapon", true)
		toggleControl ("fire", true)


weapons = {
	[1] = {2, 3, 4, 5, 6, 7, 8, 9},
	[2] = {22, 23, 24},
	[3] = {25, 26, 27},
	[4] = {28, 29, 32},
	[5] = {30, 31},
	[6] = {33, 34},
	[7] = {35, 36, 37,38},
	[8] = {16, 17, 18, 39},
	[9] = {41, 42, 43},
	[10] = {10, 11, 12, 13, 14, 15},
	[11] = {44, 45, 46},
	[12] = {40},
}

restrictedWeapons = {}

function onClientPreRender()
	if (exports.server:getPlayChatZone(localPlayer) == "LV") then
		if getElementDimension(localPlayer) ~= 0 then return false end
		local weapon = getPedWeapon(localPlayer)
		local slot = getPedWeaponSlot(localPlayer)
		if (restrictedWeapons[weapon]) then
			local weapons = {}
			for i=1, 30 do
				if (getControlState("next_weapon")) then
					slot = slot + 1
				else
					slot = slot - 1
				end
				if (slot == 13) then
					slot = 0
				elseif (slot == -1) then
					slot = 12
				end

				local w = getPedWeapon(localPlayer, slot)
				if (((w ~= 0 and slot ~= 0) or (w == 0 and slot == 0)) and not restrictedWeapons[w]) then
					setPedWeaponSlot(localPlayer, slot)
					break
				end
			end
		end
	end
end
addEventHandler("onClientPreRender", root, onClientPreRender)

function onClientPlayerWeaponFire(weapon)
	if (restrictedWeapons[weapon]) then return end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, onClientPlayerWeaponFire)

function setWeaponDisabled(id, bool)
	if (id == 0) then return end
	restrictedWeapons[id] = bool
end

function isWeaponDisabled(id)
	return restrictedWeapons[id]
end

function setWeaponSlotDisabled(slot, bool)
	if (not weapons[slot]) then return end
	for k, v in ipairs(weapons[slot]) do
		setWeaponDisabled(v, bool)
	end
end

addEventHandler("onClientResourceStart",resourceRoot,function()
	setWeaponSlotDisabled(7,true)
end)
