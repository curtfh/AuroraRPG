addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		for i, data in pairs ( customMaps) do
			local mapTable = data[1]
			local int = data[2]
			local dim = data[3]

			setupCustomMap( mapTable, int, dim)
		end
	end
)

cache = {}
odata = {
	lod = {},
	object = {},
	texture = {},
	shader = {},
	data = {},
}

function setObjectData( object, key, data)
	if not odata.data[object] then
		odata.data[object] = {}
	end
	odata.data[object][key] = data
end

function getObjectData( object, key)
	if odata.data[object] then
		local data = odata.data[object][key]
		if data then
			return data
		else
			return false
		end
	else
		return false
	end
end

function setupCustomMap( theTable, theInt, theDim)
	for name, category in pairs ( mapObjects) do
		if name == theTable then
			for i, object in pairs ( category) do
				local posData = split(object[1], ",")
				local rotData = split(object[2], ",")
				local x, y, z = posData[1], posData[2], posData[3]
				local rX, rY, rZ = rotData[1], rotData[2], rotData[3]
				local materialID = tonumber( object[3])
				local textureName = tostring( object[4])

				--odata.lod[i] = createObject( materialID, x, y, z, rX, rY, rZ, true)
				if oldIDreplacer[materialID] then
					materialID = oldIDreplacer[materialID]
				else
					materialID = materialID
				end
				odata.object[i] = createObject( materialID, x, y, z, rX, rY, rZ)

				setElementFrozen( odata.object[i], true)
				setElementDoubleSided( odata.object[i], true)
				setObjectBreakable( odata.object[i], false)
				setElementInterior( odata.object[i], theInt)
				setElementDimension( odata.object[i], theDim)

				if not cache[theTable] then
					cache[theTable] = {}
				end
				table.insert( cache[theTable], odata.object[i])

				setObjectData( odata.object[i], "shaderTexture", textureName)
				setObjectData( odata.object[i], "streaming", true)
				setObjectData( odata.object[i], "zonename", zonename)

				applyCustomTexture( odata.object[i], textureName)
				--setTimer( checkStream, 1000, 0, odata.object[i])
			end
		end
	end
end

function applyCustomTexture( object, texture)
	if not odata.shader[object] then
		odata.shader[object] = dxCreateShader( "shader.fx", 0, 0, false, "object")
		odata.texture[object] = dxCreateTexture( "textures/"..texture..".png", "dxt5", false, "clamp", "3d")

		dxSetShaderValue( odata.shader[object], "Tex0", odata.texture[object])
		engineApplyShaderToWorldTexture( odata.shader[object], "whttile", object)
		setObjectData( object, "shaderTexture", texture)
	else
		removeCustomTexture( object)
		applyCustomTexture( object, texture)
		setObjectData( object, "shaderTexture", texture)
	end
end

function removeCustomTexture( object)
	if odata.shader[object] then
		engineRemoveShaderFromWorldTexture( odata.shader[object], "whttile")
		--setObjectData( object, "shaderTexture", odata.texture[object])
		if isElement( odata.shader[object]) then
			destroyElement( odata.shader[object])
			odata.shader[object] = false
		end
		if isElement( odata.texture[object]) then
			destroyElement( odata.texture[object])
			odata.texture[object] = false
		end
	end
end
