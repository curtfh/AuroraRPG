

PanelFTW = {
    button = {},
    window = {},
    staticimage = {},
    label = {}
}


function centerWindow( center_window )
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize( center_window, false )
    local x, y = ( screenW - windowW ) /2, ( screenH - windowH ) / 2
    guiSetPosition( center_window, x, y, false )
end

PanelFTW.window[1] = guiCreateWindow(8, 18, 770, 544, "AUR ~ Rooms", false)
guiWindowSetSizable(PanelFTW.window[1], false)

PanelFTW.staticimage[1] = guiCreateStaticImage(16, 28, 157, 139, "cnr.png", false, PanelFTW.window[1])
PanelFTW.staticimage[2] = guiCreateStaticImage(219, 28, 157, 139, "dm.png", false, PanelFTW.window[1])
PanelFTW.staticimage[3] = guiCreateStaticImage(417, 28, 157, 139, "dd.png", false, PanelFTW.window[1])
PanelFTW.staticimage[4] = guiCreateStaticImage(602, 28, 157, 139, "str.png", false, PanelFTW.window[1])
PanelFTW.staticimage[5] = guiCreateStaticImage(16, 208, 157, 139, "Trials.png", false, PanelFTW.window[1])
PanelFTW.staticimage[6] = guiCreateStaticImage(219, 208, 157, 139, "drag.png", false, PanelFTW.window[1])
PanelFTW.staticimage[7] = guiCreateStaticImage(417, 208, 157, 139, "csgo.png", false, PanelFTW.window[1])
PanelFTW.button[1] = guiCreateButton(637, 470, 109, 58, "CLOSE", false, PanelFTW.window[1])
guiSetFont(PanelFTW.button[1], "default-bold-small")
PanelFTW.label[1] = guiCreateLabel(19, 173, 154, 25, "Players : 0", false, PanelFTW.window[1])
guiSetFont(PanelFTW.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(PanelFTW.label[1], "center", false)
PanelFTW.label[2] = guiCreateLabel(219, 173, 154, 25, "Players : 0", false, PanelFTW.window[1])
guiSetFont(PanelFTW.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(PanelFTW.label[2], "center", false)
PanelFTW.label[3] = guiCreateLabel(417, 173, 154, 25, "Players : 0", false, PanelFTW.window[1])
guiSetFont(PanelFTW.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(PanelFTW.label[3], "center", false)
PanelFTW.label[4] = guiCreateLabel(597, 173, 154, 25, "Players : 0", false, PanelFTW.window[1])
guiSetFont(PanelFTW.label[4], "default-bold-small")
guiLabelSetHorizontalAlign(PanelFTW.label[4], "center", false)
PanelFTW.label[5] = guiCreateLabel(19, 357, 154, 25, "Players : 0", false, PanelFTW.window[1])
guiSetFont(PanelFTW.label[5], "default-bold-small")
guiLabelSetHorizontalAlign(PanelFTW.label[5], "center", false)
PanelFTW.label[6] = guiCreateLabel(219, 357, 154, 25, "Players : 0", false, PanelFTW.window[1])
guiSetFont(PanelFTW.label[6], "default-bold-small")
guiLabelSetHorizontalAlign(PanelFTW.label[6], "center", false)
PanelFTW.label[7] = guiCreateLabel(417, 357, 154, 25, "Players : 0", false, PanelFTW.window[1])
guiSetFont(PanelFTW.label[7], "default-bold-small")
guiLabelSetHorizontalAlign(PanelFTW.label[7], "center", false)
PanelFTW.label[8] = guiCreateLabel(224, 414, 337, 116, "Rules\n\n\n1) Don't be AFK\n\n2) Don't Camp\n\n3) Abusing,Insulting will result in punishment", false, PanelFTW.window[1])
guiSetFont(PanelFTW.label[8], "default-bold-small")
guiLabelSetHorizontalAlign(PanelFTW.label[8], "center", false)


guiSetVisible(PanelFTW.window[1],false)
centerWindow(PanelFTW.window[1])

function opengui()
	local cnr = {}
	local shr = {}
	local dd = {}
	local dm = {}
	local drag = {}
	local trials = {}
	local csgo = {}
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == 5001 then
			table.insert(shr,v)
		elseif getElementDimension(v) == 5002 then
			table.insert(dd,v)
		elseif getElementDimension(v) == 5003 then
			table.insert(csgo,v)
		elseif getElementDimension(v) == 5004 then
			table.insert(dm,v)
		elseif getElementDimension(v) == 5005 then
			table.insert(trials,v)
		elseif getElementDimension(v) == 5006 then
			table.insert(drag,v)
		elseif getElementDimension(v) <= 4999 then
			table.insert(cnr,v)
		end
	end
	guiSetText(PanelFTW.label[4],"Players: "..#shr)
	guiSetText(PanelFTW.label[3],"Players: "..#dd)
	guiSetText(PanelFTW.label[1],"Players: "..#cnr)
	guiSetText(PanelFTW.label[5],"Players: "..#trials)
	guiSetText(PanelFTW.label[6],"Players: "..#drag)
	guiSetText(PanelFTW.label[7],"Players: "..#csgo)
	guiSetText(PanelFTW.label[2],"Players: "..#dm)
	guiSetVisible(PanelFTW.window[1],true)
	showCursor(true)
end
addCommandHandler("room",opengui)

addEventHandler("onClientGUIClick",root,function()
	if source == PanelFTW.button[1] then
		guiSetVisible(PanelFTW.window[1],false)
		showCursor(false)
	elseif source == PanelFTW.staticimage[4] then -- go shooter
		guiSetVisible(PanelFTW.window[1],false)
		showCursor(false)
		triggerServerEvent("joinShooterRoom",localPlayer)
	elseif source == PanelFTW.staticimage[3] then -- go DD
		guiSetVisible(PanelFTW.window[1],false)
		showCursor(false)
		triggerServerEvent("joinDDRoom",localPlayer)
	elseif source == PanelFTW.staticimage[7] then -- go CSGO
		guiSetVisible(PanelFTW.window[1],false)
		showCursor(false)
		triggerServerEvent("joinCSGORoom",localPlayer)
	elseif source == PanelFTW.staticimage[5] then -- go trials
		guiSetVisible(PanelFTW.window[1],false)
		showCursor(false)
		triggerServerEvent("joinTrialsRoom",localPlayer)
	elseif source == PanelFTW.staticimage[6] then -- go drag
		guiSetVisible(PanelFTW.window[1],false)
		showCursor(false)
		triggerServerEvent("joinDragRoom",localPlayer)
	elseif source == PanelFTW.staticimage[2] then -- go dm
		guiSetVisible(PanelFTW.window[1],false)
		showCursor(false)
		triggerServerEvent("joinDMRoom",localPlayer)
	elseif source == PanelFTW.staticimage[1] then -- go cnr
		guiSetVisible(PanelFTW.window[1],false)
		showCursor(false)
		if getElementDimension(localPlayer) == 5001 then
			triggerServerEvent("quitShooterRoom",localPlayer)
		elseif getElementDimension(localPlayer) == 5002 then
			triggerServerEvent("quitDDRoom",localPlayer)
		elseif getElementDimension(localPlayer) == 5004 then
			triggerServerEvent("quitDMRoom",localPlayer)
		elseif getElementDimension(localPlayer) == 5003 then
			triggerServerEvent("quitCSGORoom",localPlayer)
		elseif getElementDimension(localPlayer) == 5005 then
			triggerServerEvent("quitTrialsRoom",localPlayer)
		elseif getElementDimension(localPlayer) == 5006 then
			triggerServerEvent("quitDragRoom",localPlayer)
		end
	end
end)

for i=1,7 do
	addEventHandler( "onClientMouseEnter",PanelFTW.staticimage[i], function()
		if source == PanelFTW.staticimage[i] then
			guiSetAlpha(source,0.5)
		end
	end)
	addEventHandler( "onClientMouseLeave",PanelFTW.staticimage[i], function()
		if source == PanelFTW.staticimage[i] then
			guiSetAlpha(source,1)
		end
	end)
end


local g_ModelForPickupType = { nitro = 2221, repair = 2222 }

for name,id in pairs(g_ModelForPickupType) do
	engineImportTXD(engineLoadTXD('models/' .. name .. '.txd'), id)
	engineReplaceModel(engineLoadDFF('models/' .. name .. '.dff', id), id)
	engineSetModelLODDistance( id, 60 )
end
