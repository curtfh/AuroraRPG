

antispam = {}
local cando = true
local waitseconds = 1

local banner
local pfeile

addEventHandler('onClientResourceStart', resourceRoot,
function()
	local txd = engineLoadTXD ( "Files/road.txd" )
	engineImportTXD ( txd, 2501 )
	local dff = engineLoadDFF ( "Files/road.dff", 2501 )
	engineReplaceModel ( dff, 2501 )
	local col = engineLoadCOL ( "Files/road.col" )
	engineReplaceCOL ( col, 2501 )


	local txd5 = engineLoadTXD('files/balltxd.txd', true)
	engineImportTXD( txd5, 1305 )
	local dff5 = engineLoadDFF('files/ball.dff', 0)
	engineReplaceModel( dff5, 1305 )

	local txd5 = engineLoadTXD('files/balltxd.txd', true)
	engineImportTXD( txd5, 471 )
	local dff5 = engineLoadDFF('files/ball.dff', 0)
	engineReplaceModel( dff5, 471 )

	createMap()
	engineSetModelLODDistance(2501, 500)

	local objects = getElementsByType ( "object", resourceRoot )
	for theKey,object in ipairs(objects) do
		local id = getElementModel(object)
		if id == 2501 then
			local x,y,z = getElementPosition(object)
			local rx,ry,rz = getElementRotation(object)
			local scale = getObjectScale(object)
			objLowLOD = createObject ( id, x,y,z,rx,ry,rz,true )
			setObjectScale(objLowLOD, scale)
			setLowLODElement ( object, objLowLOD )
			engineSetModelLODDistance ( id, 3000 )
			setElementStreamable ( object , false)
		elseif id == 1305 then
			engineSetModelLODDistance ( id, 3000 )
		end
	end
end
)

addEventHandler("onClientVehicleDamage",root,function(atk)
	--[[if atk and getElementType(atk) == "object" then
		if getElementData(atk,"carball") == true then
			local x,y,z = getElementPosition(source)
			setElementPosition(source,x,y,z)
			if isTimer(antispam) then

			else
				setElementData(source,"isBall",atk)
				outputDebugString("ILL HIT")
				local eX, eY, eZ = getElementPosition(atk)
				local erX, erY, erZ = getElementRotation(source)
				local eX = eX+2*math.cos(math.rad(erZ+90))
				local eY = eY+2*math.sin(math.rad(erZ+90))
				local sX, sY, sZ = getElementVelocity(source)
				local vX, vY, vZ = math.sin(erZ*0.0174532925), math.cos(erZ*0.0174532925), math.sin(erX*0.0174532925)
				--1305
				for k,v in ipairs(getElementsByType("player")) do
					triggerEvent("shootTheBall",root,atk,sX-vX*1, sY+vY*1, sZ+vZ*4)
				end
				antispam = setTimer(function() cando = true end, waitseconds*2000, 1)
			end
			cancelEvent()

		end
	end]]
end)
--https://wiki.multitheftauto.com/wiki/GetCameraClip
function hitter(collider,force, bodyPart, x, y, z, nx, ny, nz)
	if ( source == getPedOccupiedVehicle(localPlayer) ) then
		if collider and getElementData(collider,"carball") == true then
			if (cando == false) then return end
			if isTimer(antispam) then return false end
			local x,y,z = getElementPosition(source)
			setElementPosition(source,x,y,z)
			--local x,y,z, erX, erY, erZ = getCameraMatrix ()
			---local erZ = 360 - getPedCameraRotation(localPlayer)
			local eX, eY, eZ = getElementPosition(collider)
			local erX, erY, erZ = getElementRotation(source)
			local eX = eX+2*math.cos(math.rad(erZ+90))
			local eY = eY+2*math.sin(math.rad(erZ+90))
			local sX, sY, sZ = getElementVelocity(source)
			local vX, vY, vZ = math.sin(erZ*0.0174532925), math.cos(erZ*0.0174532925), math.sin(erX*0.0174532925)
			cando = false
			antispam = setTimer(function() cando = true end, waitseconds*2000, 1)
			--setElementVelocity(collider,sX-vX*1, sY+vY*1, sZ+vZ*4)
			--setElementData(collider,"ballShoot",{sX-vX*1, sY+vY*1, sZ+vZ*4})




			--triggerServerEvent("moveCarBall",localPlayer,sX-vX*0.8, sY+vY*0.8, sZ+vZ*2)

			reloadSound = playSound("kick.mp3")


		end
	end
end

addEvent("shootTheBall",true)
addEventHandler("shootTheBall",root,function(theBall,x,y,z)
	setElementVelocity(theBall,x,y,z)
end)
MYBALL = {}
addEvent("addHitBall",true)
addEventHandler("addHitBall",root,function(eX, eY, eZ, erX, erY, erZ, sX, sY, sZ, theCreator)
	--[[local vX, vY, vZ = math.sin(erZ*0.0174532925), math.cos(erZ*0.0174532925), math.sin(erX*0.0174532925)
	local theObject = createObject(1305, eX, eY, eZ, erX, erY, erZ, false)
	theDummy = createVehicle(471, eX, eY, eZ+2, erX, erY, erZ) -- 594 RC Pot
	setElementAlpha(theDummy, 0)
	attachElements(theObject, theDummy)
	setElementVelocity(theDummy, sX-vX*4, sY+vY*4, sZ+vZ*4)
	setTimer(function()
		destroyElement(theDummy)
	end, 100, 1)]]
end)
theDummy = nil
theCOL = nil
--[[
addEventHandler( "onClientRender", root,function(  )
	if MYBALL and isElement(MYBALL) then
		if isTimer(antispam) then return false end
		if getPedOccupiedVehicle(localPlayer) then
			if theDummy and isElement(theDummy) then

			else
				theDummy = createVehicle(471, 3753.53,-1051.84,43) -- 594 RC Pot
				for i,veh in ipairs(getElementsByType("vehicle")) do
					setElementCollidableWith(theDummy, veh, true)
				end
				theCOL = createColSphere(0, 0, 0, 2)
				--setElementAlpha(theDummy, 0)
				attachElements(MYBALL, theDummy)
				attachElements(theCOL, theDummy)
			end
			if theDummy and isElement(theDummy) and theCOL and isElement(theCOL) then
				local car = getPedOccupiedVehicle(localPlayer)
				if car and isElementWithinColShape(car,theCOL) then
					if getElementModel(car) ~= 471 then
						if antispam and isTimer(antispam) then return false end
						local mx,my,mz = getElementVelocity(MYBALL)
						if math.floor(mx) == 0 then return false end
						local eX, eY, eZ = getElementPosition(MYBALL)
						local erX, erY, erZ = getElementRotation(car)
						local eX = eX+2*math.cos(math.rad(erZ+90))
						local eY = eY+2*math.sin(math.rad(erZ+90))
						local sX, sY, sZ = getElementVelocity(car)
						local vX, vY, vZ = math.sin(erZ*0.0174532925), math.cos(erZ*0.0174532925), math.sin(erX*0.0174532925)
						antispam = setTimer(function() cando = true end, 4000, 1)
						for k,v in ipairs(getElementsByType("player")) do
							triggerEvent("shootTheBall",v,MYBALL,sX-vX*1, sY+vY*1, sZ+vZ*4)
						end
						if isElement(theDummy) then
							destroyElement(theDummy)
						end
						if isElement(theCOL) then
							destroyElement(theCOL)
						end
					end
				end
			end
		end

	end
end)
1305
]]
function lod()
	for k,v in ipairs(getElementsByType("object",resourceRoot)) do
		setObjectBreakable(v, false)
		if getElementModel(v) == 1305 then
			local mass = getObjectMass(v)
			setObjectMass(v,0)
			outputDebugString("Object mass done old "..mass)
		end
	end
	for k,v in pairs(getElementsByType("vehicle")) do
		removeEventHandler("onClientVehicleCollision",v,hitter)
		addEventHandler("onClientVehicleCollision",v,hitter)
	end
	triggerServerEvent("enablesvhit",localPlayer)
end
setTimer(lod,3000,1)

setTimer(function()
	for i2,veh2 in ipairs(getElementsByType("vehicle")) do
		for i,veh in ipairs(getElementsByType("vehicle")) do
			if getElementModel(veh) == 594 then
				setElementCollidableWith(veh2, veh,true)
			end
		end
	end
end,3000,0)


addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		banner = dxCreateShader ( "uv_scripted.fx" )
		engineApplyShaderToWorldTexture ( banner, "_color11" )

		pfeile = dxCreateShader ( "uv_scripted.fx" )
		engineApplyShaderToWorldTexture ( pfeile, "color_a1" )


		addEventHandler( "onClientRender", root, anim )
		addEventHandler( "onClientRender", root, anim2 )
		v,r = 0.5,0.5
		v2 = 0
	end
)

function anim()
	if r == 0.5 then
		v = math.round(v+0.01,3)
	elseif r == 1 then
		v = math.round(v-0.01,3)
	end
	if v >= 1 or v == 0.5 then
		setTimer(function() addEventHandler( "onClientRender", root, anim ) end, 5000,1)
		removeEventHandler( "onClientRender", root, anim )
		r = v
	end
	dxSetShaderValue ( banner, "gUVPosition", 0,v );
end

function anim2()
	v2 = v2 + 0.02
	if v2 >= 1 then
		v2 = 0
	end
	dxSetShaderValue ( pfeile, "gUVPosition", 0,v2 );

end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


function createMap()
	Objects = {
		createObject (10828,3536,-1160.7,53.8,0,0,0),
		createObject (10828,3536,-1160.7,68.3,0,0,0),
		createObject (10828,3536,-1160.7,82.9,0,0,0),
		createObject (10828,3536,-1160.7,97.2,0,0,0),
		createObject (10828,3536,-1160.7,111.3,0,0,0),
		createObject (10828,3571.3,-1160.7,53.8,0,0,0),
		createObject (10828,3606.3,-1160.7,53.8,0,0,0),
		createObject (10828,3641.6001,-1160.7,53.8,0,0,0),
		createObject (10828,3676.7,-1160.8,53.8,0,0,0),
		createObject (10828,3711.8,-1160.8,53.8,0,0,0),
		createObject (10828,3746.8999,-1160.8,53.8,0,0,0),
		createObject (10828,3781.8999,-1160.9,53.8,0,0,0),
		createObject (10828,3816.8,-1160.9,53.8,0,0,0),
		createObject (10828,3851.6001,-1160.9,53.8,0,0,0),
		createObject (10828,3886.3,-1160.9,53.8,0,0,0),
		createObject (10828,3921.5,-1160.9,53.8,0,0,0),
		createObject (10828,3956.6001,-1160.9,53.8,0,0,0),
		createObject (10828,3972.8,-1160.7,53.8,0,0,0),
		createObject (10828,3989.8999,-1142.2,53.8,0,0,90),
		createObject (10828,3990,-1107.2,53.8,0,0,90),
		createObject (10828,3990,-1072,53.8,0,0,90),
		createObject (10828,3990,-1036.9,53.8,0,0,90),
		createObject (10828,3990,-1001.7,53.8,0,0,90),
		createObject (10828,3989.8999,-971,53.8,0,0,90),
		createObject (10828,3971.5,-957.20001,53.8,0,0,0),
		createObject (10828,3936.6001,-957.20001,53.8,0,0,0),
		createObject (10828,3901.5,-957.20001,53.8,0,0,0),
		createObject (10828,3866.3999,-957.09998,53.8,0,0,0),
		createObject (10828,3831.3999,-957.09998,53.8,0,0,0),
		createObject (10828,3796.6001,-957.09998,53.8,0,0,0),
		createObject (10828,3761.6001,-957.09998,53.8,0,0,0),
		createObject (10828,3726.6001,-957,53.8,0,0,0),
		createObject (10828,3691.8,-957,53.8,0,0,0),
		createObject (10828,3657,-957,53.8,0,0,0),
		createObject (10828,3622.2,-957,53.8,0,0,0),
		createObject (10828,3587.5,-957.09998,53.8,0,0,0),
		createObject (10828,3552.7,-957.09998,53.8,0,0,0),
		createObject (10828,3534.3999,-957,53.8,0,0,0),
		createObject (10828,3517.3,-975.09998,53.8,0,0,90),
		createObject (10828,3517.2,-1010,53.8,0,0,90),
		createObject (10828,3517.2,-1045.3,53.8,0,0,90),
		createObject (10828,3517.2,-1080.4,53.8,0,0,90),
		createObject (10828,3517.2,-1115.8,53.8,0,0,90),
		createObject (10828,3517.3,-1150.9,53.8,0,0,90),
		createObject (10828,3517.3,-1150.9,68.5,0,0,90),
		createObject (10828,3517.3,-1150.9,83,0,0,90),
		createObject (10828,3517.3,-1150.9,97.3,0,0,90),
		createObject (10828,3517.3,-1150.9,111.1,0,0,90),
		createObject (10828,3517.2,-1115.8,67,0,0,90),
		createObject (10828,3517.2,-1115.8,80.3,0,0,90),
		createObject (10828,3517.2,-1115.8,93.1,0,0,90),
		createObject (10828,3517.2,-1115.8,107.3,0,0,90),
		createObject (10828,3517.2,-1115.8,111.7,0,0,90),
		createObject (10828,3517.2,-1080.4,66.8,0,0,90),
		createObject (10828,3517.2,-1080.4,80.6,0,0,90),
		createObject (10828,3517.2,-1080.4,94.3,0,0,90),
		createObject (10828,3517.2,-1080.4,107.8,0,0,90),
		createObject (10828,3517.2,-1080.4,111.7,0,0,90),
		createObject (10828,3517.2,-1045.3,66.8,0,0,90),
		createObject (10828,3517.2,-1045.3,80.3,0,0,90),
		createObject (10828,3517.2,-1045.3,93.8,0,0,90),
		createObject (10828,3517.2,-1045.3,108.3,0,0,90),
		createObject (10828,3517.2,-1045.3,111.7,0,0,90),
		createObject (10828,3517.2,-1010,67.8,0,0,90),
		createObject (10828,3517.2,-1010,81.3,0,0,90),
		createObject (10828,3517.2,-1010,94.1,0,0,90),
		createObject (10828,3517.2,-1010,108.3,0,0,90),
		createObject (10828,3517.2,-1010,111.7,0,0,90),
		createObject (10828,3517.3,-975.09998,68,0,0,90),
		createObject (10828,3517.3,-975.09998,82,0,0,90),
		createObject (10828,3517.3,-975.09998,96,0,0,90),
		createObject (10828,3517.3,-975.09998,108.8,0,0,90),
		createObject (10828,3517.3,-975.09998,111.5,0,0,90),
		createObject (10828,3534.3999,-957,67,0,0,0),
		createObject (10828,3534.3999,-957,80.8,0,0,0),
		createObject (10828,3534.3999,-957,95.3,0,0,0),
		createObject (10828,3534.3999,-957,109.6,0,0,0),
		createObject (10828,3534.3999,-957,111.6,0,0,0),
		createObject (10828,3552.7,-957.09998,67.8,0,0,0),
		createObject (10828,3552.7,-957.09998,82.1,0,0,0),
		createObject (10828,3552.7,-957.09998,96.1,0,0,0),
		createObject (10828,3552.7,-957.09998,110.8,0,0,0),
		createObject (10828,3587.5,-957.09998,66.8,0,0,0),
		createObject (10828,3587.5,-957.09998,81.1,0,0,0),
		createObject (10828,3587.5,-957.09998,94.1,0,0,0),
		createObject (10828,3587.5,-957.09998,108.3,0,0,0),
		createObject (10828,3587.5,-957.09998,111.7,0,0,0),
		createObject (10828,3622.2,-957,67.8,0,0,0),
		createObject (10828,3622.2,-957,81.8,0,0,0),
		createObject (10828,3622.2,-957,96.1,0,0,0),
		createObject (10828,3622.2,-957,111.2,0,0,0),
		createObject (10828,3657,-957,67.5,0,0,0),
		createObject (10828,3657,-957,80.8,0,0,0),
		createObject (10828,3657,-957,94.6,0,0,0),
		createObject (10828,3657,-957,94.6,0,0,0),
		createObject (10828,3657,-957,107.8,0,0,0),
		createObject (10828,3657,-957,111.1,0,0,0),
		createObject (10828,3691.8,-957,67.8,0,0,0),
		createObject (10828,3691.8,-957,81.1,0,0,0),
		createObject (10828,3691.8,-957,95.1,0,0,0),
		createObject (10828,3691.7998,-957,95.1,0,0,0),
		createObject (10828,3691.8,-957,108.6,0,0,0),
		createObject (10828,3691.8,-957,110.9,0,0,0),
		createObject (10828,3726.6001,-957,66.5,0,0,0),
		createObject (10828,3726.6001,-957,80.3,0,0,0),
		createObject (10828,3726.6001,-957,94.1,0,0,0),
		createObject (10828,3726.6001,-957,108.1,0,0,0),
		createObject (10828,3726.6001,-957,111.3,0,0,0),
		createObject (10828,3761.6001,-957.09998,66.8,0,0,0),
		createObject (10828,3761.6001,-957.09998,80.6,0,0,0),
		createObject (10828,3761.6001,-957.09998,94.8,0,0,0),
		createObject (10828,3761.6001,-957.09998,111.4,0,0,0),
		createObject (10828,3761.6001,-957.09998,100.4,0,0,0),
		createObject (10828,3796.6001,-957.09998,67,0,0,0),
		createObject (10828,3796.6001,-957.09998,80.8,0,0,0),
		createObject (10828,3796.6001,-957.09998,93.3,0,0,0),
		createObject (10828,3796.6001,-957.09998,106.6,0,0,0),
		createObject (10828,3796.6001,-957.09998,111.2,0,0,0),
		createObject (10828,3831.3999,-957.09998,67.5,0,0,0),
		createObject (10828,3831.3999,-957.09998,81.8,0,0,0),
		createObject (10828,3831.3999,-957.09998,96.6,0,0,0),
		createObject (10828,3831.3999,-957.09998,110.6,0,0,0),
		createObject (10828,3831.4004,-957.09961,110.6,0,0,0),
		createObject (10828,3831.3999,-957.09998,111.7,0,0,0),
		createObject (10828,3866.3999,-957.09998,68.5,0,0,0),
		createObject (10828,3866.3999,-957.09998,81.5,0,0,0),
		createObject (10828,3866.3999,-957.09998,96.3,0,0,0),
		createObject (10828,3866.3999,-957.09998,110.1,0,0,0),
		createObject (10828,3866.3999,-957.09998,111.6,0,0,0),
		createObject (10828,3901.5,-957.20001,67.3,0,0,0),
		createObject (10828,3901.5,-957.20001,81.1,0,0,0),
		createObject (10828,3901.5,-957.20001,95.1,0,0,0),
		createObject (10828,3901.5,-957.20001,110.1,0,0,0),
		createObject (10828,3901.5,-957.20001,111.7,0,0,0),
		createObject (10828,3936.6001,-957.20001,66.3,0,0,0),
		createObject (10828,3936.6001,-957.20001,80.8,0,0,0),
		createObject (10828,3936.6001,-957.20001,94.3,0,0,0),
		createObject (10828,3936.6001,-957.20001,108.8,0,0,0),
		createObject (10828,3936.6001,-957.20001,111.7,0,0,0),
		createObject (10828,3971.5,-957.20001,68,0,0,0),
		createObject (10828,3971.5,-957.20001,81.5,0,0,0),
		createObject (10828,3971.5,-957.20001,95.5,0,0,0),
		createObject (10828,3971.5,-957.20001,109.3,0,0,0),
		createObject (10828,3971.5,-957.20001,111.7,0,0,0),
		createObject (10828,3989.8999,-971,68.5,0,0,90),
		createObject (10828,3989.8999,-971,83.8,0,0,90),
		createObject (10828,3989.8999,-971,98.6,0,0,90),
		createObject (10828,3989.8999,-971,111.7,0,0,90),
		createObject (10828,3990,-1001.7,68.3,0,0,90),
		createObject (10828,3990,-1001.7,83.1,0,0,90),
		createObject (10828,3990,-1001.7,97.6,0,0,90),
		createObject (10828,3990,-1001.7,111.6,0,0,90),
		createObject (10828,3990,-1036.9,68.3,0,0,90),
		createObject (10828,3990,-1036.9,82.8,0,0,90),
		createObject (10828,3990,-1036.9,97.1,0,0,90),
		createObject (10828,3990,-1036.9,111.7,0,0,90),
		createObject (10828,3990,-1072,67,0,0,90),
		createObject (10828,3990,-1072,82.3,0,0,90),
		createObject (10828,3990,-1072,96.3,0,0,90),
		createObject (10828,3990,-1072,110.1,0,0,90),
		createObject (10828,3990,-1107.2,68,0,0,90),
		createObject (10828,3990,-1107.2,83,0,0,90),
		createObject (10828,3990,-1107.2,97.5,0,0,90),
		createObject (10828,3990,-1107.2,111.7,0,0,90),
		createObject (10828,3989.8999,-1142.2,68.5,0,0,90),
		createObject (10828,3989.8999,-1142.2,82.3,0,0,90),
		createObject (10828,3989.8999,-1142.2,96.3,0,0,90),
		createObject (10828,3989.8999,-1142.2,111.4,0,0,90),
		createObject (10828,3972.8,-1160.7,68,0,0,0),
		createObject (10828,3972.8,-1160.7,83.3,0,0,0),
		createObject (10828,3972.8,-1160.7,98.1,0,0,0),
		createObject (10828,3972.8,-1160.7,111.6,0,0,0),
		createObject (10828,3956.6001,-1160.9,68.8,0,0,0),
		createObject (10828,3956.6001,-1160.9,83.6,0,0,0),
		createObject (10828,3956.6001,-1160.9,98.6,0,0,0),
		createObject (10828,3956.6001,-1160.9,111.7,0,0,0),
		createObject (10828,3921.5,-1160.9,69,0,0,0),
		createObject (10828,3921.5,-1160.9,83.8,0,0,0),
		createObject (10828,3921.5,-1160.9,98.1,0,0,0),
		createObject (10828,3921.5,-1160.9,111.4,0,0,0),
		createObject (10828,3886.3,-1160.9,68.3,0,0,0),
		createObject (10828,3886.3,-1160.9,81.8,0,0,0),
		createObject (10828,3886.3,-1160.9,94.8,0,0,0),
		createObject (10828,3886.3,-1160.9,109.3,0,0,0),
		createObject (10828,3886.3,-1160.9,111.2,0,0,0),
		createObject (10828,3851.6001,-1160.9,68.3,0,0,0),
		createObject (10828,3851.6001,-1160.9,82.3,0,0,0),
		createObject (10828,3851.6001,-1160.9,96.3,0,0,0),
		createObject (10828,3851.6001,-1160.9,110.3,0,0,0),
		createObject (10828,3851.6001,-1160.9,111.6,0,0,0),
		createObject (10828,3816.8,-1160.9,68.3,0,0,0),
		createObject (10828,3816.8,-1160.9,82.1,0,0,0),
		createObject (10828,3816.8,-1160.9,96.1,0,0,0),
		createObject (10828,3816.8,-1160.9,109.8,0,0,0),
		createObject (10828,3816.8,-1160.9,111.7,0,0,0),
		createObject (10828,3781.8999,-1160.9,67.3,0,0,0),
		createObject (10828,3781.8999,-1160.9,81.8,0,0,0),
		createObject (10828,3781.8999,-1160.9,96.1,0,0,0),
		createObject (10828,3781.8999,-1160.9,109.8,0,0,0),
		createObject (10828,3781.8999,-1160.9,111.7,0,0,0),
		createObject (10828,3746.8999,-1160.8,68.8,0,0,0),
		createObject (10828,3746.8999,-1160.8,82.3,0,0,0),
		createObject (10828,3746.8999,-1160.8,96.6,0,0,0),
		createObject (10828,3746.8999,-1160.8,111.5,0,0,0),
		createObject (10828,3711.8,-1160.8,68.3,0,0,0),
		createObject (10828,3711.8,-1160.8,81.8,0,0,0),
		createObject (10828,3711.8,-1160.8,95.3,0,0,0),
		createObject (10828,3711.8,-1160.8,109.6,0,0,0),
		createObject (10828,3711.8,-1160.8,111.6,0,0,0),
		createObject (10828,3676.7,-1160.8,68.8,0,0,0),
		createObject (10828,3676.7,-1160.8,82.1,0,0,0),
		createObject (10828,3676.7,-1160.8,95.1,0,0,0),
		createObject (10828,3676.7,-1160.8,109.1,0,0,0),
		createObject (10828,3676.7,-1160.8,111.7,0,0,0),
		createObject (10828,3641.6001,-1160.7,67.3,0,0,0),
		createObject (10828,3641.6001,-1160.7,80.6,0,0,0),
		createObject (10828,3641.6001,-1160.7,95,0,0,0),
		createObject (10828,3641.6001,-1160.7,109.1,0,0,0),
		createObject (10828,3641.6001,-1160.7,111.6,0,0,0),
		createObject (10828,3606.3,-1160.7,67.3,0,0,0),
		createObject (10828,3606.3,-1160.7,79.8,0,0,0),
		createObject (10828,3606.3,-1160.7,94.1,0,0,0),
		createObject (10828,3606.3,-1160.7,107.6,0,0,0),
		createObject (10828,3606.3,-1160.7,111.6,0,0,0),
		createObject (10828,3571.3,-1160.7,68.8,0,0,0),
		createObject (10828,3571.3,-1160.7,82.8,0,0,0),
		createObject (10828,3571.3,-1160.7,97.4,0,0,0),
		createObject (10828,3571.3,-1160.7,111.7,0,0,0),
		createObject (10828,3992,-1089.28,42.48,0,0,120),
		createObject (10828,3984.9,-1028.36,42.48,0,0,70),
		createObject (10828,3513.79,-1028.98,42.48,0,0,120),
		createObject (10828,3518.92,-1089.94,42.48,0,0,70),

		}
		createObject(2501,3696.2,-1056.7,34.5,0,0,0)
		createObject(2501,3811,  -1061.2,34.5,0,0,180)
		for index, object in ipairs ( Objects ) do

			setElementDoubleSided ( object, true )

			setObjectBreakable(object, false)
			engineSetModelLODDistance ( getElementModel(object), 1 )
			setElementAlpha(object,0)
			setObjectScale(object,0.1)

		end
end

