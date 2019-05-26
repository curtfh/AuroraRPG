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
    button = {},
    window = {}
}
 GUIEditor.window[1] = guiCreateWindow(288, 205, 755, 398, "AuroraRPG Change Weather System", false)
 centerWindow( GUIEditor.window[1] )
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetAlpha(GUIEditor.window[1], 0.89)

        GUIEditor.tabpanel[1] = guiCreateTabPanel(13, 41, 732, 314, false, GUIEditor.window[1])

        GUIEditor.tab[1] = guiCreateTab("AuroraRPG Weather System", GUIEditor.tabpanel[1])

        GUIEditor.staticimage[1] = guiCreateStaticImage(225, 9, 276, 99, ":AURweathersys/aur.png", false, GUIEditor.tab[1])
        GUIEditor.staticimage[2] = guiCreateStaticImage(24, 125, 79, 41, ":AURweathersys/cloudy.png", false, GUIEditor.tab[1])
        GUIEditor.staticimage[3] = guiCreateStaticImage(183, 119, 88, 56, ":AURweathersys/sunny.png", false, GUIEditor.tab[1])
        GUIEditor.staticimage[4] = guiCreateStaticImage(336, 118, 97, 57, ":AURweathersys/rainy.png", false, GUIEditor.tab[1])
        GUIEditor.staticimage[5] = guiCreateStaticImage(511, 118, 73, 62, ":AURweathersys/night.png", false, GUIEditor.tab[1])
        GUIEditor.staticimage[6] = guiCreateStaticImage(625, 123, 85, 47, ":AURweathersys/foggy.png", false, GUIEditor.tab[1])
        GUIEditor.button[1] = guiCreateButton(24, 200, 84, 35, "Cloudy Weather", false, GUIEditor.tab[1])
        guiSetFont(GUIEditor.button[1], "default-bold-small")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFFFEFE")
        GUIEditor.button[2] = guiCreateButton(187, 201, 84, 35, "Sunny Weather", false, GUIEditor.tab[1])
        guiSetFont(GUIEditor.button[2], "default-bold-small")
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFFFEFE")
        GUIEditor.button[3] = guiCreateButton(349, 201, 84, 35, "Rainy    Weather", false, GUIEditor.tab[1])
        guiSetFont(GUIEditor.button[3], "default-bold-small")
        guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFFFFEFE")
        GUIEditor.button[4] = guiCreateButton(510, 201, 84, 35, "Night   Weather", false, GUIEditor.tab[1])
        guiSetFont(GUIEditor.button[4], "default-bold-small")
        guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFFFFEFE")
        GUIEditor.button[5] = guiCreateButton(626, 201, 84, 35, "Foggy  Weather", false, GUIEditor.tab[1])
        guiSetFont(GUIEditor.button[5], "default-bold-small")
        guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFFFFEFE")


        GUIEditor.button[6] = guiCreateButton(300, 361, 117, 27, "Close", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[6], "clear-normal")
        guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFFFFFFF")    
guiSetVisible ( GUIEditor.window[1], false ) 
addEventHandler("onClientGUIClick", GUIEditor.button[6], function () guiSetVisible(GUIEditor.window[1], false) showCursor(false) end, false)
addCommandHandler("weathers",
	function ()
		if ( guiGetVisible( GUIEditor.window[1] ) ) then
			guiSetVisible( GUIEditor.window[1], false )
			showCursor( false )
		else
			guiSetVisible( GUIEditor.window[1], true )
			showCursor( true )
		end
	end
)

addEventHandler ( "onClientGUIClick",root,
function (  )
        if ( source == GUIEditor.button[3] ) then
            setWeather (8)
        elseif ( source == GUIEditor.button[1] ) then
            setWeather (7)
        elseif ( source == GUIEditor.button[2] ) then
            setWeather (1)
			setTime ( 11, 00 )
			elseif ( source == GUIEditor.button[4] ) then
            setTime ( 00, 00 )
			elseif ( source == GUIEditor.button[5] ) then
             setWeather (9)
        end
    end
)