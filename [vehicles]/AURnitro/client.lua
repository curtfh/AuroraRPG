notAllowedModels = {592,577,511,548,512,593,425,520,417,487,553,488,497,563,476,447,519,460,469,
513,510,522,461,448,468,586,581,509,481,462,521,463,472,473,493,595,484,430,453,452,446,454,449,
537,538,570,569,590}


local Keys = {
	"delete","tab", "lalt", "ralt"
}


function reset()
	veh = getPedOccupiedVehicle(localPlayer,0)
	if veh and isElement(veh) then
		if getVehicleController ( veh ) == localPlayer then
			removeEventHandler("onClientRender",root,removeNos)
			setVehicleNitroActivated(veh, false)
			removeVehicleUpgrade(veh, 1010)
			triggerServerEvent("onSetAccountNitro",localPlayer)
		end
	end
end


for k, v in ipairs(Keys) do
	bindKey(v,"both",reset)
end

function nitroOn(k,ke)
	if getElementDimension(localPlayer) ~= 0 then return false end
	veh = getPedOccupiedVehicle(localPlayer,0)
	if veh and isElement(veh) then
		if getVehicleController ( veh ) == localPlayer then
			if isCursorShowing ( ) then return false end
			if getElementData(localPlayer,"isPlayerModding") or isElementFrozen(veh) then
				removeEventHandler("onClientRender",root,removeNos)
				if veh and isElement(veh) then
				setVehicleNitroActivated(veh, false)
				removeVehicleUpgrade(veh, 1010)
				end
				return false
			end
			if isPedInVehicle(localPlayer) ~= false then
				veh = getPedOccupiedVehicle(localPlayer)
				model = getElementModel(veh)
				if ke == "up" then
					driver = getVehicleOccupant(veh,0)
					if not driver then return end
					removeEventHandler("onClientRender",root,removeNos)
					setVehicleNitroActivated(veh, false)
					removeVehicleUpgrade(veh, 1010)
					triggerServerEvent("onSetAccountNitro",localPlayer)
				elseif ke == "down" then
					driver = getVehicleOccupant(veh,0)
					if not driver == localPlayer then return false end
					nos = getElementData(localPlayer,"nos")
					if nos and tonumber(nos) then
						if math.floor(nos) > 0 then
							for ind,num in ipairs(notAllowedModels) do
								if model == num then return end
							end
							removeEventHandler("onClientRender",root,removeNos)
							addEventHandler("onClientRender",root,removeNos)
							addVehicleUpgrade(veh, 1010)
							setVehicleNitroActivated(veh, true)
							nos = nos-0.05
							setElementData(localPlayer,"nos",nos)

						end
					end
				end
			end
		else
			removeEventHandler("onClientRender",root,removeNos)
			if veh and isElement(veh) then
				setVehicleNitroActivated(veh, false)
				removeVehicleUpgrade(veh, 1010)
			end
		end
	else
		removeEventHandler("onClientRender",root,removeNos)
	end
end

function removeNos ()
	--if getElementDimension(localPlayer) ~= 0 then return false end
	veh = getPedOccupiedVehicle(localPlayer)
	if getElementData(localPlayer,"isPlayerModding") then
		removeEventHandler("onClientRender",root,removeNos)
		triggerServerEvent("onSetAccountNitro",localPlayer)
		if veh and isElement(veh) then
			setVehicleNitroActivated(veh, false)
			removeVehicleUpgrade(veh, 1010)
		end
		return false
	end
	if isCursorShowing ( ) then
		removeEventHandler("onClientRender",root,removeNos)
		if veh and isElement(veh) then
			setVehicleNitroActivated(veh, false)
			removeVehicleUpgrade(veh, 1010)
		end
		return false
	end
	nos = getElementData(localPlayer,"nos")
	nos = nos-0.05
	if nos < 1 then
		nos = 0
	end
	setElementData(localPlayer,"nos",nos)
	if math.floor(nos) <= 0 then
		setElementData(localPlayer,"nos",0)
		veh = getPedOccupiedVehicle(localPlayer)
		setVehicleNitroActivated(veh, false)
		removeVehicleUpgrade(veh, 1010)
		removeEventHandler("onClientRender",root,removeNos)
		triggerServerEvent("onSetAccountNitro",localPlayer)
	end
end

addEventHandler("onClientResourceStart",resourceRoot,function()
	bindKey("mouse1","down",nitroOn)
	bindKey("mouse1","up",nitroOn)
end)

addEventHandler("onClientPlayerQuit",localPlayer,function()
	if localPlayer == source then
		triggerServerEvent("onSetAccountNitro",localPlayer,true)
	end
end)

