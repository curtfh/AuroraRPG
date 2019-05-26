--[[local theVehs = {}
local theVehs2 = {}
local theVehs3 = {}
local theVehs4 = {}

function keyFire(source) 
    local theVehicle = getPedOccupiedVehicle(source) 
    if (theVehicle) and (getVehicleController(theVehicle) == source) then 
	if (getElementData (source, "isPlayerProtected") == true) then return false end
	if (theVehs3[theVehicle] == true) then return end
        triggerClientEvent("onWeaponVehicleFiring", theVehicle) 
    end 
end 
  
function keyStopFire(source) 
    local theVehicle = getPedOccupiedVehicle(source) 
    if (theVehicle) and (getVehicleController(theVehicle) == source) then 
        triggerClientEvent("onWeaponVehicleReady", theVehicle) 
    end 
end 


function onEnter(thePlayer)  
    local theVehicle = getPedOccupiedVehicle(thePlayer) 
	if (type(getElementData(theVehicle, "sellPrice")) ~= "number") then return false end
	if (tonumber(getElementData(theVehicle, "sellPrice")) <= 5000000) then return false end
    if ( getElementModel ( theVehicle ) == 495 ) then 
    if (getVehicleController(theVehicle) == thePlayer) then 
		bindKey(thePlayer, "vehicle_secondary_fire", "down", keyFire) 
		bindKey(thePlayer, "vehicle_secondary_fire", "up", keyStopFire) 
        triggerClientEvent("onCreateWeaponVehicle", theVehicle, id, thePlayer) 
		setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0.30)
		theVehs[theVehicle] = setTimer(function(vehicle)
			if (not isElement(vehicle)) then 
				triggerClientEvent("onRemoveWeaponVehicle", theVehicle ) 
				killTimer(theVehs[vehicle]) 
				theVehs[vehicle] = nil
				return false
			end 
			if getElementHealth(vehicle) == 1000 then 
				setElementHealth (vehicle, 3000)
			end
		end, 5000, 0, theVehicle)
		theVehs2[theVehicle] = setTimer(function(vehicle)
			if (not isElement(vehicle)) then
				if (isTimer(theVehs2[vehicle])) then
					killTimer(theVehs2[vehicle])
					theVehs2[vehicle] = nil
				end
				return false
			end
			if (theVehs3[theVehicle] == true) then 
				theVehs3[theVehicle] = false
				triggerClientEvent("onWeaponVehicleReady", theVehicle) 
			else
				theVehs3[theVehicle] = true
			end 
		end, 300000, 0, theVehicle)
		theVehs4[theVehicle] = setTimer(function(vehicle) 
			if (not isTimer(theVehs2[vehicle])) then 
				if (isTimer(theVehs4[vehicle])) then
					killTimer(theVehs4[vehicle])
				end
				return false
			end 
			if (not isElement(vehicle)) then
				if (isTimer(theVehs4[vehicle])) then
					killTimer(theVehs4[vehicle])
					theVehs4[vehicle] = nil
				end
				return false
			end
			local rem, _, _ = getTimerDetails ( theVehs2[vehicle] )
			if (getElementData (thePlayer, "isPlayerProtected") == true) then
				triggerClientEvent("onWeaponVehicleReady", vehicle) 
				if (theVehs3[vehicle] == true) then 
					exports.AURstickynote:displayText(thePlayer, "armdvehnote", "text", "Press LCTRL to shoot (disabled) Minigun Cooldown: "..(rem/1000).."s.", 255, 0, 0)
				else
					exports.AURstickynote:displayText(thePlayer, "armdvehnote", "text", "Press LCTRL to shoot (disabled)", 255, 0, 0)
				end				
			else
				if (theVehs3[vehicle] == true) then 
					exports.AURstickynote:displayText(thePlayer, "armdvehnote", "text", "Press LCTRL to shoot Minigun Cooldown: "..(rem/1000).."s.", 255, 0, 0)
				else
					exports.AURstickynote:displayText(thePlayer, "armdvehnote", "text", "Press LCTRL to shoot", 255, 0, 0)
				end				
			end
			
		end, 1000, 0, vehicle)
      end 
   end 
end 
addEventHandler ( "onVehicleEnter", getRootElement(), onEnter ) 
  
function onExit(thePlayer) 
	local theVehicle = source
	if (type(getElementData(theVehicle, "sellPrice")) ~= "number") then return false end
	if (tonumber(getElementData(source, "sellPrice")) <= 5000000) then return false end
     if ( getElementModel ( source  ) == 495 ) then 
		exports.AURstickynote:displayText(thePlayer, "armdvehnote", "text", "")
         triggerClientEvent("onRemoveWeaponVehicle", source, thePlayer ) 
		 unbindKey(thePlayer, "vehicle_secondary_fire", "down", keyFire) 
		 unbindKey(thePlayer, "vehicle_secondary_fire", "up", keyStopFire)
		 if (isTimer(theVehs[source])) then 
			killTimer(theVehs[source])
			killTimer(theVehs2[source])
			killTimer(theVehs4[source])
			theVehs[source] = nil
			theVehs2[source] = nil
			theVehs4[source] = nil
		 end 
    end 
end 
addEventHandler ( "onVehicleExit", getRootElement(), onExit ) 

function notifyAboutExplosion()
    if ( getElementModel ( source  ) == 495 ) then 
         triggerClientEvent("onRemoveWeaponVehicle", source ) 
		 if (isTimer(theVehs[source])) then 
			killTimer(theVehs[source])
			killTimer(theVehs2[source])
			killTimer(theVehs4[source])
			theVehs[source] = nil
			theVehs2[source] = nil
			theVehs4[source] = nil
		 end 
    end 
end
addEventHandler("onVehicleExplode", getRootElement(), notifyAboutExplosion)

function getSourceResourceOfElementDestruction()
	if (getElementType(source) == "vehicle") then
		if ( getElementModel ( source  ) == 495 ) then 
			 if (isTimer(theVehs[source])) then 
				killTimer(theVehs[source])
				killTimer(theVehs2[source])
				killTimer(theVehs4[source])
				theVehs[source] = nil
				theVehs2[source] = nil
				theVehs4[source] = nil
			 end 
		end 
	end
end
addEventHandler("onElementDestroy", getRootElement(), getSourceResourceOfElementDestruction)

function takelessDmg(loss)
	if (getElementType(source) == "vehicle") then
		if (type(getElementData(source, "sellPrice")) ~= "number") then return false end
		if (type(getElementData(source, "sellPrice")) == nil) then return false end
		if (tonumber(getElementData(source, "sellPrice")) <= 5000000) then return false end
		if ( getElementModel ( source  ) == 495 ) then 
			if (loss >= 20) then 
				--setElementHealth (source, getElementHealth(source)+200)
			end 
			setVehicleWheelStates (source, 0, 0, 0, 0)
		end
	end
end
addEventHandler("onVehicleDamage", getRootElement(), takelessDmg)

  
]]--