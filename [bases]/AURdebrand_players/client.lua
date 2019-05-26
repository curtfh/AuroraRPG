local theShader = {}

function activateShader(data, id, sPlayer)
	if fileExists(":AURdebrand_players/"..data) then
		for i=1, #theShader do
			if (theShader[i][1] == sPlayer and theShader[i][2] == id) then
				return false
			end
		end
		local shader = dxCreateShader("shader.fx", 0, 0, true, "ped")
		local theTexture = dxCreateTexture(data)
		if (shader and theTexture) then
			engineApplyShaderToWorldTexture (shader, id, sPlayer)
			dxSetShaderValue (shader, "Tex0", theTexture)
			theShader[#theShader+1] = {sPlayer, id, shader}
		end
	end
end
addEvent("AURdebranded_players.activateShader", true)
addEventHandler( "AURdebranded_players.activateShader", resourceRoot, activateShader)

function forceRestore (skinid)
	engineRestoreModel(skinid)
end
addEvent("AURdebranded_players.forceRestore", true)
addEventHandler( "AURdebranded_players.forceRestore", resourceRoot, forceRestore)

download = 0
theTable = {}
addEvent("downloadDebrandImage", true)
addEventHandler( "downloadDebrandImage",root, function(tbl)
	theTable = tbl
	download = 0
	for k,v in ipairs(tbl) do
		if not (downloadFile ( "data/"..v )) then
			print("Couldn't find data/"..v)
		end
	end
end)

addEvent("checkDebradTotal", true)
addEventHandler( "checkDebradTotal",root, function()
	if #theTable > 0 then
		if download >= #theTable then
			triggerServerEvent("onClientAddDebranded",localPlayer)
		end
	end
end)



function onDownloadFinish ( file, success )
    if ( source == resourceRoot ) then                            -- if the file relates to this resource
        if ( success ) then
			download=download+1
			exports.NGCnote:addNote("Deb","Loading "..download.."/"..#theTable.." skins model",255,160,0,3000)
			if download >= #theTable then
				triggerServerEvent("onClientAddDebranded",localPlayer)
			end
        end
    end
end
addEventHandler ( "onClientFileDownloadComplete", getRootElement(), onDownloadFinish )

addEventHandler ( "onClientResourceStart",resourceRoot,function()
	triggerServerEvent("onClientCallDebranded",localPlayer)
end)


addCommandHandler("skintex",function(cmd,id)
	if id then
		for _,name in ipairs( engineGetModelTextureNames( id ) ) do if name then outputChatBox(name) end end
	end
end)
