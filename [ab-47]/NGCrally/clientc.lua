--Defined variable args:

local screenWidth, screenHeight = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()

--Create Data Tables:

local markers = {
	{3783.6599121094, -1547.2905273438, 18.310157775879 - 1},
}

local checkpointData = {
	[1] = {3818.8786621094, -1725.0252685547, 19.109495162964, 1},
	[2] = {3797.9748535156, -2046.7490234375, 14.312975883484, 2},
	[3] = {3845.6782226563, -2308.3408203125, 18.84200668335, 3},
	[4] = {3844.306640625, -2047.4282226563, 16.624580383301, 4},
	[5] = {3879.2666015625, -1470.3077392578, 16.965826034546, 5},
	[6] = {3623.1726074219, -1579.4447021484, 12.145140647888, 6},
	[7] = {3689.1477050781, -2131.1784667969, 21.778936386108, 7},
	[8] = {3741.7741699219, -2159.9624023438, 13.414298057556, 8},
	[9] = {3713.9592285156, -1671.5263671875, 14.909630775452, 9},
	[10] = {3808.5732421875, -1510.0239257813, 16.683134078979, 10}, --Finish Line
}

local position = {}
local markers_ = {}
local marker2key = {}
local chkpos = 0

function getMyMarkers()
	return markers_
end
 
function isCheckpoint(m)
	for key, marker in pairs(markers_) do
		if (marker == m) then
			return true
		end
	end
	return false
end

playerdataa = {}

local playerdata = {
	checkpoint = {};
	pospoint = {};
	chance = {};
}

--Handle Renders in mods:

addEventHandler('onClientResourceStart', resourceRoot,
    function()
        local txd = engineLoadTXD('race_mods/model_.txd',true)
        engineImportTXD(txd, 16209)
 
        local dff = engineLoadDFF('race_mods/model_.dff', 0)
        engineReplaceModel(dff, 16209)
 
        local col = engineLoadCOL('race_mods/model_.col')
        engineReplaceCOL(col, 16209)
        engineSetModelLODDistance(16209, 0)

        local dff = engineLoadDFF('race_mods/model_1.dff', 0)
        engineReplaceModel(dff, 16208)
 
        local col = engineLoadCOL('race_mods/model_1.col')
        engineReplaceCOL(col, 16208)
        engineSetModelLODDistance(16208, 0)
        
        local dff = engineLoadDFF('race_mods/model_2.dff', 0)
        engineReplaceModel(dff, 16207)
 
        local col = engineLoadCOL('race_mods/model_2.col')
        engineReplaceCOL(col, 16207)
        engineSetModelLODDistance(16207, 0)
	end 
)

function unpackMarkers()
	if (markers) then
		for i, v in pairs(markers) do
			marker_ent = createMarker(v[1], v[2], v[3], "cylinder", 1.5, 255, 255, 0, 200)
			--marker_blp = createBlipAttachedTo(marker_ent, 1, 2, 0, 255, 0)
			marker_blp = exports.customblips:createCustomBlip(v[1], v[2], 20, 20, "race_imgs/icon.png")
			exports.customblips:setCustomBlipStreamRadius(marker_blp, 100)
			addEventHandler("onClientMarkerHit", marker_ent, init_handle_rpanel)
			--addEventHandler("onClientMarkerLeave", marker_ent, function()if guiGetVisible(ngcrace_window)then guiSetVisible(ngcrace_window, false)showCursor(false)end end)
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, unpackMarkers)

function init_handle_rpanel(hitElement, matchingDimension)
	if (isPedInVehicle(hitElement)) then return end
	if (hitElement and getElementType(hitElement) == "player" and hitElement == localPlayer) then
		if (source == marker_ent) then
			if (not guiGetVisible(ngcrace_window)) then
				guiSetVisible(ngcrace_window, true)
				showCursor(not isCursorShowing(), true)
			end
		end
	end
end
--addCommandHandler("handlerace", init_handle_rpanel)

--GUI Stuff:

function create_main_race_gui()
	windowWidth, windowHeight = 528, 418
	windowWidth_, windowHeight_ = 110, 120
	windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
	ngcrace_window = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "NGC Rally", false)
	ngcrace_gridlist = guiCreateGridList(294, 251, 220, 153, false, ngcrace_window)
	column = guiGridListAddColumn(ngcrace_gridlist, "Participants", 0.9)
	guiSetAlpha(ngcrace_window, 1.00)
	guiSetVisible(ngcrace_window, false)
	
	ngcrace_image = guiCreateStaticImage(105, 23, 327, 104, "race_imgs/ngc_log.png", false, ngcrace_window)
	ngcrace_label_1 = guiCreateLabel(23, 117, 99, 26, "3 simple steps:", false, ngcrace_window)
	ngcrace_label_6 = guiCreateLabel(23, 143, 226, 29, "1) Read the terms and conditions", false, ngcrace_window)
	ngcrace_label_7 = guiCreateLabel(23, 168, 133, 26, "2) Click to sign up ", false, ngcrace_window)
	ngcrace_label_8 = guiCreateLabel(23, 189, 166, 26, "3) Wait for participants", false, ngcrace_window)
	ngcrace_label_2 = guiCreateLabel(288, 117, 148, 26, "Terms and Conditions:", false, ngcrace_window)
	ngcrace_label_10 = guiCreateLabel(284, 143, 226, 29, "1) You must have 5k to register", false, ngcrace_window)
	ngcrace_label_11 = guiCreateLabel(288, 168, 226, 29, "2) Deathmatching is not allowed", false, ngcrace_window)
	ngcrace_label_12 = guiCreateLabel(284, 193, 226, 29, "3) Ramming vehicles is allowed", false, ngcrace_window)
	ngcrace_label_13 = guiCreateLabel(274, 218, 226, 29, "4) Last but not least, enjoy", false, ngcrace_window)
	ngcrace_label_9 = guiCreateLabel(23, 211, 166, 26, "Winner takes home 50k", false, ngcrace_window)
	ngcrace_label_3 = guiCreateLabel(23, 251, 261, 19, "Participants Registered: None (Limit: 5)", false, ngcrace_window)
	ngcrace_label_4 = guiCreateLabel(23, 270, 261, 19, "Least Participants allowed: 3 players", false, ngcrace_window)
	ngcrace_label_5 = guiCreateLabel(18, 307, 271, 34, "Sign Up Fees: $5,000!", false, ngcrace_window)
	
	ngcrace_sign_up = guiCreateButton(23, 367, 123, 37, "Sign Up", false, ngcrace_window)
	ngcrace_exit = guiCreateButton(156, 367, 123, 37, "Exit", false, ngcrace_window)
	
	guiSetFont(ngcrace_label_7, "clear-normal")
	guiSetFont(ngcrace_label_8, "clear-normal")
	guiSetFont(ngcrace_label_2, "clear-normal")
	guiSetFont(ngcrace_label_10, "clear-normal")
	guiSetFont(ngcrace_label_11, "clear-normal")
	guiSetFont(ngcrace_label_12, "clear-normal")
	guiSetFont(ngcrace_label_13, "clear-normal")
	guiSetFont(ngcrace_label_9, "clear-normal")
	guiSetFont(ngcrace_label_3, "clear-normal")
	guiSetFont(ngcrace_label_4, "clear-normal")
	guiSetFont(ngcrace_label_5, "clear-normal")
	guiSetFont(ngcrace_label_1, "clear-normal")
	guiSetFont(ngcrace_label_6, "clear-normal")
	
	guiLabelSetColor(ngcrace_label_1, 150, 144, 144)
	guiLabelSetColor(ngcrace_label_6, 254, 126, 0)
	guiLabelSetColor(ngcrace_label_7, 254, 126, 0)
	guiLabelSetColor(ngcrace_label_8, 254, 126, 0)
	guiLabelSetColor(ngcrace_label_2, 150, 144, 144)
	guiLabelSetColor(ngcrace_label_10, 254, 126, 0)
	guiLabelSetColor(ngcrace_label_11, 254, 126, 0)
	guiLabelSetColor(ngcrace_label_12, 254, 126, 0)
	guiLabelSetColor(ngcrace_label_13, 254, 126, 0)
	guiLabelSetColor(ngcrace_label_9, 255, 162, 71)
	guiLabelSetColor(ngcrace_label_3, 150, 144, 144)
	guiLabelSetColor(ngcrace_label_4, 150, 144, 144)
	guiLabelSetColor(ngcrace_label_5, 109, 242, 83)
	
	guiLabelSetVerticalAlign(ngcrace_label_1, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_6, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_6, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_7, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_7, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_8, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_8, "center")
	guiLabelSetVerticalAlign(ngcrace_label_2, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_10, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_10, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_11, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_11, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_12, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_12, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_13, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_13, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_9, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_9, "center")
	guiLabelSetVerticalAlign(ngcrace_label_3, "center")
	guiLabelSetVerticalAlign(ngcrace_label_4, "center")
	guiLabelSetHorizontalAlign(ngcrace_label_5, "center", false)
	guiLabelSetVerticalAlign(ngcrace_label_5, "center") 
	
	--ngcrally_race_1 = guiCreateImage(windowX, windowY, windowWidth_, windowHeight_, 'race_imgs/ngcrally_race_1', false)
	--ngcrally_race_2 = guiCreateImage(windowX, windowY, windowWidth_, windowHeight_, 'race_imgs/ngcrally_race_2', false)
	ngcrally_race_3 = guiCreateStaticImage(windowX, windowY, windowWidth_, windowHeight_, 'race_imgs/ngcrally_race_3.png', false)
	guiSetVisible(ngcrally_race_3, false)
	--ngcrally_race_go = guiCreateImage(windowX, windowY, windowWidth_, windowHeight_, 'race_imgs/ngcrally_race_go', false)
	
	guiSetProperty(ngcrace_sign_up, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(ngcrace_exit, "NormalTextColour", "FFAAAAAA")
	
	centerWindow(ngcrace_window)
	centerWindow(ngcrally_race_3)
	
	addEventHandler("onClientGUIClick", ngcrace_exit, function()if(source==ngcrace_exit)then guiSetVisible(ngcrace_window, false) showCursor(false)end end)
	addEventHandler("onClientGUIClick", ngcrace_sign_up, sign_action)
end
addEventHandler("onClientResourceStart", resourceRoot, create_main_race_gui)

--Center Window

function centerWindow(window_element)
    local windowW,windowH=guiGetSize(window_element,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(window_element,x,y,false)
end

--Functions:

function sign_action()
	if (localPlayer and getElementType(localPlayer) == "player") then
		if (source == ngcrace_sign_up) then
			if (getPlayerMoney(localPlayer) >= 5000) then
				triggerServerEvent("NGCrally.sign_up", localPlayer, getLocalPlayer())
				outputDebugString("sign_action triggered")
			else
				outputChatBox("You do not have enough money to sign up for this rally!", 255, 0, 0)
			end
		end
	end
end

function update_charts(counts, plr)
	if (not counts and not plr) then return end
	guiSetText(ngcrace_label_3, "Participants Registered: "..counts.." (Limit: 5)")
	if (column and counts <= 5) then
		local row_1 = guiGridListAddRow(ngcrace_gridlist)
		guiGridListSetItemText(ngcrace_gridlist, row_1, column, plr, false, false)
	end
	outputChatBox(plr)
end
addEvent("NGCrally.update_charts", true)
addEventHandler("NGCrally.update_charts", root, update_charts)

function destroy_elements()
	guiSetText(ngcrace_label_3, "Participants Registered: None (Limit: 5)")
	guiGridListClear(ngcrace_gridlist)
end
addEvent("NGCrally.destroy_elements", true)
addEventHandler("NGCrally.destroy_elements", root, destroy_elements)

function init_starting()
	if (not guiGetVisible(ngcrally_race_3)) then
		guiSetVisible(ngcrally_race_3, true)
		setTimer(guiStaticImageLoadImage, 1000, 1, ngcrally_race_3, "race_imgs/ngcrally_race_2.png")
		setTimer(guiStaticImageLoadImage, 2000, 1, ngcrally_race_3, "race_imgs/ngcrally_race_1.png")
		setTimer(guiStaticImageLoadImage, 3000, 1, ngcrally_race_3, "race_imgs/ngcrally_race_go.png")
		setTimer(guiStaticImageLoadImage, 5000, 1, ngcrally_race_3, "race_imgs/ngcrally_race_3.png")
		setTimer(function() guiSetVisible(ngcrally_race_3, false) end, 4000, 1)
		addRaceCheckpoints(localPlayer)
	end
end
addEvent("NGCrally.init_starting", true)
addEventHandler("NGCrally.init_starting", root, init_starting)

function addRaceCheckpoints(plr)
	markers_ = {}
    for k, v in pairs(checkpointData) do
		local tempMarker = createMarker(v[1], v[2], v[3], "cylinder", 4.0, 255, 255, 255, 255)
        table.insert(markers_, tempMarker)
        marker2key[tempMarker] = v[4]
    end
end


 
addEventHandler("onClientMarkerHit", root,
    function ( hitPlayer, matchDim )
        if (matchDim) and (isCheckpoint(source)) and (hitPlayer == localPlayer) then
            if (marker2key[source] == 1) then
				if (chkpos ~= marker2key[source]) then
					chkpos = marker2key[source] + 1
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos - 1)
				--table.insert(position, hitPlayer, marker2key[source])
				send_data_here(marker2key[source])
                outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 2) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = marker2key[source] + 1
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 3) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = marker2key[source] + 1
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 4) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = marker2key[source] + 1
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 5) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = marker2key[source] + 1
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 6) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = marker2key[source] + 1
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 7) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = marker2key[source] + 1
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 8) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = marker2key[source] + 1
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 9) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = marker2key[source] + 1
                if (isElement(source)) then
                    destroyElement(source)
                end
			elseif (marker2key[source] == 10) then
				if (chkpos ~= marker2key[source]) then
					outputChatBox("Looks like you've missed a checkpoint..", 255, 0, 0)
					return
				end
				triggerServerEvent("AURrally.update_position", localPlayer, localPlayer, chkpos)
				send_data_here(marker2key[source])
				outputChatBox("Through the finish line! Checkpoint number: "..marker2key[source], 255, 0, 0)
				chkpos = 0
				triggerServerEvent("AURrally.quit_event", hitPlayer, hitPlayer, "2")
                if (isElement(source)) then
                    destroyElement(source)
                end
            end
        end
    end
)

function removetheevent()
	triggerServerEvent("AURrally.quit_event", localPlayer, localPlayer, "2")
end
addCommandHandler("removerace", removetheevent)

function send_data_here(number)
	if (number) then
		playerdata.checkpoint[localPlayer] = number
		--outputChatBox(playerdata.checkpoint[localPlayer])
	end
	playerdata.pospoint[localPlayer] = 0
	playerdata.chance[localPlayer] = 0
end

local sx, sy = guiGetScreenSize()
local px, py = 1152, 864
local x, y = (sx/px), (sy/py)

function handle_render_dx()
	chkpoint = playerdata.checkpoint[localPlayer] or "nil"
	pospoint = playerdata.pospoint[localPlayer] or "nil"
	chncewin = playerdata.chance[localPlayer] or "nil"
	dxDrawRectangle(x*885,y*275,x*220,y*204, tocolor(238, 196, 52, 105), false)
	dxDrawText("Checkpoint: "..chkpoint.."/10", x*1775+1,y*410+1,x*220+1,y*204+1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Checkpoint: "..chkpoint.."/10", x*1775,y*410,x*220,y*204, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Position: "..pospoint.."/5", x*1781+1, y*480+1, x*220+1,y*204+1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Position: "..pospoint.."/5", x*1781, y*480, x*220,y*204, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Time Remaining: 00:00", x*1781+1, y*550+1, x*220+1,y*204+1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Time Remaining: 00:00", x*1781, y*550, x*220,y*204, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Prize: $50,000", x*1781+1, y*620+1, x*220+1,y*204+1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Prize: $50,000", x*1781, y*620, x*220,y*204, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Chance of winning: "..chncewin.."%", x*1781+1, y*690+1, x*220+1,y*204+1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("Chance of winning: "..chncewin.."%", x*1781, y*690, x*220,y*204, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
end
--addEventHandler("onClientRender", root, handle_render_dx)


--[[local objects = getElementsByType("object", resourceRoot) 
for theKey,object in ipairs(objects) do 
	local id = getElementModel(object)
	local x,y,z = getElementPosition(object)
	local rx,ry,rz = getElementRotation(object)
	local scale = getObjectScale(object)
	objLowLOD = createObject ( id, x,y,z,rx,ry,rz,true )
	setObjectScale(objLowLOD, scale)
	setLowLODElement ( object, objLowLOD )
	engineSetModelLODDistance ( id, 3000 )
	setElementStreamable ( object , false)
end]]
