-- main variables
local root = getRootElement()
local resourceRoot = getResourceRootElement(getThisResource())
local screenWidth, screenHeight = guiGetScreenSize()

-- settings
local blurStrength = 10

-- functional variables
local myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)

addEventHandler("onClientResourceStart", resourceRoot,
function()
    if getVersion ().sortable < "1.3.1" then

        return
	else

		blurShader, blurTec = dxCreateShader("shaders/BlurShader.fx")

        if (not blurShader) then
		else
        end
    end
end)

addEventHandler("onClientPreRender", root,
function()
if getElementData ( localPlayer,"shader") then
    if (blurShader) then
        dxUpdateScreenSource(myScreenSource)
        
        dxSetShaderValue(blurShader, "ScreenSource", myScreenSource);
        dxSetShaderValue(blurShader, "BlurStrength", blurStrength);
		dxSetShaderValue(blurShader, "UVSize", screenWidth, screenHeight);

        dxDrawImage(0, 0, screenWidth, screenHeight, blurShader)
    end
end
end)

addEventHandler("onClientResourceStop", resourceRoot,
function()
	if (blurShader) then
		destroyElement(blurShader)
		blurShader = nil
	end
end)
