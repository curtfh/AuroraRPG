hex = {}
lasthit = {}
local ball = nil
local theCol = nil
local marker = nil
local co1 = {}
local co2 = {}
function createBall(x,y,z)
	if isElement(ball) then destroyElement(ball) end
	theCol = createColRectangle(3518,-1163,470,205)
	ball = createVehicle(594,x,y,z)
	obj = createObject(1305,x,y,z)

	--setObjectScale(ball,1.3)
	setElementAlpha(ball,0)
	marker = createColSphere ( x, y, z, 4 )
	setVehicleDamageProof(ball,true)
	attachElements(obj,ball,0,0,1)
	attachElements(marker,ball,0,0,0)
	addEventHandler("onColShapeHit",marker,hitBall)
	setElementData(ball,"carball",true)
	createBlipAttachedTo(ball)
end
--[[
setTimer(function()
	if ball and isElement(ball) then
		if getElementData(ball,"ballShoot") then
			local x,y,z = unpack(getElementData(ball,"ballShoot"))
			if x and y and z then
				if removeElementData(ball,"ballShoot") then
					setElementVelocity(ball,x,y,z)
				end
			end
		end
	end
end,50,0)]]

function allSee()

end

addCommandHandler("vc",function(p)
	local car = getPedOccupiedVehicle(p)
	co1[car] = createColSphere(0, 0, 0, 2)
	co2[car] = createColSphere(0, 0, 0, 2)
	attachElements(co1[car], car)
	attachElements(co2[car], car, 0, 30, 0)
end)

function findRotation( x1, y1, x2, y2 )
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function hitBall(element)
	if source == marker then
	if element and getElementType(element) == "vehicle" then
		if getElementModel(element) ~= 594 then
		local eX, eY, eZ = getElementPosition(element)
			local erX, erY, erZ = getElementRotation(element)
			local eX = eX+2*math.cos(math.rad(erZ+90))
			local eY = eY+2*math.sin(math.rad(erZ+90))
			local sX, sY, sZ = getElementVelocity(element)
			local vX, vY, vZ = math.sin(erZ*0.0174532925), math.cos(erZ*0.0174532925), math.sin(erX*0.0174532925)
			setElementVelocity(ball,sX-vX*0.8, sY+vY*0.8, sZ+vZ*10)
		setTimer(function()
			setElementVelocity(ball,0,0,0)
		end,2000,1)



		--moveObject(ball,500,x1,y1,z1,erX,erY,erZ,"InQuad")

	end
	end
	end
end
createBall(3753.53,-1057.84,43)
--- add something infront of sandking to once it hit it then ftw
addEvent("onshootTheBall",true)
addEventHandler("onshootTheBall",root,function(bl,x,y,z)
	setElementVelocity(ball,x,y,z)
	--triggerClientEvent(source,"shootTheBall",source,bl,x,y,z)
end)

addEvent("enablesvhit",true)
addEventHandler("enablesvhit",root,function(bl,x,y,z)
	---triggerClientEvent("addHitBall",getRootElement(),ball)
end)

addEventHandler("onVehicleDamage", root,function()
	if source and getElementModel(source) == 495 then
		outputDebugString("HI")
		local eX, eY, eZ = getElementPosition(source)
			local erX, erY, erZ = getElementRotation(source)
			local eX = eX+4*math.cos(math.rad(erZ+90))
			local eY = eY+4*math.sin(math.rad(erZ+90))
			local sX, sY, sZ = getElementVelocity(source)
			--triggerClientEvent("addHitBall", resourceRoot, eX, eY, eZ, erX, erY, erZ, sX, sY, sZ)
		--[[local isBall = getElementData(source,"isBall")
		if isBall then
			outputDebugString("Server first")
			setElementData(source,"isBall",false)
			local x,y,z = getElementPosition(source)
			local eX, eY, eZ = getElementPosition(source)
			local erX, erY, erZ = getElementRotation(source)
			local eX = eX+2*math.cos(math.rad(erZ+90))
			local eY = eY+2*math.sin(math.rad(erZ+90))
			local sX, sY, sZ = getElementVelocity(source)
			local vX, vY, vZ = math.sin(erZ*0.0174532925), math.cos(erZ*0.0174532925), math.sin(erX*0.0174532925)
			--setElementVelocity(ball,sX-vX*0.8, sY+vY*0.8, sZ+vZ*2)

		end]]
	end
end)

--[[
setTimer(function()
	if ball and isElement(ball) then
		local x,y,z = getElementPosition(ball)
		if z < 30 then
			setElementPosition(ball,x,y,35)
		end
	end
end,1000,0)

-- Offsets
local x,y,z,rx,ry,rz= 0,-1.5,-0.1,0,0,-90

function createArmedBobcat(cmd)
    local lx, ly, lz = getElementPosition(localPlayer) -- get the position of the player
    lx = lx + 5 -- add 5 units to the x position

    veh = createVehicle( 422, lx, ly, lz) -- create a bobcat
    base = createObject( 2985, 2,2,2) -- create a minigun_base object
    setElementCollisionsEnabled ( base, false ) -- the minigun_base damages the car
    -- you could alternatively load an empty col file for the minigun object
    attachElements ( base, veh,  x,y,z,rx,ry,rz) -- attach the base to the bobcat
end

function rotateIt(cmd, addZ)
    if(addZ) then
        local x, y, z, rx, ry, rz = getElementAttachedOffsets (base) -- get the offsets
        rz = rz + addZ
        setElementAttachedOffsets (base, x, y, z, rx, ry, rz) -- update offsets
    end
end


]]

--3054
--3065
--14567
