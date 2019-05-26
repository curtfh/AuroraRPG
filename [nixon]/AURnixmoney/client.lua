editText = ""
addEventHandler("onClientGUIChanged", root, function(elem)
if (elem == GUIEditor.edit) then
if (tonumber(guiGetText(GUIEditor.edit))) then
editText = guiGetText(GUIEditor.edit)
else
guiSetText(GUIEditor.edit, editText)
end
end
end)

	function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end	

GUIEditor = {
    staticimage = {},
    edit = {},
    button = {},
    window = {},
    label = {}
}
showCursor(false)
addEventHandler("onClientResourceStart", resourceRoot, function()
        GUIEditor.window[1] = guiCreateWindow(300, 127, 409, 568, "AuroraRPG ~ Money", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
		centerWindow (GUIEditor.window[1])
		guiSetVisible(GUIEditor.window[1], false)

        GUIEditor.staticimage[1] = guiCreateStaticImage(9, 31, 390, 116, ":AURnixmoney/aurora.png", false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(10, 157, 389, 49, "Money is any item or verifiable record that is generally accepted as payment", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[1], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[1], 35, 219, 187)
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
        GUIEditor.label[2] = guiCreateLabel(10, 232, 392, 42, "Amount which should be given:", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[2], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[2], 0, 254, 5)
        GUIEditor.edit[1] = guiCreateEdit(9, 259, 390, 72, "", false, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(12, 348, 387, 44, "Amount which should be taken:", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[3], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[3], 254, 0, 0)
        GUIEditor.edit[2] = guiCreateEdit(10, 380, 390, 72, "", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(13, 472, 105, 65, "Give money", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[1], "default-bold-small")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF00FE17")
        GUIEditor.button[2] = guiCreateButton(159, 472, 105, 65, "Take money", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[2], "default-bold-small")
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFE0000")
        GUIEditor.button[3] = guiCreateButton(299, 472, 101, 65, "Close panel", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[3], "default-bold-small")
        guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFFFFFFF")
        GUIEditor.label[4] = guiCreateLabel(342, 541, 392, 27, "© Nixon", false, GUIEditor.window[1])    
    end
)

addEventHandler("onClientGUIClick", root, function()
 if ( source == GUIEditor.button[3] ) then
    guiSetVisible (GUIEditor.window[1], false)
    showCursor (false)
   end
end
)

addCommandHandler("money",function()
    if exports.CSGstaff:isPlayerStaff(localPlayer) and exports.CSGstaff:getPlayerAdminLevel(localPlayer) >= 5 then
		guiSetVisible ( GUIEditor.window[1], true )
		showCursor( true )
	end
end)

addEventHandler("onClientGUIClick", root, function()
if (source == GUIEditor.button[1]) then
local amount = guiGetText(GUIEditor.edit[1])
if not (tonumber(amount)) then return false end
local amount = tonumber(amount)
if triggerServerEvent("giveMoneyToAll", resourceRoot, localPlayer, amount) then
    exports.NGCdxmsg:createNewDxMessage( "You have successfully given "..amount.."$ to the players!", 0, 255, 0 )
    guiSetVisible (GUIEditor.window[1], true)
    showCursor (true)
end
end
end)

addEventHandler("onClientGUIClick", root, function()
if (source == GUIEditor.button[2]) then
local amount = guiGetText(GUIEditor.edit[2])
if not (tonumber(amount)) then return false end
local amount = tonumber(amount)
if triggerServerEvent("takeMoneyFromAll", resourceRoot, localPlayer, amount) then
    exports.NGCdxmsg:createNewDxMessage( "You have removed "..amount.."$ from players money!", 255, 0, 0 )
    guiSetVisible (GUIEditor.window[1], true)
    showCursor (true)
end
end
end)