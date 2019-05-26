local theShader = {}

function activateShader(data, id, sPlayer)
	shader = dxCreateShader("shader.fx", 0, 0, true, "vehicle")  
	local theTexture = dxCreateTexture(data)
	if (shader and theTexture) then
		dxSetShaderValue (shader, "Tex0", theTexture)
		engineApplyShaderToWorldTexture (shader, id, sPlayer)
	end
end
addEvent("AURdebrand_vehicles.activateShader", true)
addEventHandler( "AURdebrand_vehicles.activateShader", resourceRoot, activateShader)

function removeShader(vehice)
	engineRemoveShaderFromWorldTexture ( shader, "map" )
end
addEvent("AURdebrand_vehicles.removeShader", true)
addEventHandler( "AURdebrand_vehicles.removeShader", resourceRoot, removeShader)

function forceRestore (skinid)
	engineRestoreModel(skinid)
end 
addEvent("AURdebrand_vehicles.forceRestore", true)
addEventHandler( "AURdebrand_vehicles.forceRestore", resourceRoot, forceRestore)