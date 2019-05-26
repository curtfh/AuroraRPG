warpLocations = {
	[1] = {0, 0, 1179.73, -1328.07, 14.18, "LS Hospital"},
	[2] = {0, 0, 2041.48, -1425.96, 17.16, "LS Jefferson Hospital"},
	[3] = {0, 0, -2641.06, 630.99, 14.45, "SF Hospital"},
	[4] = {0, 0, 1615.27, 1821.87, 10.82, "LV Hospital"},
	[5] = {0, 0, 1958.46, -2188.22, 13.54, "LS Airport"},
	[6] = {0, 0, -1472.21, -269.55, 14.14, "SF Airport"},
	[7] = {0, 0, 1714.05, 1510.12, 10.79, "LV Airport"},
	[8] = {0, 0, 1529.64, -1630.67, 13.38, "LS LSPD"},
	[9] = {0, 0, -1610.21, 717.19, 12.81, "SF SFPD"},
	[10] = {0, 0, 2282.27, 2423.78, 10.82, "LV LVPD"},
	[11] = {0, 0, -2262.96, -1701.6, 479.91, "Mount Chilliad"},
	[12] = {0, 0, -1941.48, 2396.00, 49.49, "Drug store"},
	[13] = {0, 0, 6086.14,-4903.81,1.99, "Maze"},
	[14] = {0, 0, 2012.699, -3542.1001, 15.3, "Dice"},
	[15] = {0, 0, 1820.51, -3116.96, 1.21, "Admin Island"},
	[16] = {0, 0, 180.72, 1930.26, 17.96, "MF Base"},
	[17] = {0, 0, 1996.41,-51.98,33.22, "SWAT Base"},
	[18] = {0, 0, 2515.06, -2684.76, 13.6, "LS Docks"},
	[19] = {0, 1001, -3407.8359375, 1224.6304931641, 121.65866851807, "RC Baron DF"},
	[20] = {0, 1001, -750.42742919922,1910.4865722656,3.7284982204437, "TDM/FFA"},
	[21] = {0, 2000, 2905.7143554688,2283.7507324219,10.812986373901, "Race"},
	[22] = {0, 2000, -1038.6280517578, 1034.1940917969, 2.9940576553345, "Survival"},
}

local window = guiCreateWindow(825, 302, 270, 381, "AUR ~ Warp Locations", false)
guiWindowSetSizable(window, false)
guiSetVisible(window, false)
local screenW,screenH = guiGetScreenSize()
local windowW,windowH = guiGetSize(window, false)
local x, y = (screenW - windowW) / 2, (screenH - windowH) / 2
guiSetPosition(window, x, y, false)
local warp = guiCreateButton(12, 323, 111, 40, "Warp", false, window)
local cancel = guiCreateButton(142, 323, 111, 40, "Cancel", false, window)
local warpsgrid = guiCreateGridList(12, 26, 243, 282, false, window)
local column1 = guiGridListAddColumn(warpsgrid, "#", 0.13)
local column2 = guiGridListAddColumn(warpsgrid, "Place:", 0.69)

for i, v in ipairs(warpLocations) do
	local warpName = v[6]
	local row = guiGridListAddRow(warpsgrid)
	guiGridListSetItemText(warpsgrid, row, column1, i, false, false)
	guiGridListSetItemText(warpsgrid, row, column2, warpName, false, false)
end

function openUI()
	if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then
		if (guiGetVisible(window)) then
			guiSetVisible(window, false)
			showCursor(false)
		else
			guiSetVisible(window, true)
			showCursor(true)
		end
	end
end
addCommandHandler("wp", openUI)

function closeUI()
	guiSetVisible(window, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", cancel, closeUI)

function warpToLoc()
	local warpID = guiGridListGetItemText(warpsgrid, guiGridListGetSelectedItem(warpsgrid), 1)
	local i, d, x, y, z, name = unpack(warpLocations[tonumber(warpID)])
	setElementPosition(localPlayer, x, y, z)
	exports.server:setClientPlayerInterior(localPlayer, i)
	exports.server:setClientPlayerDimension(thePlayer, d)
	guiSetVisible(window, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", warp, warpToLoc, false)
