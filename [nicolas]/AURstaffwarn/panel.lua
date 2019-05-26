players = {}
main = {}
warn = {resson = {}}

local warnresson = ""
addEvent("main.windows", true)
addEvent("main.windows", true)
addEventHandler ( "main.windows", getRootElement(), 
function()
  if ( guiGetVisible ( main.windows ) == true )
then guiSetVisible(main.windows,false)
showCursor ( false )
  else
 guiSetVisible(main.windows,true)
 showCursor ( true )
  end
end
 )
 
function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end    
main.windows = guiCreateWindow(313, 192, 742, 376, "AuroraRPG - Warn System", false, CenterWindow)
guiWindowSetSizable(main.windows, false)
tabpanel1 = guiCreateTabPanel(9, 29, 723, 306, false, main.windows)

        tab1= guiCreateTab("AuroraRPG warn System", tabpanel1 )
		staticimage1 = guiCreateStaticImage(251, 10, 295, 100, ":AURstaffwarn/aur.png", false,tab1)
players.list = guiCreateGridList(6, 10, 202, 261, false, tab1)
guiGridListSetSortingEnabled(players.list,false)
playerListColumnGUI = guiGridListAddColumn ( players.list, "AuroraRPG Players", 0.9 )
for id, playeritem in ipairs(getElementsByType("player")) do 
	local row = guiGridListAddRow ( players.list )
	guiGridListSetItemText ( players.list, row, playerListColumnGUI,string.gsub(getPlayerName ( playeritem ),"#%x%x%x%x%x%x",""),false, false )
end
warnresson = guiCreateMemo(406, 183, 130, 33, "", false, tab1)
warn.resson.label = guiCreateLabel(234, 158, 479, 15, "State the Warning reason, then double click on the player that you want to warn him.", false, tab1)    
guiSetFont(warn.resson.label, "default-bold-small")
        guiLabelSetColor(warn.resson.label, 255, 0, 0)
		button1 = guiCreateButton(299, 339, 143, 27, "Close ", false, main.windows)
        guiSetFont(button1, "default-bold-small")
		addEventHandler("onClientGUIClick", button1, function () guiSetVisible(main.windows, false) showCursor(false) end, false)
guiSetVisible(main.windows,false)



addEvent("OnlyAdmin", true)
addEventHandler("OnlyAdmin",root,function()
addCommandHandler("warn",
	function ( )
        if guiGetVisible ( main.windows ) then
			guiSetVisible(main.windows,false)
            showCursor ( false )

        else
			guiGridListClear(players.list)
			for id, playeritem in ipairs(getElementsByType("player")) do 
				local row = guiGridListAddRow ( players.list )
				guiGridListSetItemText ( players.list, row, playerListColumnGUI,string.gsub(getPlayerName ( playeritem ),"#%x%x%x%x%x%x",""),false, false )
			end
            guiSetVisible ( main.windows, true ) 
            showCursor ( true ) 
	end
end)
end
)

addEventHandler( "onClientGUIDoubleClick",guiRoot,function( )
	if ( source == players.list ) then
		local selectedRow, selectedCol = guiGridListGetSelectedItem( players.list )
		local playerName = guiGridListGetItemText( players.list, selectedRow, selectedCol )
		if ( string.len(guiGetText(warnresson)) > 4 ) then
			triggerServerEvent("WarnSys",localPlayer,guiGetText(warnresson),(playerName))
		else
			outputChatBox("the reason need to be 4 cheracter or up",255,0,0,true)
		end
	end
end)