--[[-------------------------------------------------
Notes:

> This code is using a relative image filepath. This will only work as long as the location it is from always exists, and the resource it is part of is running.
    To ensure it does not break, it is highly encouraged to move images into your local resource and reference them there.
--]]-------------------------------------------------


GUIEditor = {
    button = {},
    window = {},
    staticimage = {},
    label = {}
}
local elementsCreated = {}
local screenW, screenH = guiGetScreenSize()

function openGUI ()
	if (isElement(GUIEditor.window[1])) then 
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		destroyElement(GUIEditor.window[1])
		return 
	end 
	GUIEditor.window[1] = guiCreateWindow((screenW - 825) / 2, (screenH - 559) / 2, 825, 559, "AuroraRPG - Main Menu", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(10, 140, 206, 15, "Aurora's Exclusive Document", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
	GUIEditor.label[2] = guiCreateLabel(319, 140, 206, 15, "In Game Updates/Changes", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
	GUIEditor.label[3] = guiCreateLabel(602, 140, 206, 15, "Past Login Logs", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
	GUIEditor.label[4] = guiCreateLabel(10, 274, 206, 15, "User Settings", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
	GUIEditor.label[5] = guiCreateLabel(319, 279, 206, 15, "Mini Game Room", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
	GUIEditor.label[6] = guiCreateLabel(602, 279, 206, 15, "Mini Game User Control Panel", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[6], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
	GUIEditor.label[7] = guiCreateLabel(10, 418, 206, 15, "Report a problem/player", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[7], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
	GUIEditor.label[8] = guiCreateLabel(319, 418, 206, 15, "VIP Interface", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[8], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
	GUIEditor.label[9] = guiCreateLabel(602, 418, 206, 15, "Contact a Staff", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[9], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[9], "center", false)
	GUIEditor.label[10] = guiCreateLabel(10, 502, 798, 15, "Your playing AuroraRPG as NickName | Current Players: "..#getElementsByType("player").." | Current Staff On Duty: "..#getPlayersInTeam(getTeamFromName("Staff")).." | aurorarpg.com", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[10], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[10], "center", false)
	GUIEditor.label[11] = guiCreateLabel(10, 477, 798, 15, "Click here to contribute server's translation to your language.", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[11], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[11], "center", false)
	GUIEditor.label[12] = guiCreateLabel(10, 23, 798, 15, "AuroraRPG ~ CSG - Police, Criminals, Turfing, Robbery City, Drugs! | aurorarpg.com", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[12], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[12], "center", false)
	GUIEditor.staticimage[1] = guiCreateStaticImage(72, 53, 73, 77, ":AURmainmenu/rules.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[2] = guiCreateStaticImage(383, 53, 73, 77, ":AURmainmenu/updates.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[3] = guiCreateStaticImage(668, 53, 73, 77, ":AURmainmenu/pastlogins.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[4] = guiCreateStaticImage(645, 161, 118, 123, ":AURmainmenu/userp.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[5] = guiCreateStaticImage(336, 160, 168, 155, ":AURmainmenu/minigames.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[6] = guiCreateStaticImage(62, 165, 97, 95, ":AURmainmenu/settings.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[7] = guiCreateStaticImage(57, 308, 107, 100, ":AURmainmenu/report.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[8] = guiCreateStaticImage(369, 305, 106, 105, ":AURmainmenu/vip.png", false, GUIEditor.window[1])
	GUIEditor.staticimage[9] = guiCreateStaticImage(643, 306, 130, 127, ":AURmainmenu/contact.png", false, GUIEditor.window[1])
	GUIEditor.button[1] = guiCreateButton(254, 521, 332, 28, "Close", false, GUIEditor.window[1])    
	
	for i=1,9 do
		addEventHandler( "onClientMouseEnter",GUIEditor.staticimage[i], function()
			if source == GUIEditor.staticimage[i] then
				guiSetAlpha(source,0.5)
			end
		end)
		addEventHandler( "onClientMouseLeave",GUIEditor.staticimage[i], function()
			if source == GUIEditor.staticimage[i] then
				guiSetAlpha(source,1)
			end
		end)
	end
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[1],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("rules")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[1],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("rules")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[2],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("updates")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[2],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("updates")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[3],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("logins")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[3],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("logins")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[4],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[6],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[5],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("room")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[5],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("room")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[6],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("userp")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[4],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("userp")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[7],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("report")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[7],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("report")
	end)
	
	
	addEventHandler("onClientGUIClick", GUIEditor.label[8],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("vip")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[8],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("vip")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[9],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("helpme")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[9],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("helpme")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.label[1],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
		executeCommandHandler ("contribute")
	end)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[1],function()
		destroyElement(GUIEditor.window[1])
		killTimer(elementsCreated["anticursorbug"])
		showCursor(false)
	end)
	
	showCursor(true)
	elementsCreated["anticursorbug"] = setTimer(function()
		if (isElement(GUIEditor.window[1])) then 
			if (not isCursorShowing()) then 
				showCursor(true)
			end 
		end 
	end, 500, 0)
	
	
end 

bindKey ("F1", "down", openGUI) 