addEventHandler ( "onClientResourceStart", getResourceRootElement ( getThisResource() ),
	function ()
		txd = engineLoadTXD ( "sandking.txd" )
		engineImportTXD ( txd, 495 )
		dff = engineLoadDFF ( "sandking.dff" )
		engineReplaceModel ( dff, 495 )
	end
)

--[[local weapon = {sound = {}} 
local weapon2 = {sound = {}} 
  
addEvent("onCreateWeaponVehicle", true) 
addEventHandler("onCreateWeaponVehicle", root, 
function (weaponID, thePlayer) 
    local theVehicle = source 
    if not weaponID then weaponID= 38 end 
    if (getElementType(theVehicle) == "vehicle") then 
        local x, y, z = getElementPosition(theVehicle) 
        weapon[theVehicle] = createWeapon(weaponID, x, y, z) 
        weapon2[theVehicle] = createWeapon(weaponID, x, y, z) 
		setWeaponFiringRate (weapon[theVehicle], 7)
		setWeaponFiringRate (weapon2[theVehicle], 7)
        attachElements(weapon[theVehicle], theVehicle, -1.13, 1.54, 0.13, 0, 0, 90) 
        attachElements(weapon2[theVehicle], theVehicle, 1.13, 1.54, 0.13, 0, 0, 90) 
        setElementData(weapon[theVehicle], "theWOwner", thePlayer)
		setElementData(weapon2[theVehicle], "theWOwner", thePlayer)
        setElementAlpha(weapon[theVehicle], 255)  
        setElementAlpha(weapon2[theVehicle], 255)  
        setWeaponClipAmmo(weapon[theVehicle], 1000) 
        setWeaponClipAmmo(weapon2[theVehicle], 1000) 
    end 
end) 

addEventHandler("onClientElementDestroy", getRootElement(), function ()
	if (getElementType(source) == "vehicle") then
		if ( getElementModel ( source  ) == 495 ) then 
			 local theVehicle = source 
			if (getElementType(theVehicle) == "vehicle") and (weapon[theVehicle]) and (weapon2[theVehicle]) then 
				if (weapon.sound[theVehicle]) then 
					stopSound(weapon.sound[theVehicle]) 
					stopSound(weapon2.sound[theVehicle]) 
					weapon.sound[theVehicle] = nil 
					weapon2.sound[theVehicle] = nil 
				end 
				destroyElement (weapon[theVehicle]) 
				destroyElement (weapon2[theVehicle])
			end 
		end 
	end
end)
  
  
addEvent("onRemoveWeaponVehicle", true) 
addEventHandler("onRemoveWeaponVehicle", root, 
function (thePlayer) 
    local theVehicle = source 
    if (getElementType(theVehicle) == "vehicle") and (weapon[theVehicle]) and (weapon2[theVehicle]) then 
		if (weapon.sound[theVehicle]) then 
            stopSound(weapon.sound[theVehicle]) 
            stopSound(weapon2.sound[theVehicle]) 
            weapon.sound[theVehicle] = nil 
            weapon2.sound[theVehicle] = nil 
        end 
        destroyElement (weapon[theVehicle]) 
        destroyElement (weapon2[theVehicle])
    end 
end) 

addEvent("onWeaponVehicleFiring", true) 
addEventHandler("onWeaponVehicleFiring", root, 
function( ) 
    local theVehicle = source 
	if (not isElement(weapon[theVehicle]) and not isElement(weapon2[theVehicle])) then 
        local x, y, z = getElementPosition(theVehicle) 
        weapon[theVehicle] = createWeapon(weaponID, x, y, z) 
        weapon2[theVehicle] = createWeapon(weaponID, x, y, z) 
		setWeaponFiringRate (weapon[theVehicle], 8)
		setWeaponFiringRate (weapon2[theVehicle], 8)
        attachElements(weapon[theVehicle], theVehicle, -1.13, 1.54, 0.13, 0, 0, 90) 
        attachElements(weapon2[theVehicle], theVehicle, 1.13, 1.54, 0.13, 0, 0, 90) 
        setElementData(weapon[theVehicle], "theWOwner", thePlayer)
		setElementData(weapon2[theVehicle], "theWOwner", thePlayer)
        setElementAlpha(weapon[theVehicle], 255)  
        setElementAlpha(weapon2[theVehicle], 255)  
        setWeaponClipAmmo(weapon[theVehicle], 1000) 
        setWeaponClipAmmo(weapon2[theVehicle], 1000) 
    end 
    if (theVehicle) and (weapon[theVehicle]) and (weapon2[theVehicle]) then 
        setWeaponState(weapon[theVehicle], "firing") 
        setWeaponState(weapon2[theVehicle], "firing") 
		local x, y, z = getElementPosition(theVehicle) 
        local xm, ym, zm = getElementPosition(weapon[theVehicle]) 
        local xm2, ym2, zm2 = getElementPosition(weapon2[theVehicle]) 
        if not (weapon.sound[theVehicle]) then 
            weapon.sound[theVehicle] = playSound3D("minigun.wav", xm, ym, zm, true) 
            weapon2.sound[theVehicle] = playSound3D("minigun.wav", xm2, ym2, zm2, true) 
            setSoundMaxDistance(weapon.sound[theVehicle], 100) 
            setSoundMaxDistance(weapon2.sound[theVehicle], 100) 
            setSoundEffectEnabled(weapon.sound[theVehicle], "gargle", true) 
            setSoundEffectEnabled(weapon2.sound[theVehicle], "gargle", true) 
            attachElements(weapon.sound[theVehicle], weapon[theVehicle]) 
            attachElements(weapon2.sound[theVehicle], weapon2[theVehicle]) 
        end 
    end 
end) 
  
addEvent("onWeaponVehicleReady", true) 
addEventHandler("onWeaponVehicleReady", root, 
function ( ) 
    local theVehicle = source 
	if (not isElement(weapon[theVehicle]) and not isElement(weapon2[theVehicle])) then 
        local x, y, z = getElementPosition(theVehicle) 
        weapon[theVehicle] = createWeapon(weaponID, x, y, z) 
        weapon2[theVehicle] = createWeapon(weaponID, x, y, z) 
		setWeaponFiringRate (weapon[theVehicle], 8)
		setWeaponFiringRate (weapon2[theVehicle], 8)
        attachElements(weapon[theVehicle], theVehicle, -1.13, 1.54, 0.13, 0, 0, 90) 
        attachElements(weapon2[theVehicle], theVehicle, 1.13, 1.54, 0.13, 0, 0, 90) 
        setElementData(weapon[theVehicle], "theWOwner", thePlayer)
		setElementData(weapon2[theVehicle], "theWOwner", thePlayer)
        setElementAlpha(weapon[theVehicle], 255)  
        setElementAlpha(weapon2[theVehicle], 255)  
        setWeaponClipAmmo(weapon[theVehicle], 1000) 
        setWeaponClipAmmo(weapon2[theVehicle], 1000) 
    end 
    if (theVehicle) and (isElement(weapon[theVehicle])) and (isElement(weapon2[theVehicle])) then 
        setWeaponState(weapon[theVehicle], "ready") 
        setWeaponState(weapon2[theVehicle], "ready") 
        if (weapon.sound[theVehicle]) then 
            stopSound(weapon.sound[theVehicle]) 
            stopSound(weapon2.sound[theVehicle]) 
            weapon.sound[theVehicle] = nil 
            weapon2.sound[theVehicle] = nil 
        end 
    end 
end) 
  
bindKey("r", "up", 
function( ) 
    local theVehicle = getPedOccupiedVehicle(localPlayer) 
    if (theVehicle) and (getVehicleController(theVehicle) == thePlayer) then 
        setWeaponState(weapon[theVehicle], "reloading") 
        setWeaponState(weapon2[theVehicle], "reloading") 
    end 
end) 
  
addEventHandler("onClientWeaponFire", getRootElement(), 
function (element) 
    local theVehicle = getPedOccupiedVehicle(localPlayer) 
    if (theVehicle) and (isElement(weapon[theVehicle])) and (isElement(weapon2[theVehicle])) then 
        if (element == theVehicle) then 
            cancelEvent() 
        end 
    end 
    if (isElement(element) and getElementData(element, "isPlayerProtected")) then
        cancelEvent()
    end
end) 
  
addEventHandler("onElementDestroy", root, 
function ( ) 
    local theVehicle = source 
    if (theVehicle) and (isElement(weapon[theVehicle])) and (isElement(weapon2[theVehicle])) then 
         destroyElement (weapon[theVehicle]) 
         destroyElement (weapon2[theVehicle]) 
         weapon[theVehicle] = nil 
         weapon2[theVehicle] = nil 
         setElementData(weapon[theVehicle], "theWOwner", false)
		 setElementData(weapon2[theVehicle], "theWOwner", false)
    end 
end) ]]--