maximumStreamDist = 125 --( Original was 150)

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

function applyCustomTexture( object, texture)
	if not odata.shader[object] then
		odata.shader[object] = dxCreateShader( "assets/shader.fx", 0, 0, false, "object")
		odata.texture[object] = dxCreateTexture( "assets/textures/"..texture..".png", "dxt5", false, "clamp", "3d")

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

function checkStream( object)
	local streamState = getObjectData( object, "streaming")
	local pX, pY, pZ = getElementPosition( localPlayer)
	local x, y, z = getElementPosition( object)
	local distance = getDistanceBetweenPoints2D( pX, pY, x, y)
	if distance >= maximumStreamDist then
		if streamState then
			setObjectData( object, "streaming", false)
			--removeCustomTexture( object)
			setElementStreamable( object, false)
		end
	elseif distance <= maximumStreamDist then
		local objectZone = getObjectData( object, "zonename")
		if not streamState then
			setObjectData( object, "streaming", true)
			local cacheTable = getZoneCache( objectZone)
			for i, tobject in pairs (cacheTable) do
				local texture = getObjectData( tobject, "shaderTexture")
				if tobject == object then
					--applyCustomTexture( tobject, texture)
					setElementStreamable( object, true)
				end
			end
		end
	end
end
