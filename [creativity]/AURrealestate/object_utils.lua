function getObjectLineSight( object)
	local x, y, z = getElementPosition( object)
	local _, pX, pY, pZ = processLineOfSight( x, y, z, x, y, z-100)

	return x, y, z, pX, pY, pZ
end

function isObjectOnGround( object)
	local x, y, z = getElementPosition( object)
	local _, pX, pY, pZ = processLineOfSight( x, y, z, x, y, z-100)

	if pZ == z then
		return true
	else
		return false
	end
end

function setObjectOnGround( object)
	local x, y, z = getElementPosition( object)
	local _, pX, pY, pZ = processLineOfSight( x, y, z, x, y, z-100)
	setElementPosition( object, x, y, pZ)
end



local showing = false

function toggleMouse()
	if showing then
		--showCursor( false)
		showing = false
	else
		--showCursor( true)
		showing = true
	end
end

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		bindKey( "x", "down", toggleMouse)
	end
)

function isObjectCustom( object)
	if getObjectData( object, "shaderTexture") then
		return true
	else
		return false
	end
end

local cancelled_keys = {
	["f"] = true,
	["g"] = true,
	["arrow_l"] = true,
	["arrow_r"] = true,
	["arrow_u"] = true,
	["arrow_d"] = true,
	["mouse_wheel_up"] = true,
	["mouse_wheel_down"] = true,
	["pgup"] = true,
	["pgdn"] = true,
}

-- Default Speed is 1.25
speeds = {
	["reg"] = 0.50,
	["lshift"] = 2.75,
	["lalt"] = 0.15,
}

elements = {}
local setting = false
local object = false

addEventHandler("onClientRender", root,
    function()
        --dxDrawText("Newly placed objects: "..(#elements), 1211, 191, 1397, 207, tocolor(255, 255, 255, 255), 1.00, "default", "right", "top", false, false, false, false, false)

		if not showing then return end
		local _, _, wX, wY, wZ = getCursorPosition()
		local pX, pY, pZ = getCameraMatrix()
		local hit, wX, wY, wZ, elementHit = processLineOfSight( pX, pY, pZ, wX, wY, wZ)
		if elementHit and getElementType( elementHit) == "object" then
			local rX, rY, rZ = getElementRotation( elementHit)

			--dxDrawText( rX..", "..rY..", "..rZ, 1211, 121, 1397, 207, tocolor(255, 255, 255, 255), 1.00, "default", "right", "top", false, false, false, false, false)

			dxDrawLine3D( wX-.5, wY, ((wZ-.5)-(rZ/100)), wX+.5, wY, ((wZ+.5)-(rZ/100)), tocolor( 255, 0, 0, 200), 8)
			dxDrawLine3D( wX, wY-.5, wZ, wX, wY+.5, wZ, tocolor( 255, 0, 0, 200), 8)
		end


    end
)

function datas( option, entity, data)
	if option == "apply" then
		if isElement( odata.object[entity]) then
			applyCustomTexture( odata.object[entity], data)
		end
	elseif option == "remove" then
		if isElement( odata.object[entity]) then
			removeCustomTexture( odata.object[entity])
		end
	elseif option == "placeObject" then
		local data = split( data, ",")
		local wX, wY, wZ = data[1], data[2], data[3]
		if not setting then
			local obj = createObject( 2926, wX, wY, wZ+2.5, 0, 90, 0)
			local rX, rY, rZ = getElementRotation( obj)
			if not elements[obj] then
				elements[obj] = (#elements)+1
				table.insert( elements, {obj})
				object = obj
				setting = true
				setElementCollisionsEnabled( object, false)
				setElementAlpha( object, 200)
			end
		else
			setElementCollisionsEnabled( object, true)
			setElementAlpha( object, 255)
			setElementRotation( object, rX, rY, rZ)
			setting = false
			object = false
		end
	elseif option == "deleteObject" then
		if object and elements[object] then
			destroyElement( object)
			table.remove( elements, elements[object])
			elements[object] = nil
			object = false
		else
			object = false
		end
	end
end
addEvent( "AURrealestate.data", true)
addEventHandler( "AURrealestate.data", root, datas)

-- Model Placement
addEventHandler( "onClientKey", root,
	function( key, state)
		if not showing then return end
		if not object then return end
		--if state then return end
		if cancelled_keys[key] then
			cancelEvent()
		end

		local wX, wY, wZ = getElementPosition( object)
		local rX, rY, rZ = getElementRotation( object)

		if key == "arrow_l" then
			if state then return end
			if getKeyState( "lshift") then
				speed = speeds["lshift"]
			elseif getKeyState( "lalt") then
				speed = speeds["lalt"]
			else
				speed = speeds["reg"]
			end
			setElementPosition( object, wX-speed, wY, wZ)
		elseif key == "arrow_r" then
			if state then return end
			if getKeyState( "lshift") then
				speed = speeds["lshift"]
			elseif getKeyState( "lalt") then
				speed = speeds["lalt"]
			else
				speed = speeds["reg"]
			end
			setElementPosition( object, wX+speed, wY, wZ)
		elseif key == "arrow_u" then
			if state then return end
			if getKeyState( "lshift") then
				speed = speeds["lshift"]
			elseif getKeyState( "lalt") then
				speed = speeds["lalt"]
			else
				speed = speeds["reg"]
			end
			setElementPosition( object, wX, wY-speed, wZ)
		elseif key == "arrow_d" then
			if state then return end
			if getKeyState( "lshift") then
				speed = speeds["lshift"]
			elseif getKeyState( "lalt") then
				speed = speeds["lalt"]
			else
				speed = speeds["reg"]
			end
			setElementPosition( object, wX, wY+speed, wZ)
		elseif key == "mouse_wheel_up" then -- Right Rot
			if getKeyState( "lshift") then
				speed = speeds["lshift"]
			elseif getKeyState( "lalt") then
				speed = speeds["lalt"]
			else
				speed = speeds["reg"]
			end
			if getKeyState( "lctrl") then
				setElementRotation( object, rX, rY-speed, rZ)
			else
				setElementRotation( object, rX, rY, rZ-speed)
			end
		elseif key == "mouse_wheel_down" then -- Left Rot
			if getKeyState( "lshift") then
				speed = speeds["lshift"]
			elseif getKeyState( "lalt") then
				speed = speeds["lalt"]
			else
				speed = speeds["reg"]
			end
			if getKeyState( "lctrl") then
				setElementRotation( object, rX, rY+speed, rZ)
			else
				setElementRotation( object, rX, rY, rZ+speed)
			end
		elseif key == "pgup" then
			if state then return end
			if getKeyState( "lshift") then
				speed = speeds["lshift"]
			elseif getKeyState( "lalt") then
				speed = speeds["lalt"]
			else
				speed = speeds["reg"]
			end
			setElementPosition( object, wX, wY, wZ+speed)
		elseif key == "pgdn" then
			if state then return end
			if getKeyState( "lshift") then
				speed = speeds["lshift"]
			elseif getKeyState( "lalt") then
				speed = speeds["lalt"]
			else
				speed = speeds["reg"]
			end
			setElementPosition( object, wX, wY, wZ-speed)
		end
	end
)

addEventHandler( "onClientClick", root,
	function( button, state, aX, aY, wX, wY, wZ, entity)
		if state ~= "down" then return end
		if not showing then return end
		if entity and getElementType( entity) == "object" then
			local object = entity
			local id = getElementModel( object)
			if isObjectCustom( object) then
				selectedElement = entity
				local txd = getObjectData( object, "shaderTexture")
				local i = getObjectData( object, "objectNumber")
				local x, y, z = getElementPosition( entity)
				local rX, rY, rZ = getElementRotation( entity)
				local id = getElementModel( entity)
				--local data = x..","..y..","..z";"..rX..","..rY..","..rZ..";"..id..";"..txd..";"..i
				if button == "left" then
					--applyCustomTexture( object, "digi2")
					--triggerServerEvent( "AURrealestate.shader", localPlayer, "apply", "digi2")
					triggerServerEvent( "AURrealestate.data", localPlayer, "apply", i, "digi2")
				elseif button == "right" then
					--removeCustomTexture( object)
					triggerServerEvent( "AURrealestate.data", localPlayer, "remove", i, "digi2")
				end
			end
		end
	end
)