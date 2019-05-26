local rx, ry = guiGetScreenSize()
local nX, nY = 1366, 768
local sX, sY = guiGetScreenSize()
local count = 3
local count2 = 3
local trigger = false
local startProtect = false
local theKiller = {}

function startCountdown(interval)
    countdownImage = guiCreateStaticImage((rx/2)-125, (ry/2)-80, 250, 190, "images/3.png", false)
	if not interval then interval = 2000 end
    setTimer(decrementCountdown, interval, 4)
    countdownCount = 3
	startProtect = true
end
addEvent("startCountDown", true)
addEventHandler("startCountDown", root, startCountdown)

function decrementCountdown()
	countdownCount = countdownCount - 1
	if (countdownCount > 0) then
		guiStaticImageLoadImage (countdownImage, "images/"..countdownCount..".png")
	elseif (countdownCount == 0) then
		destroyElement(countdownImage)
		countdownImage = guiCreateStaticImage((rx/2)-160, (ry/2)-80, 320, 190, "images/go.png", false)
		setTimer(function()
			startProtect = false
		end,2000,1)
	else
		destroyElement(countdownImage)
	end
end

local g_ModelForPickupType = { nitro = 2221, repair = 2222 }

for name,id in pairs(g_ModelForPickupType) do
	engineImportTXD(engineLoadTXD('models/' .. name .. '.txd'), id)
	engineReplaceModel(engineLoadDFF('models/' .. name .. '.dff', id), id)
	engineSetModelLODDistance( id, 60 )
end

function shootmissle()
	if getElementDimension(localPlayer) ~= 5000 then return false end
	if getElementData(localPlayer,"mini-game") == "Shooter" then
		if not isPedDead(localPlayer) then
			if isPedInVehicle(localPlayer) then
				theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle then
					if isTimer(antiSpam) then return false end
					if startProtect then return false end
					if count == 3 then
						local x,y,z = getElementPosition(theVehicle)
						local rX,rY,rZ = getElementRotation(theVehicle)
						local x = x+4*math.cos(math.rad(rZ+90))
						local y = y+4*math.sin(math.rad(rZ+90))
						createProjectile(theVehicle, 19, x, y, z-0.3, 1.0, nil)
						antiSpam = setTimer(function()
							count = 3
						end, 3000, 1)
						count = 0
					end
				end
			end
		end
	end
end

addEvent("onClientVehiclePostDamage", true)
addEventHandler("onClientVehiclePostDamage", root,
function(attacker, weapon)
	if attacker then
		if getElementDimension(source) == 5000 then
			if weapon == 51 then
				if attacker then
					local driver = getVehicleOccupant(source,0)
					if driver then
						if theKiller[source] then return false end
						theKiller[source] = attacker
						setTimer(function(veh) theKiller[veh] = nil end,5000,1,source)
					end
				end
			elseif weapon == 28 then
				if attacker then
					local driver = getVehicleOccupant(source,0)
					if driver then
						if theKiller[source] then return false end
						theKiller[source] = attacker
						setTimer(function(veh) theKiller[veh] = nil end,7000,1,source)
					end
				end
			end
		end
	end
end)

addEventHandler("onClientVehicleExplode", getRootElement(), function()
	if theKiller[source] then
		local driver = getVehicleOccupant(source,0)
		if driver then
			if getElementModel(source) == 520 then
				triggerServerEvent("setHFKiller",theKiller[source],theKiller[source],driver,source)
			elseif getElementModel(source) == 430 then
				triggerServerEvent("setWSKiller",theKiller[source],theKiller[source],driver,source)
			else
				triggerServerEvent("setShooterKiller",theKiller[source],theKiller[source],driver,source)
			end
		end
	end
end)

damer = {}
addEventHandler("onClientVehicleCollision", root,function(hit,force, bodyPart, x, y, z, nx, ny, nz)
	if getElementDimension(source) == 5000 then
		if hit and getElementType(hit) == "vehicle" then
			local driver = getVehicleOccupant(source,0)
			local driver2 = getVehicleOccupant(hit,0)
			if driver and driver2 then
				if getElementData(source,"mini-hit") then
					return false
				end
				setElementData(source,"mini-hit",{driver,driver2})
				damer[source] = driver2
				setTimer(function(d) damer[d] = nil setElementData(d,"mini-hit",false) end,5000,1,source)
			end
		end
	end
end)




function jump()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local team = getPlayerTeam(localPlayer)
	if ( isElement(vehicle) ) and (isVehicleOnGround( vehicle )) and getElementData(localPlayer,"mini-game") == "Shooter" then
		if trigger == false then
			triggerServerEvent("jumpshooter",localPlayer,vehicle)
			trigger = true
			antiSpam2 = setTimer(function()
				trigger = false
				count2 = 3
			end,3000,1)
			count2 = 0
		end
	end
end
bindKey ( "lshift","down", jump)


addEventHandler("onClientResourceStart",resourceRoot,function()
	bindKey("lctrl","down",shootmissle)
	bindKey("lshift","down",jump)
end)


addEventHandler("onClientRender", getRootElement(),function()
	if getElementDimension(localPlayer) ~= 5000 then return false end
	if getElementData(localPlayer,"mini-game") == "Shooter" then
		local vehicle = getPedOccupiedVehicle( localPlayer )
		if vehicle and isElement(vehicle) then
			if isPedInVehicle(localPlayer) then
				if ( getVehicleController( vehicle ) == localPlayer ) then
					dxDrawRectangle( ( 328 / nX ) * sX, ( 662 / nY ) * sY, ( 189 / nX ) * sX, ( 29 / nY ) * sY, tocolor( 0, 0, 0, 125 ), false )
					dxDrawRectangle( ( 330 / nX ) * sX, ( 667 / nY ) * sY, ( count*60 / nX ) * sX, ( 19 / nY ) * sY, tocolor( 34, 135, 38, 255 ), false )
					dxDrawRectangle( ( 328 / nX ) * sX, ( 632 / nY ) * sY, ( 189 / nX ) * sX, ( 29 / nY ) * sY, tocolor( 0, 0, 0, 125 ), false )
					dxDrawRectangle( ( 330 / nX ) * sX, ( 637 / nY ) * sY, ( count2*60 / nX ) * sX, ( 19 / nY ) * sY, tocolor( 34, 135, 38, 255 ), false )
					if count == 0 or startProtect == true then
						text = "Wait"
					else
						text = "Shoot"
					end
					if trigger == true then
						text2 = "Wait"
					else
						text2 = "Jump"
					end
					dxDrawText( text, ( 495 / nX ) * sX, ( 765 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
					dxDrawText( text2, ( 495 / nX ) * sX, ( 705 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
					dxDrawText( "Left Ctrl - Fire", ( 495 / nX ) * sX, ( 815 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
					dxDrawText( "Left Shift - Jump", ( 495 / nX ) * sX, ( 855 / nY ) * sY, ( 347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
				end
			end
		end
	end
end)
