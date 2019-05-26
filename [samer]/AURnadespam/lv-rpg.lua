local rpgs = {
	[35] = true,
	[36] = true,
	[37] = true
}

function setPedSlot()
	if (getPedWeaponSlot(localPlayer) == 7 or getPedWeaponSlot(localPlayer) == 8) then 
		if (rpgs[getPedWeapon(localPlayer)]) then
			setControlState("aim", false)
			setPedWeaponSlot(localPlayer, 0)
		end
	end
end

function disableSlot(_, c)
	if (getElementData(source, "City") ~= "LV") then
		return false 
	end
	if (c == 7) then
		if (rpgs[getPedWeapon(localPlayer)]) then
			print("switching")
			setControlState("aim", false)
			setTimer(setPedSlot, 100, 1)
		end
	end
end
addEventHandler("onClientPlayerWeaponSwitch", root, disableSlot)

function onStart()
	if (getElementData(localPlayer, "City") ~= "LV") then
		return false 
	end
	if (getPedWeapon(localPlayer, 7) == getPedWeapon(localPlayer)) then
		if (rpgs[getPedWeapon(localPlayer)]) then
			setControlState("aim", false)
			setTimer(setPedSlot, 1000, 1)
		end
	end 
end
onStart()