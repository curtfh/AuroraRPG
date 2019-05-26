GUIEditor = {
    checkbox = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

local playerCommands = {
    "Warp players to you",
    "Return players to previous position",
    "(Un)Freeze events players",
    "Enable/disable weapons",
    "Set players health to 10",
    "Enable/Disable players collision",
    "Enable/disable players damage",
    "Show/Hide players blips",
    "Disable/Enable team damage",  
}

local vehicleCommands = {
    
    "(Un)freeze event vehicles",
    "Enable/Disable Vehicle Damage Proof",
    "Enable/Disable Vehicle Collision",
    "Destroy Event Vehicles",
    "Enable/Disable Vehicles bumper ramp (bumper ramp will be added to event vehicles)",
    "Fix Event Vehicles",
    "Lock Event Vehicles",
    "Enable vehicles fly",
    "Blow vehicles",
}

local wepCommands = {
    
    "Disable/enable explosives (Grenades, Satchels, Teargas, Molotov)",
    "Disable/enable rifles (country rifle, sniper)",
    "Disable/enable heavy (Minigun, RPG)",
    "Disable/enable shotguns (Spas, Shotgun)",
    "Disable/enable SMG (MP5, Tec9, Uzi)",
    "Disable/enable pistols (Deagle, Pistol, Silenced Pistol)",
}

local pickCommands = {
    
    "Create Health Pickup",
    "Create Armor Pickup",
    "Create Parachute Pickup",
    "Destroy Event Pickups",
}

local staffCommands = {
    
    "Add race checkpoint (checkpoint will be added in the current staff postion)",
    "Add race finishpoint (same as race checkpoint)",
    "Destroy checkpoints",
    "Add event marker",
    "Add bump ramp (get inside a vehicle first)",
}

local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 862) / 2, (screenH - 684) / 2, 862, 684, "AURORA ~ Event System V2", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
 
        GUIEditor.gridlist[1] = guiCreateGridList(10, 33, 318, 555, false, GUIEditor.window[1])
        guiGridListAddColumn(GUIEditor.gridlist[1], "Commands", 0.9)
        GUIEditor.edit[1] = guiCreateEdit(434, 37, 179, 30, "", false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(338, 43, 80, 15, "Event Name:", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(464, 77, 120, 23, "Create Event", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF41F12F")
        GUIEditor.label[2] = guiCreateLabel(646, 42, 80, 15, "Event Limit:", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(716, 77, 120, 23, "Multiple Warps", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFAF225")
        GUIEditor.checkbox[1] = guiCreateCheckBox(338, 81, 106, 15, "Freeze on warp", false, false, GUIEditor.window[1])
        GUIEditor.edit[2] = guiCreateEdit(736, 37, 84, 30, "", false, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(338, 119, 106, 15, "Event Dimension:", false, GUIEditor.window[1])
        GUIEditor.edit[3] = guiCreateEdit(463, 110, 121, 34, "5000", false, GUIEditor.window[1])
        GUIEditor.label[4] = guiCreateLabel(338, 159, 106, 15, "Event Interior:", false, GUIEditor.window[1])
        GUIEditor.gridlist[2] = guiCreateGridList(338, 189, 219, 279, false, GUIEditor.window[1])
        guiGridListAddColumn(GUIEditor.gridlist[2], "Online Players", 0.9)
        GUIEditor.edit[4] = guiCreateEdit(437, 478, 120, 26, "MAX 100,000", false, GUIEditor.window[1])
        GUIEditor.button[3] = guiCreateButton(338, 478, 89, 25, "Send Money", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FF20F020")
        GUIEditor.button[4] = guiCreateButton(338, 513, 89, 25, "Send Score", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FF20F020")
        GUIEditor.edit[5] = guiCreateEdit(437, 512, 120, 26, "MAX 15", false, GUIEditor.window[1])
        GUIEditor.gridlist[3] = guiCreateGridList(621, 189, 225, 279, false, GUIEditor.window[1])
        guiGridListAddColumn(GUIEditor.gridlist[3], "Players in Event", 0.9)
        GUIEditor.button[5] = guiCreateButton(621, 479, 89, 25, "Kick Player", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFFE1111")
        GUIEditor.button[6] = guiCreateButton(747, 479, 99, 25, "(Un)Freeze Player", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFFE1111")
        GUIEditor.button[7] = guiCreateButton(10, 598, 318, 36, "No command selected", false, GUIEditor.window[1])
        GUIEditor.label[5] = guiCreateLabel(43, 644, 251, 15, "NOTE: Select a command from the list above", false, GUIEditor.window[1])
        guiLabelSetColor(GUIEditor.label[5], 254, 31, 31)
        GUIEditor.label[6] = guiCreateLabel(687, 566, 95, 16, "Create Vehicles :", false, GUIEditor.window[1])
        GUIEditor.edit[6] = guiCreateEdit(619, 592, 233, 24, "Vehicle Name/ID", false, GUIEditor.window[1])
        GUIEditor.button[8] = guiCreateButton(618, 626, 89, 35, "Create Vehicle Marker", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[8], "NormalTextColour", "FF4DFE1E")
        GUIEditor.button[9] = guiCreateButton(757, 626, 89, 35, "Destroy Vehicle Marker", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[9], "NormalTextColour", "FF4DFE1E")
        GUIEditor.button[10] = guiCreateButton(621, 514, 89, 25, "Give Jetpack", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[10], "NormalTextColour", "FFFE1111")
        GUIEditor.button[11] = guiCreateButton(747, 514, 99, 25, "Remove Jetpack", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[11], "NormalTextColour", "FFFE1111")
        GUIEditor.label[7] = guiCreateLabel(611, 134, 72, 15, "Team Warps", false, GUIEditor.window[1])
        guiLabelSetColor(GUIEditor.label[7], 34, 248, 200)
        GUIEditor.button[12] = guiCreateButton(590, 77, 120, 23, "Close Warps", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[12], "NormalTextColour", "FF41F12F")
        GUIEditor.button[13] = guiCreateButton(590, 107, 120, 23, "Stop Event", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[13], "NormalTextColour", "FF41F12F")
        GUIEditor.edit[7] = guiCreateEdit(463, 150, 121, 34, "0", false, GUIEditor.window[1])
        GUIEditor.button[14] = guiCreateButton(716, 107, 120, 23, "Time Counter", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[14], "NormalTextColour", "FF41F12F")
        GUIEditor.edit[8] = guiCreateEdit(589, 150, 121, 34, "Team Name", false, GUIEditor.window[1])
        GUIEditor.edit[9] = guiCreateEdit(716, 150, 121, 34, "Time (Seconds)", false, GUIEditor.window[1])
        GUIEditor.button[15] = guiCreateButton(362, 647, 155, 27, "Close Panel", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[15], "NormalTextColour", "FFE824F5")
        GUIEditor.label[8] = guiCreateLabel(577, 318, 17, 15, ">>>>", false, GUIEditor.window[1])
        GUIEditor.label[9] = guiCreateLabel(362, 608, 155, 16, "Event Players Number:", false, GUIEditor.window[1])
        guiLabelSetColor(GUIEditor.label[9], 33, 255, 49)    
guiSetVisible(GUIEditor.window[1], false)


function openEventsPanel ()
    
    if (guiGetVisible(GUIEditor.window[1]) == true) then
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
    else
        guiSetVisible(GUIEditor.window[1], true)
        showCursor(true)
        guiGridListClear(GUIEditor.gridlist[1])
        guiGridListClear(GUIEditor.gridlist[2])
        guiGridListClear(GUIEditor.gridlist[3])
        local pcmdRow = guiGridListAddRow(GUIEditor.gridlist[1])
        guiGridListSetItemText(GUIEditor.gridlist[1], pcmdRow,1, "Player Commands", true, false)

        for k,v in pairs (getElementsByType"player") do
            local row = guiGridListAddRow(GUIEditor.gridlist[2])
            local r,g,b = getPlayerNametagColor(v)
            guiGridListSetItemText(GUIEditor.gridlist[2], row, 1, getPlayerName(v),false, false)
            guiGridListSetItemColor(GUIEditor.gridlist[2], row, 1,r,g,b)
        end


        for k,v in pairs (playerCommands) do
            local row = guiGridListAddRow(GUIEditor.gridlist[1])
            guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v,false, false)
        end

        local vcmdRow = guiGridListAddRow(GUIEditor.gridlist[1])
        guiGridListSetItemText(GUIEditor.gridlist[1], vcmdRow,1, "Vehicle Commands", true, false)

        for k,v in pairs (vehicleCommands) do
            local row = guiGridListAddRow(GUIEditor.gridlist[1])
            guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v,false, false)
        end

        local wcmdRow = guiGridListAddRow(GUIEditor.gridlist[1])
        guiGridListSetItemText(GUIEditor.gridlist[1], wcmdRow,1, "Weapon Commands", true, false)

        for k,v in pairs (wepCommands) do
            local row = guiGridListAddRow(GUIEditor.gridlist[1])
            guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v,false, false)
        end

        local pickcmdRow = guiGridListAddRow(GUIEditor.gridlist[1])
        guiGridListSetItemText(GUIEditor.gridlist[1], pickcmdRow,1, "Pickup Commands", true, false)

        for k,v in pairs (pickCommands) do
            local row = guiGridListAddRow(GUIEditor.gridlist[1])
            guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v,false, false)
        end

        local staffcmdRow = guiGridListAddRow(GUIEditor.gridlist[1])
        guiGridListSetItemText(GUIEditor.gridlist[1], staffcmdRow,1, "Staff Commands", true, false)

        for k,v in pairs (staffCommands) do
            local row = guiGridListAddRow(GUIEditor.gridlist[1])
            guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v,false, false)
        end
        
    end
end
addEvent("AUReventsv2:openPanel", true)
addEventHandler("AUReventsv2:openPanel", root, openEventsPanel)