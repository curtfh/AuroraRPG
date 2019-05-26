text = ""
stat = 0
r = tonumber( 0 )
g = tonumber( 255 )
b = tonumber( 0 )
local cycle = 0
local bike = 0
local nX, nY = 1366, 768
local sX, sY = guiGetScreenSize()

 function setStats( ptext, pstat, rc, gc, bc )
	text = ptext
	stat = tonumber( pstat )
	r = tonumber( rc )
	g = tonumber( gc )
	b = tonumber( bc )
end

addEvent( "setCycleSkillsData", true )
function setCycleSkillsData ( cyclestats )
	local pstat = 1.89 * ( cyclestats / 10 )
	ptext = tostring( "Cycle Skills: "..math.ceil( cyclestats / 10 ).. "%" )
	setStats( ptext, pstat, 0, 255, 0 )
end
addEventHandler( "setCycleSkillsData", localPlayer, setCycleSkillsData )

addEvent( "setBikeSkillsData", true )
function setBikeSkillsData ( bikestats )
	local pstat = 1.89 * ( bikestats / 10 )
	ptext = tostring( "Bike Skills: "..math.ceil( bikestats / 10 ).. "%" )
	setStats( ptext, pstat, 0, 255, 0 )
end
addEventHandler( "setBikeSkillsData", localPlayer, setBikeSkillsData )

function render()
	local vehicle = getPedOccupiedVehicle( localPlayer )
	if ( exports.server:isPlayerLoggedIn( localPlayer ) == false ) or ( isPlayerMapVisible( localPlayer ) ) or ( not isPedInVehicle( localPlayer ) ) or ( not vehicle ) then return end
	
	local typ = getVehicleType( vehicle )
	if typ == "BMX" or typ == "Bike" then
		if ( getVehicleController( vehicle ) == localPlayer ) then
			dxDrawRectangle( ( 1158 / nX ) * sX, ( 562 / nY ) * sY, ( 189 / nX ) * sX, ( 29 / nY ) * sY, tocolor( 0, 0, 0, 125 ), false )
			dxDrawRectangle( ( 1158 / nX ) * sX, ( 567 / nY ) * sY, ( stat / nX ) * sX, ( 19 / nY ) * sY, tocolor( 34, 135, 38, 255 ), false )
			dxDrawText( text, ( 1158 / nX ) * sX, ( 562 / nY ) * sY, ( 1347 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.00, "default-bold", "center", "center" )
		end
	end
end
addEventHandler( "onClientRender", root, render )

--[[addEventHandler( "onClientVehicleExit", root,
    function ( plr, _ )
        if plr ~= localPlayer then return end
		removeEventHandler( "onClientRender", root, drawText )
    end
)

addEventHandler( "onClientVehicleEnter", root,
	function ( plr )
		if plr ~= localPlayer then return end
		local typ = getVehicleType( source )
		if typ == "BMX" or typ == "Bike" then
			if getVehicleController( source ) == localPlayer then
				addEventHandler( "onClientRender", root, drawText )
			end
		end
	end
)

-- These functions are here to stop any debug spam.
addEventHandler( "onClientResourceStart", resourceRoot,
	function ()
		local theVehicle = getPedOccupiedVehicle( localPlayer )
		if not theVehicle then return end
		local typ = getVehicleType( theVehicle )
		if typ == "BMX" or typ == "Bike" then
			if getVehicleController( theVehicle ) == localPlayer then
				addEventHandler( "onClientRender", root, drawText )
			end
		end
	end
)

addEventHandler( "onClientElementDestroy", root,
	function ()
		local theVehicle = getPedOccupiedVehicle( localPlayer )
		if source == theVehicle then
			local typ = getVehicleType( theVehicle )
			if typ == "BMX" or typ == "Bike" then
				removeEventHandler( "onClientRender", root, drawText )
			end
		end
	end
)

addEventHandler( "onClientPlayerWasted", root,
	function ()
		if ( source == localPlayer ) then
			removeEventHandler( "onClientRender", root, drawText )
		end
	end
)

addEventHandler( "onClientVehicleExplode", root,
	function ()
		local theVehicle = getPedOccupiedVehicle( localPlayer )
		if ( source == theVehicle ) then
			removeEventHandler( "onClientRender", root, drawText )
		end
	end
)]]