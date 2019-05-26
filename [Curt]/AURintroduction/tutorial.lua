local GUIEditor = {
    progressbar = {},
    label = {},
    button = {},
    window = {},
    gridlist = {}
}

local authorname = ""
local introname = ""

function openGUI ()
	local done = 0
	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 913) / 2, (screenH - 414) / 2, 913, 414, "AuroraRPG - Tutorials", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(11, 31, 160, 15, "Total Tutorials: "..#intros, false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	GUIEditor.button[1] = guiCreateButton(234, 381, 176, 23, "View", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(493, 382, 176, 22, "Close", false, GUIEditor.window[1])
	GUIEditor.progressbar[1] = guiCreateProgressBar(10, 62, 893, 26, false, GUIEditor.window[1])
	GUIEditor.gridlist[1] = guiCreateGridList(9, 96, 894, 281, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Name", 0.2)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Location", 0.2)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Est. Time", 0.2)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Seen?", 0.2)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Date Added", 0.2)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Author", 0.2)
	addEventHandler("onClientGUIClick", GUIEditor.button[2], openClose, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[1], viewOpen, false)
	for i=1, #intros do
		local location = getZoneName ( intros[i][2], intros[i][3], intros[i][4] )
		local city = getZoneName ( intros[i][2], intros[i][3], intros[i][4], true )
		if (exports.DENsettings:getPlayerSetting("AURIntroduction_"..intros[i][1]) ~= true) then
			guiGridListAddRow(GUIEditor.gridlist[1], intros[i][1], location.."("..city..")", math.floor(((((intros[i][6]/1000))*#intros[i][7])-1)/60).."M", "No",intros[i][8],intros[i][9])
		else 
			guiGridListAddRow(GUIEditor.gridlist[1], intros[i][1], location.."("..city..")", math.floor(((((intros[i][6]/1000))*#intros[i][7])-1)/60).."M", "Yes",intros[i][8],intros[i][9])
		end 
		if (exports.DENsettings:getPlayerSetting("AURIntroduction_"..intros[i][1]) == true) then
			done = done + 1
		end 
	end 
	guiProgressBarSetProgress (GUIEditor.progressbar[1],  math.floor((done/#intros)*100))
	GUIEditor.label[2] = guiCreateLabel(11, 46, 892, 16, "Your progress ("..math.floor((done/#intros)*100).."% of 100%): ", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
end

function renderDx ()
	local screenW, screenH = guiGetScreenSize()
	dxDrawText("Please wait...", (screenW * 0.2818) - 1, (screenH * 0.1769) - 1, (screenW * 0.7328) - 1, (screenH * 0.2481) - 1, tocolor (0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, false, false, true, false)
	dxDrawText("Please wait...", (screenW * 0.2818) + 1, (screenH * 0.1769) - 1, (screenW * 0.7328) + 1, (screenH * 0.2481) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, false, false, true, false)
	dxDrawText("Please wait...", (screenW * 0.2818) - 1, (screenH * 0.1769) + 1, (screenW * 0.7328) - 1, (screenH * 0.2481) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, false, false, true, false)
	dxDrawText("Please wait...", (screenW * 0.2818) + 1, (screenH * 0.1769) + 1, (screenW * 0.7328) + 1, (screenH * 0.2481) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, false, false, true, false)
	dxDrawText("Please wait...", screenW * 0.2818, screenH * 0.1769, screenW * 0.7328, screenH * 0.2481, tocolor(math.random(0,255), math.random(0,255), math.random(0,255), 255), 3.00, "pricedown", "center", "top", false, false, false, true, false)
	dxDrawText("Loading introduction", (screenW * 0.2818) - 1, (screenH * 0.2815) - 1, (screenW * 0.7328) - 1, (screenH * 0.3528) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("Loading introduction", (screenW * 0.2818) + 1, (screenH * 0.2815) - 1, (screenW * 0.7328) + 1, (screenH * 0.3528) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("Loading introduction", (screenW * 0.2818) - 1, (screenH * 0.2815) + 1, (screenW * 0.7328) - 1, (screenH * 0.3528) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("Loading introduction", (screenW * 0.2818) + 1, (screenH * 0.2815) + 1, (screenW * 0.7328) + 1, (screenH * 0.3528) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("Loading introduction", screenW * 0.2818, screenH * 0.2815, screenW * 0.7328, screenH * 0.3528, tocolor(math.random(0,255), math.random(0,255), math.random(0,255), 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(introname, (screenW * 0.2818) - 1, (screenH * 0.3833) - 1, (screenW * 0.7328) - 1, (screenH * 0.4546) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(introname, (screenW * 0.2818) + 1, (screenH * 0.3833) - 1, (screenW * 0.7328) + 1, (screenH * 0.4546) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(introname, (screenW * 0.2818) - 1, (screenH * 0.3833) + 1, (screenW * 0.7328) - 1, (screenH * 0.4546) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(introname, (screenW * 0.2818) + 1, (screenH * 0.3833) + 1, (screenW * 0.7328) + 1, (screenH * 0.4546) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(introname, screenW * 0.2818, screenH * 0.3833, screenW * 0.7328, screenH * 0.4546, tocolor(math.random(0,255), math.random(0,255), math.random(0,255), 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(authorname, (screenW * 0.2818) - 1, (screenH * 0.4917) - 1, (screenW * 0.7328) - 1, (screenH * 0.5630) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(authorname, (screenW * 0.2818) + 1, (screenH * 0.4917) - 1, (screenW * 0.7328) + 1, (screenH * 0.5630) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(authorname, (screenW * 0.2818) - 1, (screenH * 0.4917) + 1, (screenW * 0.7328) - 1, (screenH * 0.5630) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(authorname, (screenW * 0.2818) + 1, (screenH * 0.4917) + 1, (screenW * 0.7328) + 1, (screenH * 0.5630) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText(authorname, screenW * 0.2818, screenH * 0.4917, screenW * 0.7328, screenH * 0.5630, tocolor(math.random(0,255), math.random(0,255), math.random(0,255), 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("AuroraRPG", (screenW * 0.2818) - 1, (screenH * 0.5954) - 1, (screenW * 0.7328) - 1, (screenH * 0.6667) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("AuroraRPG", (screenW * 0.2818) + 1, (screenH * 0.5954) - 1, (screenW * 0.7328) + 1, (screenH * 0.6667) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("AuroraRPG", (screenW * 0.2818) - 1, (screenH * 0.5954) + 1, (screenW * 0.7328) - 1, (screenH * 0.6667) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("AuroraRPG", (screenW * 0.2818) + 1, (screenH * 0.5954) + 1, (screenW * 0.7328) + 1, (screenH * 0.6667) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	dxDrawText("AuroraRPG", screenW * 0.2818, screenH * 0.5954, screenW * 0.7328, screenH * 0.6667, tocolor(math.random(0,255), math.random(0,255), math.random(0,255), 255), 3.00, "pricedown", "center", "top", false, true, false, true, false)
	showPlayerHudComponent ("radar", false)
end

function viewOpen()
	if getElementDimension(localPlayer) ~= 0 then
		exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your in other dimension.", 255, 0, 0)
		return
	end
	if (getPlayerWantedLevel() ~= 0) then 
		exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your wanted.", 255, 0, 0)
		return
	end
	for i=1, #intros do 
		local idname = guiGridListGetItemText(GUIEditor.gridlist[1], guiGridListGetSelectedItem (	GUIEditor.gridlist[1]), 1)
		if (idname == intros[i][1]) then 
			openClose()
			introname = intros[i][1]
			authorname = intros[i][9]
			local x, y, z = getElementPosition(getLocalPlayer())
			local rx, ry, rz = getElementPosition(getLocalPlayer())
			smoothMoveCamera(x, y, z, rx, ry, rz, x, y, z+150, rx, ry, 25.55, 1000)
			addEventHandler ("onClientRender", root, renderDx)
			tControls (false)
			setElementFrozen(getLocalPlayer(), true)
			cameraMode (true)
			setTimer(function ()
				local x, y, z, rx, ry, rz = getCameraMatrix()
				smoothMoveCamera(x, y, z, rx, ry, rz, intros[i][7][#intros[i][7]][1], intros[i][7][#intros[i][7]][2], z, intros[i][7][#intros[i][7]][4], intros[i][7][#intros[i][7]][5], intros[i][7][#intros[i][7]][6], 3000)
			end, 3000, 1)
			setTimer(function ()
				removeEventHandler ("onClientRender", root, renderDx)
				introname = ""
				authorname = ""
				triggerIntro(i)
			end, 12000, 1)
		end 
	end 
end 

function openClose ()
	if getElementDimension(localPlayer) ~= 0 then
		exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your in other dimension.", 255, 0, 0)
		return
	end
	if (getPlayerWantedLevel() ~= 0) then 
		exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your wanted.", 255, 0, 0)
		return
	end
		if (isElement(GUIEditor.window[1])) then 
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			
		else
			openGUI ()
			showCursor(true)
		end 
end 
addCommandHandler ("tutorial", openClose, true)

setTimer(function()
if (not isElement(GUIEditor.window[1])) then 
	return false
end 
		if getElementDimension(localPlayer) ~= 0 then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			
			exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your in other dimension.", 255, 0, 0)
		end
		if getElementInterior(localPlayer) ~= 0 then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			
			exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your in other interior.", 255, 0, 0)
		end
		if getElementData(localPlayer,"drugsOpen") then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			
			exports.NGCdxmsg:createNewDxMessage("Close Drugs Panel. Unable to open tutorial interface.", 255, 0, 0)
		end
		if disabled then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			
			exports.NGCdxmsg:createNewDxMessage("You can't use tutorial interface while bounded ("..theKey..")",255,0,0)
		end
		if (getPlayerWantedLevel() ~= 0) then 
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			
			exports.NGCdxmsg:createNewDxMessage("You can't use the tutorial interface due to your wanted.",255,0,0)
		end
		if isMainMenuActive() then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			
			msg("Please close MTA Main Menu")
			exports.NGCdxmsg:createNewDxMessage("You can't use tutorial interface while MTA Main Menu is open",255,0,0)
		end
end, 500, 0)
fileDelete("tutorial.lua")