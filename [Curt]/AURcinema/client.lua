--[[
Server: AuroraRPG
Resource Name: Cinema
Version: 1.0
Developer/s: Curt
]]--
local texture = false
local ald = false
local BrowserIsCreated = false
--local blip = createBlip(1022, -1124, 23, 12)
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
	function()
		exports.customblips:createCustomBlip(1022, -1124, 113, 116, "blip.png", 300)
	end
)
local webWindow = createBrowser(1280, 720, false, false)
setElementData(getLocalPlayer(), "aurcinema.ColShape", false)

function loadContent ()
	local shader = dxCreateShader("texture.fx")
	engineApplyShaderToWorldTexture(shader, "bobobillboard1")
	engineApplyShaderToWorldTexture(shader, "cj_tv_screen")
	engineApplyShaderToWorldTexture(shader, "cj_tv_screen")
	engineApplyShaderToWorldTexture(shader, "cj_tv_screen")
	engineApplyShaderToWorldTexture(shader, "cj_tv_screen")	
	--setBlipVisibleDistance(blip, 300)
end 

function renderCinema()
	if (ald == true) then
		return
	end
	if (not texture) then
		texture = webWindow
	end
	local x, y = 3568.47339+5, -373.98416+0.1111111111
	dxDrawMaterialLine3D(x, y, 531.27435+4.1, x, y, 522.30707+0.3, texture, 18.2+14, tocolor(255, 255, 255, 255), x, y-25, 5)
end

function onPlrJoin(url)
	ald = false
	texture = false
	loadBrowserURL(webWindow, url)
	loadContent ()
end
addEvent( "aurcinema.onPlrJoin", true )
addEventHandler( "aurcinema.onPlrJoin", localPlayer, onPlrJoin )

addEventHandler("onClientBrowserCreated", webWindow,
	function()
		BrowserIsCreated = true
	end
)


function enableCinema (value)
	if (BrowserIsCreated == false) then 
		return false
	end 
	if (value == true) then 
		addEventHandler("onClientRender", root, renderCinema)
		return true
	else 
		removeEventHandler("onClientRender", root, renderCinema)
		return true
	end 
end
addEvent( "aurcinema.enableCinema", true )
addEventHandler( "aurcinema.enableCinema", localPlayer, enableCinema )

function setVolumeCinema (vol)
	if (vol) then
			setBrowserVolume(webWindow, vol)
	end
end
addEvent( "aurcinema.setVolumeCinema", true )
addEventHandler( "aurcinema.setVolumeCinema", localPlayer, setVolumeCinema )

function limitation(s)
	if (s == false) then
		loadBrowserURL(webWindow, "https://youtube.com/tv#/")
	else
		loadBrowserURL(webWindow, getElementData(getLocalPlayer(), "aurcinema.setvideocem"))
	end
end
addEvent( "aurcinema.loadCinema", true )
addEventHandler( "aurcinema.loadCinema", localPlayer, limitation )