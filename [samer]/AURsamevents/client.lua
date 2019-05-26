GUIEditor = {
    checkbox = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}

}

local commands = {
["Player Commands"] =
	{
		"Warp players to you",
		"Return players to previous position",
		"(Un)Freeze events players",
		"Enable/disable weapons",
		"Set players health to 10",
		"Enable/Disable players collision",
		"Enable/disable players damage",
		"Show/Hide players blips",
		"Disable/Enable team damage",
	},
	
["Vehicles Commands"] =
	{
		"(Un)freeze event vehicles",
		"Enable/Disable Vehicle Damage Proof",
		"Enable/Disable Vehicle Collision",
		"Destroy Event Vehicles",
		"Enable/Disable Vehicles bumper ramp (bumper ramp will be added to event vehicles)",
		"Fix Event Vehicles",
		"Lock Event Vehicles",
		"Enable vehicles fly",
		"Blow vehicles",
	},

["Weapon Commands"] =
	{
		"Disable/enable explosives (Grenades, Satchels, Teargas, Molotov)",
		"Disable/enable rifles (country rifle, sniper)",
		"Disable/enable heavy (Minigun, RPG)",
		"Disable/enable shotguns (Spas, Shotgun)",
		"Disable/enable SMG (MP5, Tec9, Uzi)",
		"Disable/enable pistols (Deagle, Pistol, Silenced Pistol)",
	},

["Pickup Commands"] =
	{
		"Create Health Pickup",
		"Create Armor Pickup",
		"Create Parachute Pickup",
		"Destroy Event Pickups",
	},
	
["Other/Staff Commands"] =
	{
		"Add race checkpoint (checkpoint will be added in the current staff postion)",
		"Add race finishpoint (same as race checkpoint)",
		"Destroy checkpoints",
		"Add event marker",
		"Add bump ramp (get inside a vehicle first)",
	}
}

local screenW, screenH = guiGetScreenSize()
local sX, sY = screenW / 1366, screenH / 768
GUIEditor.window[1] = guiCreateWindow((screenW - 862) / 2, (screenH - 684) / 2, 862, 684, "AURORA ~ Event System V2", false)
guiWindowSetSizable(GUIEditor.window[1], false)
guiSetVisible(GUIEditor.window[1], false)
GUIEditor.gridlist[1] = guiCreateGridList(sX*10, sY*33, sX*318, 555, false, GUIEditor.window[1])
addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], function() 
	local commandName = guiGridListGetItemText(GUIEditor.gridlist[1], guiGridListGetSelectedItem(GUIEditor.gridlist[1]), 1)
	guiSetText(GUIEditor.button[7], commandName)
end, false )
guiGridListAddColumn(GUIEditor.gridlist[1], "Commands", 0.9)
GUIEditor.edit[1] = guiCreateEdit(sX*434, sY*37, sX*179, sY*30, "", false, GUIEditor.window[1])
GUIEditor.label[1] = guiCreateLabel(sX*338, sY*43, sX*80, sY*15, "Event Name:", false, GUIEditor.window[1])
GUIEditor.button[1] = guiCreateButton(sX*464, sY*77, sX*120, sY*23, "Create Event", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF41F12F")
GUIEditor.label[2] = guiCreateLabel(sX*646, sY*42, sX*80, sY*15, "Event Limit:", false, GUIEditor.window[1])
GUIEditor.button[2] = guiCreateButton(sX*716, sY*77, sX*120, sY*23, "Multiple Warps", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFAF225")
GUIEditor.checkbox[1] = guiCreateCheckBox(sX*338, sY*81, sX*106, sY*15, "Freeze on warp", false, false, GUIEditor.window[1])
GUIEditor.edit[2] = guiCreateEdit(sX*736, sY*37, sX*84, sY*30, "", false, GUIEditor.window[1])
GUIEditor.label[3] = guiCreateLabel(sX*338, sY*119, sX*106, sY*15, "Event Dimension:", false, GUIEditor.window[1])
GUIEditor.edit[3] = guiCreateEdit(sX*463, sY*110, sX*121, sY*34, "5000", false, GUIEditor.window[1])
GUIEditor.label[4] = guiCreateLabel(sX*338, sY*159, sX*106, sY*15, "Event Interior:", false, GUIEditor.window[1])
GUIEditor.gridlist[2] = guiCreateGridList(sX*338, sY*189, sX*219, sY*279, false, GUIEditor.window[1])
guiGridListAddColumn(GUIEditor.gridlist[2], "Online Players", 0.9)
GUIEditor.edit[4] = guiCreateEdit(sX*437, sY*478, sX*120, sY*26, "MAX 100,000", false, GUIEditor.window[1])
GUIEditor.button[3] = guiCreateButton(sX*338, sY*478, sX*89, sY*25, "Send Money", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FF20F020")
GUIEditor.button[4] = guiCreateButton(sX*338, sY*513, sX*89, sY*25, "Send Score", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FF20F020")
GUIEditor.edit[5] = guiCreateEdit(sX*437, sY*512, sX*120, sY*26, "MAX 15", false, GUIEditor.window[1])
GUIEditor.gridlist[3] = guiCreateGridList(sX*621, sY*189, sX*225, sY*279, false, GUIEditor.window[1])
guiGridListAddColumn(GUIEditor.gridlist[3], "Players in Event", 0.9)
GUIEditor.button[5] = guiCreateButton(sX*621, sY*479, sX*89, sY*25, "Kick Player", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFFE1111")
GUIEditor.button[6] = guiCreateButton(sX*747, sY*479, sX*99, sY*25, "(Un)Freeze Player", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFFE1111")
GUIEditor.button[7] = guiCreateButton(sX*10, sY*598, sX*318, sY*36, "No command selected", false, GUIEditor.window[1])
GUIEditor.label[5] = guiCreateLabel(sX*43, sY*644, sX*251, sY*15, "NOTE: Select a command from the list above", false, GUIEditor.window[1])
guiLabelSetColor(GUIEditor.label[5], 254, 31, 31)
GUIEditor.label[6] = guiCreateLabel(sX*687, sY*566, sX*95, sY*16, "Create Vehicles :", false, GUIEditor.window[1])
GUIEditor.edit[6] = guiCreateEdit(sX*619, sY*592, sX*233, sY*24, "Vehicle Name/ID", false, GUIEditor.window[1])
GUIEditor.button[8] = guiCreateButton(sX*618, sY*626, sX*89, sY*35, "Create Vehicle Marker", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[8], "NormalTextColour", "FF4DFE1E")
GUIEditor.button[9] = guiCreateButton(sX*757, sY*626, sX*89, sY*35, "Destroy Vehicle Marker", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[9], "NormalTextColour", "FF4DFE1E")
GUIEditor.button[10] = guiCreateButton(sX*621, sY*514, sX*89, sY*25, "Give Jetpack", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[10], "NormalTextColour", "FFFE1111")
GUIEditor.button[11] = guiCreateButton(sX*747, sY*514, sX*99, sY*25, "Remove Jetpack", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[11], "NormalTextColour", "FFFE1111")
GUIEditor.label[7] = guiCreateLabel(sX*611, sY*134, sX*72, sY*15, "Team Warps", false, GUIEditor.window[1])
guiLabelSetColor(GUIEditor.label[7], 34, 248, 200)
GUIEditor.button[12] = guiCreateButton(sX*590, sY*77, sX*120, sY*23, "Close Warps", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[12], "NormalTextColour", "FF41F12F")
GUIEditor.button[13] = guiCreateButton(sX*590, sY*107, sX*120, sY*23, "Stop Event", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[13], "NormalTextColour", "FF41F12F")
GUIEditor.edit[7] = guiCreateEdit(sX*463, sY*150, sX*121, sY*34, "0", false, GUIEditor.window[1])
GUIEditor.button[14] = guiCreateButton(sX*716, sY*107, sX*120, sY*23, "Time Counter", false, GUIEditor.window[1])
guiSetProperty(GUIEditor.button[14], "NormalTextColour", "FF41F12F")
GUIEditor.edit[8] = guiCreateEdit(sX*589, sY*150, sX*121, sY*34, "Team Name", false, GUIEditor.window[1])
GUIEditor.edit[9] = guiCreateEdit(sX*716, sY*150, sX*121, sY*34, "Time (Seconds)", false, GUIEditor.window[1])
GUIEditor.button[15] = guiCreateButton(sX*362, 647, sX*155, sY*27, "Close Panel", false, GUIEditor.window[1])
addEventHandler("onClientGUIClick", GUIEditor.button[15], function() guiSetVisible(GUIEditor.window[1], false) showCursor(false) end, false )
guiSetProperty(GUIEditor.button[15], "NormalTextColour", "FFE824F5")
GUIEditor.label[8] = guiCreateLabel(sX*577, sY*318, sX*17, sY*15, ">>>>", false, GUIEditor.window[1])
GUIEditor.label[9] = guiCreateLabel(sX*362, sY*608, sX*155, sY*16, "Event Players Number:", false, GUIEditor.window[1])
guiLabelSetColor(GUIEditor.label[9], 33, 255, 49)

function openPanel()
	if (getTeamName(getPlayerTeam(localPlayer)) ~= "Staff") then return end
	if (guiGetVisible(GUIEditor.window[1])) then
		guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
	else
		guiSetVisible(GUIEditor.window[1], true)
		showCursor(true)
		guiGridListClear(GUIEditor.gridlist[1])
		for section, commands in pairs(commands) do
			local title = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], title, 1, section, true, false)
			for key, command in pairs(commands) do
				local commandRow = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], commandRow, 1, command, false, false)
			end
		end
		
		guiGridListClear(GUIEditor.gridlist[2])
		for key, player in pairs(getElementsByType("player")) do
			local row = guiGridListAddRow(GUIEditor.gridlist[2])
			guiGridListSetItemText(GUIEditor.gridlist[2], row, 1, getPlayerName(player), true, false)
			local r, g, b = getPlayerNametagColor(player)
			guiGridListSetItemColor(GUIEditor.gridlist[2], row, 1, r, g, b)
		end
	end
end
addCommandHandler("show_events", openPanel)

addEventHandler("onClientGUIClick", GUIEditor.button[1],
	function()
		local eventName = guiGetText(GUIEditor.edit[1])
		local eventLimit = tonumber(guiGetText(GUIEditor.edit[2]))
		local freezeOnWarps = guiCheckBoxGetSelected(GUIEditor.checkbox[1])
		local eventInt = tonumber(guiGetText(GUIEditor.edit[3]))
		local eventDim = tonumber(guiGetText(GUIEditor.edit[7]))
		local team = guiGetText(GUIEditor.edit[8])
		triggerServerEvent("AURsamevents.createEvent", resourceRoot, eventName, eventLimit, freezeOnWarps, eventInt, eventDim, team)
	end, false
)

addEventHandler("onClientGUIClick", GUIEditor.button[13],
	function()
		--triggerServerEvent("AURsamevents.destroyEvent", resourceRoot)
	end, false
)