local screenW, screenH = guiGetScreenSize()
local positions = 
{
    {0.34, 0.33, 0.06, 0.08, false},
    {0.34, 0.43, 0.06, 0.08, false},
    {0.47, 0.43, 0.06, 0.08, false},
    {0.47, 0.33, 0.06, 0.08, false},
    {0.61, 0.33, 0.06, 0.08, false},
    {0.61, 0.43, 0.06, 0.08, false},
}

specificPic = false

nextP = guiCreateButton(0.35, 0.58, 0.30, 0.05, "next page", true)
guiSetAlpha(nextP, 0.00)

prevP = guiCreateButton(0.35, 0.64, 0.30, 0.05, "prev pag", true)
guiSetAlpha(prevP, 0.00)

close = guiCreateButton(0.35, 0.71, 0.30, 0.05, "close", true)
guiSetAlpha(close, 0.00)

backButton = guiCreateButton(0.33, 0.75, 0.37, 0.05, "backPicture", true)
guiSetAlpha(backButton, 0.00)

buttons = {nextP, prevP, close, backButton}
images = {}
pageN = 1

function dxScreenSpecific()
    dxDrawImage(screenW * 0.3273, screenH * 0.2458, screenW * 0.3648, screenH * 0.4847, specificPic, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Viewing: "..specificPic, screenW * 0.3289, screenH * 0.1944, screenW * 0.6922, screenH * 0.2375, tocolor(255, 255, 255, 255), 1.50, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3266, screenH * 0.7486, screenW * 0.3656, screenH * 0.0500, tocolor(3, 0, 0, 119), false)
    dxDrawText("Back", screenW * 0.3242, screenH * 0.7500, screenW * 0.6922, screenH * 0.7986, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

for i, v in ipairs(buttons) do
    guiSetVisible(v, false)
end

function dxScreenshotGUI()
    dxDrawRectangle(screenW * 0.3133, screenH * 0.2278, 479, 393, tocolor(0, 0, 0, 140), false)
    dxDrawText("AuroraRPG - Screenshots", screenW * 0.3133, screenH * 0.2236, (screenW * 0.3133) + 479, ( screenH * 0.2236) + 48, tocolor(255, 255, 255, 255), 1.40, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3531, screenH * 0.7083, 377, 37, tocolor(55, 55, 55, 124), false)
    dxDrawRectangle(screenW * 0.3531, screenH * 0.6431, 377, 37, tocolor(55, 55, 55, 124), false)
    dxDrawText("Close", screenW * 0.3133, screenH * 0.7069, (screenW * 0.3133) + 479, ( screenH * 0.7069) + 38, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Previous  Page", screenW * 0.3133, screenH * 0.6403, (screenW * 0.3133) + 479, ( screenH * 0.6403) + 38, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3531, screenH * 0.5778, 377, 37, tocolor(55, 55, 55, 124), false)
    dxDrawText("Next Page", screenW * 0.3133, screenH * 0.5778, (screenW * 0.3133) + 479, ( screenH * 0.5778) + 38, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Page number: "..pageN, screenW * 0.3133, screenH * 0.5306, (screenW * 0.3133) + 479, ( screenH * 0.5306) + 24, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
end

function getFileCreateName()
    local maxImages = 1000
    for i=1, maxImages do
        if (not fileExists(tostring(i)..".jpg")) then
            return tostring(i)..".jpg"
        end
    end
end

function getFiles()
    local maxImages = 1000
    local fileNames = {}
    for i=1, maxImages do
        if (fileExists(tostring(i)..".jpg")) then
            table.insert(fileNames, tostring(i)..".jpg")
        end
    end
    return fileNames
end

imer = {}
function imagesLoad(c)
    local files = getFiles()
    local filesDone = 0
    for i, v in ipairs(positions) do
        positions[i][5] = false
    end
    for i, v in ipairs(images) do
        destroyElement(v)
    end
    images = {}
    imer = {}
    if (c) then
        filesDone = 6*(c-1)
    end
    for i, v in ipairs(positions) do
        if (not v[5]) then
            if (#files ~= filesDone) then
                filesDone = filesDone + 1
                local x, y, width, height = unpack(v) 
                images[#images+1] = guiCreateStaticImage(x, y, width, height, files[filesDone], true, nil)
                addEventHandler("onClientGUIClick", images[#images], buttonHandler, false)
                imer[images[#images]] = files[filesDone]
                positions[i][5] = true
            end
        end
    end
end

function toggleScreenshotGUI()
    local vis = not guiGetVisible(nextP)
    if (vis) then
        addEventHandler("onClientRender", root, dxScreenshotGUI)
        guiSetInputMode("no_binds_when_editing")
        imagesLoad()
    else
        if (specificPic) then
            removeEventHandler("onClientRender", root, dxScreenSpecific)
            specificPic = false
        end
        removeEventHandler("onClientRender", root, dxScreenshotGUI)
        guiSetInputMode("allow_binds")
        for i, v in ipairs(positions) do
            positions[i][5] = false
        end
        for i, v in ipairs(images) do
            destroyElement(v)
        end
        images = {}
        pageN = 1
    end
    showCursor(vis)
    for i, v in ipairs(buttons) do
        guiSetVisible(v, vis)
    end
end
addEvent("AURscreenshot.t", true)
addEventHandler("AURscreenshot.t", root, toggleScreenshotGUI)

function buttonHandler(button)
    if (button ~= "left") then
        return false 
    end
    if (specificPic) then
        if (source == backButton) then
            removeEventHandler("onClientRender", root, dxScreenSpecific)
            specificPic = false
            addEventHandler("onClientRender", root, dxScreenshotGUI)
            guiSetInputMode("no_binds_when_editing")
            imagesLoad(pageN)
        end
    else
        if (source == close) then
            toggleScreenshotGUI()
        end
        if (source == nextP) then
            local files = getFiles()
            local filesPage = math.ceil(#files/6)
            if (pageN == filesPage) then
                return false 
            end
            pageN = pageN + 1
            imagesLoad(pageN)
        end
        if (source == prevP) then
            if (pageN == 1) then
                return false 
            end
            pageN = pageN - 1
            imagesLoad(pageN)
        end
        if (imer[source]) then
            specificPic = imer[source]
            addEventHandler("onClientRender", root, dxScreenSpecific)
            removeEventHandler("onClientRender", root, dxScreenshotGUI)
            for i, v in ipairs(positions) do
                positions[i][5] = false
            end
            for i, v in ipairs(images) do
                destroyElement(v)
            end
            images = {}
            imer = {}           
        end
    end
end
addEventHandler("onClientGUIClick", close, buttonHandler, false)
addEventHandler("onClientGUIClick", nextP, buttonHandler, false)
addEventHandler("onClientGUIClick", prevP, buttonHandler, false)
addEventHandler("onClientGUIClick", backButton, buttonHandler, false)

function takePlayerScreen()
    triggerServerEvent("AURscreenshot.takess", localPlayer, screenW, screenH)
end
addCommandHandler("savess", takePlayerScreen)

function screenshotSave(data)
    local fileName = getFileCreateName()
    local file = fileCreate(fileName)
    if (file) then
        fileWrite(file, data)
        fileClose(file)
        outputChatBox("File saved! View in /screenshots", 0, 255, 0)
    else 
        outputChatBox("Image was unable to be saved", 255, 0, 0)
        return false
    end
end
addEvent("AURscreenshot.ssData", true)
addEventHandler("AURscreenshot.ssData", root, screenshotSave)