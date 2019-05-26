local blipTextureNames = {
    "arrow",
    "radarRingPlane",
    "radar_airYard",
    "radar_ammugun",
    "radar_barbers",
    "radar_BIGSMOKE",
    "radar_boatyard",
    "radar_bulldozer",
    "radar_burgerShot",
    "radar_cash",
    "radar_CATALINAPINK",
    "radar_centre",
    "radar_CESARVIAPANDO",
    "radar_chicken",
    "radar_CJ",
    "radar_CRASH1",
    "radar_dateDisco",
    "radar_dateDrink",
    "radar_dateFood",
    "radar_diner",
    "radar_emmetGun",
    "radar_enemyAttack",
    "radar_fire",
    "radar_Flag",
    "radar_gangB",
    "radar_gangG",
    "radar_gangN",
    "radar_gangP",
    "radar_gangY",
    "radar_girlfriend",
    "radar_gym",
    "radar_hostpital",
    "radar_impound",
    "radar_light",
    "radar_LocoSyndicate",
    "radar_MADDOG",
    "radar_mafiaCasino",
    "radar_MCSTRAP",
    "radar_modGarage",
    "radar_north",
    "radar_OGLOC",
    "radar_pizza",
    "radar_police",
    "radar_propertyG",
    "radar_propertyR",
    "radar_qmark",
    "radar_race",
    "radar_runway",
    "radar_RYDER",
    "radar_saveGame",
    "radar_school",
    "radar_spray",
    "radar_SWEET",
    "radar_tattoo",
    "radar_THETRUTH",
    "radar_TORENO",
    "radar_TorenoRanch",
    "radar_triads",
    "radar_triadsCasino",
    "radar_truck",
    "radar_tshirt",
    "radar_waypoint",
    "radar_WOOZIE",
    "radar_ZERO",
}
local sha = {}
local tex = {}
hudEnabled = false
local enabled = true


-- No touch, kthxbai
local tiles = { }
local timer


local hudswitch = function (hudstate)
	if hudstate then
		hudEnabled = true
		enabled = true
				-- Load all tiles
		handleTileLoading ( )

		--removeEventHandler("onClientHudRender",root,handleTileLoading)
		removeEventHandler("onClientPreRender",root,handleTileLoading)
		addEventHandler("onClientPreRender",root,handleTileLoading)
		replaceTexture("radardisc", "blips/")
	else
		hudEnabled = false
		enabled = false
		for name, data in pairs ( tiles ) do
			unloadTile ( name )
		end
		--[[for name, data in pairs ( tiles ) do
			if not table.find ( visibleTileNames, name ) then
				unloadTile ( name )
			end
		end]]
		if sha["radardisc"] and isElement(sha["radardisc"]) then
			engineRemoveShaderFromWorldTexture ( sha["radardisc"], "radardisc" )
			destroyElement(sha["radardisc"])
			sha["radardisc"] = nil
			tex["radardisc"] = nil
		end
		--removeEventHandler("onClientHudRender",root,handleTileLoading)
		removeEventHandler("onClientPreRender",root,handleTileLoading)
	end
end

addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, hudstate )
		if setting == "map" then
			hudswitch( hudstate )
		end
	end
)

function checkSettinghud()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "map" )
		hudswitch( setting )
	else
		setTimer( checkSettinghud, 5000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSettinghud )


function replaceTexture(textureName, imgPath)
	if sha[textureName] then return false end
	if tex[textureName] then return false end
	sha[textureName] = dxCreateShader("shader.fx", 0, 0, false, "world")
    tex[textureName] = dxCreateTexture(imgPath .. textureName .. ".png")
    dxSetShaderValue(sha[textureName], "gTexture", tex[textureName])
    engineApplyShaderToWorldTexture(sha[textureName], textureName)
end

function replaceRadarTextures()
    for i, textureName in ipairs(blipTextureNames) do
    	replaceTexture(textureName, "blips/")
    end
end

addEventHandler("onClientResourceStart", resourceRoot, replaceRadarTextures)




local ROW_COUNT = 12

function toggleCustomTiles ( )
	-- Toggle!
	enabled = not enabled

	-- Check whether we enabled it
	if enabled then
		-- Load all tiles
		handleTileLoading( )

		-- Set a timer to check whether new tiles should be loaded (less resource hungry than doing it on render)
		--timer = setTimer ( handleTileLoading, 100, 0 )
	else
		-- If our timer is still running, kill it with fire
		---if isTimer ( timer ) then killTimer ( timer ) end

		-- Unload all tiles, so the memory footprint has disappeared magically
		for name, data in pairs ( tiles ) do
			unloadTile ( name )
		end
	end
end
--addCommandHandler( "radarhighres", toggleCustomTiles )

function handleTileLoading ( )
	-- Get all visible radar textures
		local visibleTileNames = table.merge ( engineGetVisibleTextureNames ( "radar??" ), engineGetVisibleTextureNames ( "radar???" ) )

		-- Unload tiles we don't see
		for name, data in pairs ( tiles ) do
			if not table.find ( visibleTileNames, name ) then
				unloadTile ( name )
			end
		end

		-- Load tiles we do see
		for index, name in ipairs ( visibleTileNames ) do
			loadTile ( name )
		end

end

function table.merge ( ... )
	local ret = { }

	for index, tbl in ipairs ( {...} ) do
		for index, val in ipairs ( tbl ) do
			table.insert ( ret, val )
		end
	end

	return ret
end

function table.find ( tbl, val )
	for index, value in ipairs ( tbl ) do
		if value == val then
			return index
		end
	end

	return false
end

-------------------------------------------
--
-- Tile loading and unloading functions
--
-------------------------------------------

function loadTile ( name )
	-- Make sure we have a string
	if type ( name ) ~= "string" then
		return false
	end

	-- Check whether we already loaded this tile
	if tiles[name] then
		return true
	end

	-- Extract the ID
	local id = tonumber ( name:match ( "%d+" ) )

	-- If not a valid ID, abort
	if not id then
		return false
	end

	-- Calculate row and column
	local row = math.floor ( id / ROW_COUNT )
	local col = id - ( row * ROW_COUNT )

	-- Now just calculate start and end positions
	local posX = -3000 + 500 * col
	local posY =  3000 - 500 * row

	-- Fetch the filename
	local file = string.format ( "sattelite/sattelite_%d_%d.png", row, col )

	-- Now, load that damn file! (Also create a transparent overlay texture)
	local texture = dxCreateTexture ( file )

	-- If it failed to load, abort
	if not texture --[[or not overlay]] then
		---outputChatBox ( string.format ( "Failed to load texture for %q (%q)", tostring ( name ), tostring ( file ) ) )
		return false
	end

	-- Now we just need the shader
	local shader = dxCreateShader ( "texreplace.fx" )

	-- Abort if failed (don't forget to destroy the texture though!!!)
	if not shader then
		---outputChatBox ( "Failed to load shader" )
		destroyElement ( texture )
		return false
	end

	-- Now hand the texture to the shader
	dxSetShaderValue ( shader, "gTexture", texture )

	-- Now apply this stuff on the tile
	engineApplyShaderToWorldTexture ( shader, name )

	-- Store the stuff
	tiles[name] = { shader = shader, texture = texture }

	-- Return success
	return true
end

function unloadTile ( name )
	-- Get the tile data
	local tile = tiles[name]

	-- If no data is present, we failed
	if not tile then
		return false
	end

	-- Destroy the shader and texture elements, if they exist
	if isElement ( tile.shader )  then destroyElement ( tile.shader )  end
	if isElement ( tile.texture ) then destroyElement ( tile.texture ) end

	-- Now remove all reference to it
	tiles[name] = nil

	-- We succeeded
	return true
end

-- Set a timer to check whether new tiles should be loaded (less resource hungry than doing it on render)
---timer = setTimer ( handleTileLoading, 100, 0 )
