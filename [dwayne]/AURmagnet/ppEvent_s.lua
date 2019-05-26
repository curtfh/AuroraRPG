---**********


-- Spawns a Leviathan and makes it a magnet helicopter
function magnet_func ( player )

	local x, y, z = getElementPosition ( player )
	local veh = getPedOccupiedVehicle(player)
	if veh then
		if getVehicleController ( getPedOccupiedVehicle (player) ) == player then
			if getElementModel(veh) == 417 then
				setVehicleAsMagnetHelicopter (  veh,player )
			end
		end
	end
end
addCommandHandler ( "magnet", magnet_func )

-- Attaches a magnet to it if its a Leviathan
function setVehicleAsMagnetHelicopter ( veh,player )

	if getElementModel ( veh ) == 417 then
		local x, y, z = getElementPosition ( veh )
		local magnet = createObject ( 1301, x, y, z-1.5)
		setElementData(magnet,"creator",player)
		attachElements ( magnet, veh, 0, 0, -1.5 )
		setElementData ( veh, "magpos", -1.5 )
		setElementData ( veh, "magnet", magnet )
		setElementData ( veh, "magnetic", true )
		setElementData ( veh, "hasmagnetactivated", false )
	end
end

-- When the helicopter is destroyed, kill the magnet
function destroyMagnet(player)
	local veh = getPedOccupiedVehicle(player)
	if veh then
		if getVehicleController ( getPedOccupiedVehicle (player) ) == player then
			if getElementData ( veh, "magnetic" ) then
				local magnet = getElementData ( veh, "magnet" )
				if magnet and isElement(magnet) then
					local creator = getElementData(magnet,"creator")
					if creator == player then
						destroyElement ( magnet )
						setElementData ( veh, "hasmagnetactivated", false )
						local mg = getElementData ( veh, "magneticVeh" )
						if mg then
							detachElements (mg)
						end
					end
				end
			end
		end
	end
end

addEventHandler ( "onVehicleExplode", getRootElement(), function()
	if getElementData ( source, "magnetic" ) then
		local magnet = getElementData ( source, "magnet" )
		if magnet then
			if isElement(magnet) then destroyElement ( magnet ) end
			setElementData ( source, "hasmagnetactivated", false )
			local mg = getElementData ( source, "magneticVeh" )
				if mg then
					detachElements (mg)
				end
		end
	end
end)

-- Moves the magnet up/down
function magnetUp ( player )

	local veh = getPedOccupiedVehicle ( player)
	if veh then
		if getVehicleController ( getPedOccupiedVehicle (player) ) == player then
			local magpos = getElementData ( veh, "magpos" )
			if magpos and tonumber(magpos) and tonumber(magpos) < -1.5 then
				local magnet = getElementData ( veh, "magnet" )
				if magnet and isElement(magnet) then
				detachElements ( magnet )
				local magpos = magpos+0.1
				attachElements ( magnet, veh, 0, 0, magpos, 0, 0, 0 )
				setElementData ( veh, "magpos", magpos )
				end
			end
		end
	end
end
function magnetDown ( player )

	local veh = getPedOccupiedVehicle ( player)
	if veh then
		if getVehicleController ( getPedOccupiedVehicle (player) ) == player then
			local magpos = getElementData ( veh, "magpos" )
			if magpos and tonumber(magpos) and tonumber(magpos) > -15 then
				local magnet = getElementData ( veh, "magnet" )
				if magnet and isElement(magnet) then
				detachElements ( magnet )
				local magpos = magpos-0.1
				attachElements ( magnet, veh, 0, 0, magpos, 0, 0, 0 )
				setElementData ( veh, "magpos", magpos )
				end
			end
		end
	end
end

-- (un)Bind the keys
function bindTrigger ()
	if source and getElementType(source) == "player" then
	if not isKeyBound (source, "mouse1", "down", magnetVehicleCheck ) then
		bindKey (source, "mouse1", "down", magnetVehicleCheck )
		bindKey (source, "mouse2", "down", destroyMagnet )
		bindKey (source, "num_sub", "down", magnetUp )
		bindKey (source, "num_add", "down", magnetDown )
	end
	end
end

function destroymg(player)
	if player and getElementType(player) == "player" then
		if getElementData ( source, "magnetic" ) then
			local magnet = getElementData ( source, "magnet" )
			if magnet and isElement(magnet) then
				local creator = getElementData(magnet,"creator")
				if creator == player then
					destroyElement ( magnet )
					setElementData ( source, "hasmagnetactivated", false )
					local mg = getElementData ( source, "magneticVeh" )
					if mg then
						detachElements (mg)
					end
					outputDebugString("")
				else
					outputDebugString("not player")
				end
			end
		end
	end
end

function unbindTrigger ()
	if source and getElementType(source) == "player" then
	if isKeyBound ( source, "mouse1", "down", magnetVehicleCheck ) then
		unbindKey ( source, "mouse1", "down", magnetVehicleCheck )
		unbindKey ( source, "num_sub", "down", magnetUp )
		unbindKey ( source, "num_add", "down", magnetDown )
		unbindKey ( source, "mouse2", "down", destroyMagnet )
	end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), bindTrigger )
addEventHandler ( "onPlayerVehicleExit", getRootElement(), unbindTrigger )
addEventHandler ( "onPlayerWasted", getRootElement(), unbindTrigger )

addEventHandler ( "onVehicleExit", getRootElement(), destroymg )

-- When Ctrl is pressed, attach / detatch the helicopter
function magnetVehicleCheck ( player )

	local veh = getPedOccupiedVehicle ( player)
	if veh then
		if getVehicleController ( getPedOccupiedVehicle (player) ) == player then
			if getElementData ( veh, "magnetic" ) then
				local magnet = getElementData ( veh, "magnet" )
				if magnet and isElement(magnet) then
					local creator = getElementData(magnet,"creator")
					if creator and creator ~= player then
					return false end
					if getElementData ( veh, "hasmagnetactivated" ) then
						--setElementData ( veh, "hasmagnetactivated", false )
						--detachElements ( getElementData ( veh, "magneticVeh" ) )
						exports.NGCdxmsg:createNewDxMessage(player,"You already are using magnet",255,0,0)
					else
						local magnet = getElementData ( veh, "magnet" )
						if magnet and isElement(magnet) then
							local x, y, z = getElementPosition ( magnet )
							local magpos = getElementData ( veh, "magpos" )
							local marker = createColSphere ( x , y , z, 2 )
							if marker then
								local vehs = getElementsWithinColShape ( marker, "vehicle" )
								if isElement(marker) then destroyElement ( marker ) end
								grabveh = false
								for key, vehitem in ipairs(vehs) do
									if vehitem ~= veh then
										local grabveh = vehitem
										if getElementData(grabveh,"Armored") == true or getElementData(grabveh,"ArmoredDT") == true then
										return false end
										attachElements ( grabveh, magnet, 0, 0, -1, 0, 0, getVehicleRotation(grabveh) )
										setElementData ( veh, "hasmagnetactivated", true )
										setElementData ( veh, "magneticVeh", grabveh )
										break
									end
								end
							end
						end
					end
				end
			end
		end
	end
end