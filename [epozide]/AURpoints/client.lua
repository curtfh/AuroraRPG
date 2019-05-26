addEventHandler("onClientResourceStart", resourceRoot,
    function()
        APScpanel = guiCreateWindow(510, 332, 394, 194, "Convert Aurora Points", false)
        guiWindowSetSizable(APScpanel, false)
        guiSetAlpha(APScpanel, 0.85)
		guiSetVisible(APScpanel,false)
		centerWindow(APScpanel)

		label = guiCreateLabel(137, 35, 107, 15, "Each AP = $1000", false, APScpanel)
        guiSetFont(label, "default-bold-small")
        guiLabelSetColor(label, 162, 72, 181)
        aps = guiCreateEdit(77, 72, 224, 42, "Insert APS", false, APScpanel)
        convert = guiCreateButton(22, 140, 154, 44, "Convert", false, APScpanel)
        closeb = guiCreateButton(217, 140, 154, 44, "Close", false, APScpanel)
    end
)

function centerWindow( center_window )
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize( center_window, false )
    local x, y = ( screenW - windowW ) /2, ( screenH - windowH ) / 2
    guiSetPosition( center_window, x, y, false )
end

function toggleAPSWindow()
	if not (exports.server:isPlayerLoggedIn(localPlayer)) then return end
	if ( guiGetVisible( APScpanel ) ) then
		guiSetVisible( APScpanel, false )
		showCursor( false )
	else
		guiSetVisible( APScpanel, true )
		showCursor(true)
		centerWindow( APScpanel )
		end
	end
addEvent( "openAPS", true )
addEventHandler( "openAPS", localPlayer, toggleAPSWindow )
antispam = {}
addEventHandler("onClientGUIClick",root,function()
	if source == closeb then
		guiSetVisible( APScpanel, false )
		showCursor( false )
	end
	if source == convert then
	if isTimer(antispam[source]) then exports.NGCdxmsg:createNewDxMessage("You can only exchange aps once each 60 seconds",255,0,0) return false end
	antispam[source] = setTimer(function() end,60000,1)
	local value = guiGetText(aps)
	triggerServerEvent("convertAPS",localPlayer,localPlayer,value)
	guiSetVisible( APScpanel, false )
	showCursor( false )
	end
end)