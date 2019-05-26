    local Marker = createMarker (94.12,2063.74,17.58,"corona", 2, 0,100,0, 150)  
	function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

    GUIEditor = {
    tab = {},
    staticimage = {},
    tabpanel = {},
    label = {},
    button = {},
    window = {},
    memo = {}
    }
    addEventHandler("onClientResourceStart", resourceRoot,
        function()
            GUIEditor.window[1] = guiCreateWindow(277, 308, 716, 431, "", false)
			centerWindow( GUIEditor.window[1] )
            guiWindowSetSizable(GUIEditor.window[1], false)
            guiSetAlpha(GUIEditor.window[1], 1.00)
            guiSetVisible (GUIEditor.window[1], false)
     
           
        GUIEditor.tabpanel[1] = guiCreateTabPanel(201, -818, 15, 15, false, GUIEditor.window[1])

        GUIEditor.tab[1] = guiCreateTab("Tab", GUIEditor.tabpanel[1])

        GUIEditor.tabpanel[2] = guiCreateTabPanel(10, 29, 696, 392, false, GUIEditor.window[1])

        GUIEditor.tab[2] = guiCreateTab("Military Forces Information Panel", GUIEditor.tabpanel[2])

        GUIEditor.button[1] = guiCreateButton(281, 331, 117, 26, "Close", false, GUIEditor.tab[2])
        guiSetFont(GUIEditor.button[1], "clear-normal")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFFFFFF")
        GUIEditor.staticimage[1] = guiCreateStaticImage(193, 5, 332, 128, ":AURbaseinfo/aurora.png", false, GUIEditor.tab[2])
		 GUIEditor.memo[1] = guiCreateMemo(10, 123, 676, 201, "We are the Military Forces, Our creation was implemented within the server's creation itself, Our very first founders were Golden, Blacks and Leo, We are the community's Army, Being led by Joseph and Ace Our motto is Discipline, Bravery, Honor, We have a base and it exists in the Restricted Area, Easter Basin Naval Station, We look up to train those new incomers in different types of trainings in order to let them improve and bring up new generations to take charge of our duties in the upcoming future", false, GUIEditor.tab[2])
       guiMemoSetReadOnly(GUIEditor.memo[1], true)
        GUIEditor.label[1] = guiCreateLabel(473, 334, 182, 18, "General(s): Joseph & Smiler", false, GUIEditor.tab[2])
        guiSetFont(GUIEditor.label[1], "clear-normal")
        GUIEditor.label[2] = guiCreateLabel(89, 334, 128, 15, "AuroraRPG(Nicolas)", false, GUIEditor.tab[2])
        guiSetFont(GUIEditor.label[2], "clear-normal")
        GUIEditor.staticimage[2] = guiCreateStaticImage(43, 329, 46, 28, ":AURbaseinfo/copyrights.png", false, GUIEditor.tab[2])    
        end
    )
             
    addEventHandler('onClientMarkerHit', Marker,
      function ( hitPlayer )
         if ( hitPlayer == localPlayer ) then
         guiSetVisible ( GUIEditor.window[1] ,true )
         showCursor( true )
         guiSetInputEnabled(true)
         end
     end
    )
             
    addEventHandler ("onClientGUIClick", root,
      function ()
         if ( source == GUIEditor.button[1] ) then
         guiSetVisible (GUIEditor.window[1], false)
         showCursor (false)
         guiSetInputEnabled(false)
         end
     end
    )
