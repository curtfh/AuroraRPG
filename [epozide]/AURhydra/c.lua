local isRender = false;
local loadedPercent = 0;

local sx, sy = guiGetScreenSize ( ) 
function dxDrawLocator ( )
	if ( isPedInVehicle ( localPlayer ) ) then
		dxDrawRectangle ( sx-225, sy-55, 210, 40, tocolor ( 0, 0, 0, 255 ) )
		dxDrawRectangle ( sx-220, sy-50, loadedPercent*2, 30, tocolor ( 0, 139, 139, 102 ) )
		if ( loadedPercent >= 100 ) then
			t = "Missile is ready to fire!"
			toggleControl ( "vehicle_secondary_fire", true )
		else
			t = "Missile loading... "..tostring ( math.floor ( loadedPercent ) ).."%"
			loadedPercent = loadedPercent + 0.2
			toggleControl ( "vehicle_secondary_fire", false )
		end
		dxDrawText ( t, sx-209, sy-44, 200, 30, tocolor ( 0, 0, 0, 255 ), 1.2, 'default', 'left', 'top' )
		dxDrawText ( t, sx-210, sy-45, 200, 30, tocolor ( 255, 175, 0, 255 ), 1.2, 'default', 'left', 'top' )
	else
		openLocator ( false )
	end
end

function openLocator ( s )
	if ( s and not isRender ) then
		isRender = true
		addEventHandler ( "onClientRender", root, dxDrawLocator )
	elseif ( not is and isRender ) then
		isRender = false
		removeEventHandler ( "onClientRender", root, dxDrawLocator )
	end
end

addEventHandler ( "onClientVehicleEnter", root, function ( v, s )
	if ( v == localPlayer and getElementModel ( source ) == 520 and s == 0 ) then
		openLocator ( true )
	end
end )


function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
	local _width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end

if ( isPedInVehicle ( localPlayer ) ) then
	local x = getPedOccupiedVehicle ( localPlayer )
	if ( getElementModel ( x ) == 520 and getVehicleOccupants ( x ) [ 0 ] == localPlayer ) then
		openLocator ( true )
	end
end 

local timer
function vehicleWeaponFire(key, keyState, vehicleFireType)
	local vehModel = getElementModel(getPedOccupiedVehicle(getLocalPlayer()))
	--outputDebugString("ASDASDASD")
	if (vehModel == 520 and loadedPercent >= 100 ) then
		loadedPercent = 0
		--outputDebugString("ASD")
		timer = setTimer ( function ( )
			if ( loadedPercent >= 100 ) then
				killTimer(timer)
				--outputDebugString("NO SHOOT KILL")
				return
			end
			toggleControl ( "vehicle_secondary_fire", false )
			toggleControl ( "vehicle_fire", false ) 
			--outputDebugString("NO SHOOT")
		end, 100, 0 )
	end
end
bindKey("vehicle_secondary_fire", "down", vehicleWeaponFire, "secondary")
