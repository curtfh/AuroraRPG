crash = {{{{{{{{ {}, {}, {} }}}}}}}}
local defaultDist = 100
local streamingFrom = false
local radius = 100
local x, y, z = 0, 0, 0
local usingEle = false
local timer = false
local predefined = {
	["Power181"] = "http://www.181.fm/winamp.pls?station=181-power&style=mp3&description=Power%20181%20(Top%2040)&file=181-power.pls"
	
}



streamWindow1 = guiCreateWindow(368, 101, 582, 300, "AuroraRPG - VIP Stream", false)
guiWindowSetSizable(streamWindow1, false)
streamButton1 = guiCreateButton(204, 92, 369, 34, "Start Stream", false, streamWindow1)
streamButton2 = guiCreateButton(204, 140, 369, 34, "Stop Stream", false, streamWindow1)
streamButton4 = guiCreateButton(204, 191, 369, 34, "Clear", false, streamWindow1)
streamButton5 = guiCreateButton(9, 245, 564, 40, "Close", false, streamWindow1)
streamGrid1 = guiCreateGridList(13, 27, 181, 208, false, streamWindow1)
guiGridListSetSelectionMode(streamGrid1,1)
streamCol = guiGridListAddColumn(streamGrid1, "URLs", 0.9)
streamEdit1 = guiCreateEdit(272, 31, 301, 31, "", false, streamWindow1)
streamLabel1 = guiCreateLabel(199, 34, 70, 26, "URL:", false, streamWindow1)
guiLabelSetHorizontalAlign(streamLabel1, "center", false)
guiLabelSetVerticalAlign(streamLabel1, "center")
guiSetVisible(streamWindow1, false)

for a,b in pairs(predefined) do
	local row = guiGridListAddRow(streamGrid1)
	guiGridListSetItemText(streamGrid1, row, streamCol, a, false, false)
end

function openWindow()
	if (getElementData(localPlayer, "VIP") ~= "Yes") then return false end
	if (guiGetVisible(streamWindow1)) then
		guiSetVisible(streamWindow1, false)
		showCursor(false)
		guiSetInputMode("allow_binds")
	else
		guiSetVisible(streamWindow1, true)
		showCursor(true)
		guiSetInputMode("no_binds_when_editing")
	end
end
addEvent("AURvipstream.stream", true)
addEventHandler("AURvipstream.stream", localPlayer, openWindow)

function clearFunc()
	guiSetText(streamEdit1, "")
end
--addEventHandler("onClientGUIClick", streamButton4, clearFunc, false)
--addEventHandler("onClientGUIClick", streamButton5, openWindow, false)


function startStream()
	local url = tostring(guiGetText(streamEdit1)) or ""
	local gridUrl = guiGridListGetItemText(streamGrid1, guiGridListGetSelectedItem(streamGrid1), 1)
	local low = string.lower(url)
	if (url ~= "" and not string.find(low, ".mp3") and not string.find(low, ".pls") and not string.find(low, ".asx") and not string.find(low, ".m3u") and not string.find(low, ".wav") and not string.find(low, ".ogg") and not string.find(low, ".riff") and not string.find(low, ".mod") and not string.find(low, ".xm") and not string.find(low, ".it") and not string.find(low, ".s3m")) then
		outputChatBox("The only supported streams are: mp3 - pls - m3u - wav - ogg - riff - mod - xm - it - s3m")
		return false
	end
	if (url ~= "") then
		triggerServerEvent("AURvipstream.streamStart", localPlayer, url)
	elseif (gridUrl ~= "") then
		triggerServerEvent("AURvipstream.streamStart", localPlayer, predefined[gridUrl])
	else
		return false
	end
end
addEventHandler("onClientGUIClick", streamButton1, startStream, false)

function stopStream()
	triggerServerEvent("AURvipstream.streamStop", localPlayer)
end
addEventHandler("onClientGUIClick", streamButton2, stopStream, false)

function startStreameam(streamm, radius, x, y, z, int, dim, veh2)
	setCameraClip (false, false)
	if (stream) then return end
	stream = playSound3D(streamm, x, y, z, true)
	setElementInterior(stream, int)
	setElementDimension(stream, dim)
	setSoundVolume(stream, 1.0)
	setSoundMaxDistance(stream, radius)
	if (veh2) then
		veh = veh2
		timer = setTimer(updatePos, 100, 0)
	end
end
addEvent("AURvipstream.startClientStream", true)
addEventHandler("AURvipstream.startClientStream", localPlayer, startStreameam)


function stopStreameam()
	if (stream) then
		if (isElement(stream)) then
			destroyElement(stream)
		end
		stream = nil
		if (isElement(timer)) then
			killTimer(timer)
		end
		veh = nil
		x,y,z = 0, 0, 0
	end
end
addEvent("AURvipstream.streamClientStop", true)
addEventHandler("AURvipstream.streamClientStop", localPlayer, stopStreameam)

function moveStream(x2, y2, z2)
	if (stream and isElement(stream)) then
		setElementPosition(stream, x2, y2, z2)
		x = x2
		y = y2
		z = z2
	end
end
addEvent("AURvipstream.updateClientStream", true)
addEventHandler("AURvipstream.updateClientStream", localPlayer, moveStream)

function updatePos()
	if (not stream) then killTimer(timer) return end
	if (not isElement(veh)) then killTimer(timer) return end
	if (not isElement(veh)) then return false end
	if (not isElement(stream)) then return false end
	x2,y2,z2 = getElementPosition(veh)
	int = getElementInterior(veh)
	dim = getElementDimension(veh)
	setElementPosition(stream, x2, y2, z2)
	setElementInterior(stream, int)
	setElementDimension(stream, dim)
	x = x2
	y = y2
	z = z2
end