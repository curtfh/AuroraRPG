local screenW, screenH = guiGetScreenSize()
local cooldown = "Ready"
local width = screenW * 0.1508
local eachSecond = (screenW * 0.1508) / 3000
local antiSpam = getTickCount()
local alpha = 255

function dxHUD()
	if (getPedWeapon(localPlayer, 8) and getPedWeapon(localPlayer, 8) ~= 0) then
		local timeLeft = 3 - math.ceil((getTickCount() - antiSpam)/1000)
		if (timeLeft < 0) then
			cooldown = "Ready"
			width = screenW * 0.1508
		else
			cooldown = tostring(timeLeft).." seconds"
			width = eachSecond * math.ceil(getTickCount() - antiSpam)
		end
		if (cooldown == "Ready") then
			if (alpha ~= 0) then
				alpha = alpha - 3
			end
		else 
			if (alpha ~= 255) then
				alpha = alpha + 3
			end
		end
		local weaponName = getWeaponNameFromID(getPedWeapon(localPlayer, 8))
		if (getPedWeapon(localPlayer, 7) and getPedWeapon(localPlayer, 7) ~= 0) then 
			weaponName = "Explosives"
		end
		dxDrawRectangle(screenW * 0.8242, screenH * 0.8347, screenW * 0.1563, screenH * 0.0306, tocolor(0, 0, 0, alpha), false)
		dxDrawRectangle(screenW * 0.8258, screenH * 0.8403, width, screenH * 0.0194, tocolor(255, 100, 0, alpha), false)
		dxDrawText(weaponName.." - "..cooldown, screenW * 0.8242, screenH * 0.8347, screenW * 0.9812, screenH * 0.8639, tocolor(255, 255, 255, alpha), 1.20, "default-bold", "center", "center", false, false, false, false, false)
	end
end
addEventHandler("onClientRender", root, dxHUD)

local tickers = {}

function antiNadeSpam(creator)
	if (creator == localPlayer) then
		if (getTickCount() - antiSpam < 3000) then
			setElementPosition(source, 0, 0, -155)
			destroyElement(source)
			triggerServerEvent("AURnadespam.refund", localPlayer, getPedWeapon(localPlayer, 8))
		else
			antiSpam = getTickCount()
			--setTimer(setPedSlot, 1000, 1)
		end
	else
		if (tickers[creator]) then 
			if (getTickCount() - tickers[creator] < 3000) then
				setElementPosition(source, 0, 0, -155)
				destroyElement(source)
			else
				tickers[creator] = getTickCount()
			end 
		else
			tickers[creator] = getTickCount()
		end
	end
end
addEventHandler("onClientProjectileCreation", getRootElement( ), antiNadeSpam)

function setPedSlot()
	if (getPedWeaponSlot(localPlayer) == 7 or getPedWeaponSlot(localPlayer) == 8) then 
		--setControlState("aim", false)
		--setPedWeaponSlot(localPlayer, 0)
	end
end

function disableSlot(_, c)
	--[[if (c == 8) then
		if (cooldown ~= "Ready") then
			setTimer(setPedSlot, 500, 1)
		end
	end
	if (c == 7) then
		if (cooldown ~= "Ready") then
			setTimer(setPedSlot, 500, 1)
		end
	end]]--
end
addEventHandler("onClientPlayerWeaponSwitch", root, disableSlot)

function onStart()
	--[[if (getPedWeapon(localPlayer, 8) == getPedWeapon(localPlayer)) then
		setControlState("aim", false)
		setTimer(setPedSlot, 500, 1)
	end 
	if (getPedWeapon(localPlayer, 7) == getPedWeapon(localPlayer)) then
		setControlState("aim", false)
		setTimer(setPedSlot, 1000, 1)
	end ]]--
end
onStart()