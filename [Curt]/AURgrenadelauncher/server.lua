function firedNade()
	if client then
		if getPedWeapon(client, 8) == 16 then
			local ammo = getPedTotalAmmo(client, 8)
			if ammo > 0 then
				takeWeapon(client, 16, 8)
				return true
			end
		end
	end
	outputDebugString("glauncher Error: Player " .. getPlayerName(client) .. " launched a grenade while being out of ammo.")
end
addEvent("glauncher.fired", true)
addEventHandler("glauncher.fired", root, firedNade)