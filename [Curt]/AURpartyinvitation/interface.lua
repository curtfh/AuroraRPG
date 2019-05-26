GUIEditor = {
    button = {},
    window = {},
    staticimage = {},
    label = {}
}
setElementData(getLocalPlayer(), "AURpartyinvitation.enabled", true)

local timerAntiCursorBug 


function openGUI ()
	if (isElement(GUIEditor.window[1])) then return end 
	playSound("sfx.mp3")
	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 756) / 2, (screenH - 425) / 2, 756, 425, "AuroraRPG - Electronic Dance Music Invitation", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.staticimage[1] = guiCreateStaticImage(208, 24, 339, 127, "logo.png", false, GUIEditor.window[1])
	GUIEditor.label[1] = guiCreateLabel(136, 151, 499, 178, "AuroraRPG - Concert Event\nWhen: Feburary 16, 2019 - 11PM PHT - 11AM EDT - 5PM CEST - 5PM CAT - 4PM WAT\n\nWhere: Santa Maria Beach, Los Santos (AuroraRPG In Game)\n\nInfo: Free event, Giveaways/Gifts, Includes flashing lights\n\n=-Rules-=\n1. Deathmatching is isn't allowed.\n2. Vehicles are not allowed inside the venue.\n3. Follow our in game rules.\n\nTo experience this party, you must download our 700mb update and a good computer.", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
	GUIEditor.button[1] = guiCreateButton(114, 354, 199, 41, "Close", false, GUIEditor.window[1])
	guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF1EFE00")
	GUIEditor.button[2] = guiCreateButton(446, 354, 199, 41, "Close", false, GUIEditor.window[1])
	guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFE0000")
	GUIEditor.label[2] = guiCreateLabel(237, 399, 299, 16, "AuroraRPG Invitation 2019", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)    
	showCursor(true)
	timerAntiCursorBug = setTimer(function()
		if (not isCursorShowing()) then 
			showCursor(true)
		end 
	end, 500, 0)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[1],function()
		killTimer(timerAntiCursorBug)
		showCursor(false)
		destroyElement(GUIEditor.window[1])
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[2],function()
		killTimer(timerAntiCursorBug)
		showCursor(false)
		destroyElement(GUIEditor.window[1])
	end)

	executeCommandHandler("fortnite", "infinitedab")
	
end 

addEvent("AURpartyinvitation.requestInvitation", true)
addEventHandler("AURpartyinvitation.requestInvitation", getRootElement(),
function()
	if (source == getLocalPlayer()) then 
		openGUI()
	end 
end)

addCommandHandler("edm", openGUI)