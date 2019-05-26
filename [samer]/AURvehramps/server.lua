local pos = {}
local obj = {}
addEvent("AURsmiler.updatePos", true)

addEventHandler("AURsmiler.updatePos", root,
	function(x, y, z)
		pos[client] = {x, y, z}
	end
)

function applyInverseRotation ( x,y,z, rx,ry,rz )
    -- Degress to radians
    local DEG2RAD = (math.pi * 2) / 360
    rx = rx * DEG2RAD
    ry = ry * DEG2RAD
    rz = rz * DEG2RAD

    -- unrotate each axis
    local tempY = y
    y =  math.cos ( rx ) * tempY + math.sin ( rx ) * z
    z = -math.sin ( rx ) * tempY + math.cos ( rx ) * z

    local tempX = x
    x =  math.cos ( ry ) * tempX - math.sin ( ry ) * z
    z =  math.sin ( ry ) * tempX + math.cos ( ry ) * z

    tempX = x
    x =  math.cos ( rz ) * tempX + math.sin ( rz ) * y
    y = -math.sin ( rz ) * tempX + math.cos ( rz ) * y

    return x, y, z
end

addCommandHandler("bumperramp",
	function(plr)
		if (getTeamName(getPlayerTeam(plr)) ~= "Staff") then return false end
		exports.NGCdxmsg:createNewDxMessage(plr, "Creating your ramp...", 0, 255, 0)
		triggerClientEvent(plr, "AURsmiler.request", plr)
		setTimer(function(p)
			local x, y, z = unpack(pos[p])
			print(x, y, z)
			if (isElement(obj[p])) then destroyElement(obj[p]) end
			obj[p] = createObject(1634, x, y, z)
			setElementDimension(obj[p], getElementDimension(plr))
			setElementInterior(obj[p], getElementInterior(plr))
			local offsetPosX, offsetPosY, offsetPosZ = applyInverseRotation ( x, y, z, 0, 0, 180 )
			attachElements(obj[p], getPedOccupiedVehicle(p),offsetPosX, offsetPosY+5, offsetPosZ, 0, 0, 180)
		end, 1000, 1, plr)
	end
)

addCommandHandler("destroyramp",
	function(plr)
		if (isElement(obj[plr])) then destroyElement(obj[plr]) exports.NGCdxmsg:createNewDxMessage(plr, "Your ramp has been destroyed.", 0, 255, 0) end
	end
)