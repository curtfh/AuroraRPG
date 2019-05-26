--
-- c_snow_ground.lua
--


local helpMessage = "Type /groundsnow to turn off/on snow ground mode"
local helpMessageTime = 4000
local helpMessageY = 0.2

local bEffectEnabled
local noiseTexture
local snowShader
local treeShader

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
--------------------------------
-- Command handler
--		Toggle via command
--------------------------------
function toggleGoundSnow()
	triggerEvent( "switchGoundSnow", resourceRoot, not bEffectEnabled )
end
addCommandHandler('groundsnow',toggleGoundSnow)



--------------------------------
-- Switch effect on or off
--------------------------------
function switchGoundSnow( bOn )
	if bOn then
		enableGoundSnow()
	else
		disableGoundSnow()
	end
end
addEvent( "switchGoundSnow", true )
addEventHandler( "switchGoundSnow", resourceRoot, switchGoundSnow )

local theValsz
setTimer(function()
	local value = exports.DENsettings:getPlayerSetting("snowground")
	if (theValsz == value) then return false end
	if (value == true) then 
		enableGoundSnow()
		theValsz = value
	else
		disableGoundSnow()
		theValsz = value
	end 
end, 1000, 0)


----------------------------------------------------------------
----------------------------------------------------------------
-- Effect clever stuff
----------------------------------------------------------------
----------------------------------------------------------------
local maxEffectDistance = 250		-- To speed up the shader, don't use it for objects further away than this

-- List of world texture name matches
-- (The ones later in the list will take priority)
local snowApplyList = {
						"*",				-- Everything!
				}

-- List of world textures to exclude from this effect
local snowRemoveList = {
						"",												-- unnamed

						"vehicle*", "?emap*", "?hite*",					-- vehicles
						"*92*", "*wheel*", "*interior*",				-- vehicles
						"*handle*", "*body*", "*decal*",				-- vehicles
						"*8bit*", "*logos*", "*badge*",					-- vehicles
						"*plate*", "*sign*",							-- vehicles
						"headlight",									-- vehicles

						"shad*",										-- shadows
						"coronastar",									-- coronas
						"tx*",											-- grass effect
						"lod*",											-- lod models
						"cj_w_grad",									-- checkpoint texture
						"*cloud*",										-- clouds
						"*smoke*",										-- smoke
						"sphere_cj",									-- nitro heat haze mask
						"particle*",									-- particle skid and maybe others
						"water*", "sw_sand", "coral",					-- sea
					}

local treeApplyList = {
						"sm_des_bush*", "*tree*", "*ivy*", "*pine*",	-- trees and shrubs
						"veg_*", "*largefur*", "hazelbr*", "weeelm",
						"*branch*", "cypress*", "plant*", "sm_josh_leaf",
						"trunk3", "*bark*", "gen_log", "trunk5",
						"bchamae",
	}

--------------------------------
-- Switch effect on
--------------------------------
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
	end
)

function enableGoundSnow()
	if bEffectEnabled then return end
	-- Version check
	if getVersion ().sortable < "1.1.1-9.03285" then
		outputChatBox( "Resource is not compatible with this client." )
		return
	end

	snowShader = dxCreateShader ( "snow_ground.fx", 0, maxEffectDistance )
	treeShader = dxCreateShader( "snow_trees.fx" )
	sNoiseTexture = dxCreateTexture( "smallnoise3d.dds" )

	if not snowShader or not treeShader or not sNoiseTexture then
		--outputChatBox( "Could not create shader. Please use debugscript 3" )
		return nil
	end

	-- Setup shaders
	dxSetShaderValue( treeShader, "sNoiseTexture", sNoiseTexture )
	dxSetShaderValue( snowShader, "sNoiseTexture", sNoiseTexture )
	dxSetShaderValue( snowShader, "sFadeEnd", maxEffectDistance )
	dxSetShaderValue( snowShader, "sFadeStart", maxEffectDistance/2 )

	-- Process snow apply list
	for _,applyMatch in ipairs(snowApplyList) do
		engineApplyShaderToWorldTexture ( snowShader, applyMatch )
	end

	-- Process snow remove list
	for _,removeMatch in ipairs(snowRemoveList) do
		engineRemoveShaderFromWorldTexture ( snowShader, removeMatch )
	end

	-- Process tree apply list
	for _,applyMatch in ipairs(treeApplyList) do
		engineApplyShaderToWorldTexture ( treeShader, applyMatch )
	end

	-- Init vehicle checker
	doneVehTexRemove = {}
	vehTimer = setTimer( checkCurrentVehicle, 100, 0 )
	removeVehTextures()

	-- Flag effect as running
	bEffectEnabled = true

	showHelp()
end

--------------------------------
-- Switch effect off
--------------------------------
function disableGoundSnow()
	if not bEffectEnabled then return end

	-- Destroy all elements
	destroyElement( sNoiseTexture  )
	destroyElement( treeShader )
	destroyElement( snowShader )

	killTimer( vehTimer )

	-- Flag effect as stopped
	bEffectEnabled = false
end


----------------------------------------------------------------
-- removeVehTextures
--		Keep effect off vehicles
----------------------------------------------------------------
local nextCheckTime = 0
local bHasFastRemove = getVersion().sortable > "1.1.1-9.03285"

addEventHandler( "onClientPlayerVehicleEnter", root,
	function()
		removeVehTexturesSoon ()
	end
)

-- Called every 100ms
function checkCurrentVehicle ()
	local veh = getPedOccupiedVehicle(localPlayer)
	local id = veh and getElementModel(veh)
	if lastveh ~= veh or lastid ~= id then
		lastveh = veh
		lastid = id
		removeVehTexturesSoon()
	end
	if nextCheckTime < getTickCount() then
		nextCheckTime = getTickCount() + 5000
		removeVehTextures()
	end
end

-- Called the players current vehicle need processing
function removeVehTexturesSoon ()
    nextCheckTime = getTickCount() + 200
end

-- Remove textures from players vehicle from effect
function removeVehTextures ()
	if not bHasFastRemove then return end

	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		local id = getElementModel(veh)
		local vis = engineGetVisibleTextureNames("*",id)
		-- For each texture
		if vis then
			for _,removeMatch in pairs(vis) do
				-- Remove for each shader
				if not doneVehTexRemove[removeMatch] then
					doneVehTexRemove[removeMatch] = true
					--for _,info in ipairs(ShaderInfoList.items) do
						--engineRemoveShaderFromWorldTexture ( info.shader, removeMatch )
						engineRemoveShaderFromWorldTexture ( snowShader, removeMatch )
					--end
				end
			end
		end
	end
end


----------------------------------------------------------------
-- Help message
----------------------------------------------------------------
function showHelp()
	bShowHelp = true
	setTimer( function() bShowHelp=false end, helpMessageTime, 1 )
end

addEventHandler( "onClientRender", root,
	function ()
		if bShowHelp then
			local sx, sy = guiGetScreenSize()
			dxDrawText(helpMessage, sx/2-10, sy*helpMessageY, sx/2+10, 0, tocolor(255, 0, 0, 255), 3, 'default', 'center' )
		end
	end
)


----------------------------------------------------------------
-- Math helper functions
----------------------------------------------------------------
function math.lerp(from,alpha,to)
    return from + (to-from) * alpha
end

function math.unlerp(from,pos,to)
	if ( to == from ) then
		return 1
	end
	return ( pos - from ) / ( to - from )
end


function math.clamp(low,value,high)
    return math.max(low,math.min(value,high))
end

function math.unlerpclamped(from,pos,to)
	return math.clamp(0,math.unlerp(from,pos,to),1)
end


----------------------------------------------------------------
-- Unhealthy hacks
----------------------------------------------------------------
_dxCreateShader = dxCreateShader
function dxCreateShader( filepath, priority, maxDistance, bDebug )
	priority = priority or 0
	maxDistance = maxDistance or 0
	bDebug = bDebug or false

	-- Slight hack - maxEffectDistance doesn't work properly before build 3236 if fullscreen
	local build = getVersion ().sortable:sub(9)
	local fullscreen = not dxGetStatus ().SettingWindowed
	if build < "03236" and fullscreen then
		maxDistance = 0
	end

	return _dxCreateShader ( filepath, priority, maxDistance, bDebug )
end

