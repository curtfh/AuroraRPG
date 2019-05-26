function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end
okno = guiCreateStaticImage(270, -9, 855, 768, ":AURbrowser/tlo.png", false)
 centerWindow( okno )

        local browser = guiCreateBrowser(105, 222, 645, 326,  false, false,false,okno)   


guiSetVisible ( okno, false )

local theBrowser = guiGetBrowser(browser )

addEventHandler("onClientBrowserCreated", theBrowser, 
	function()
		loadBrowserURL(source, "http://www.youtube.com")
	end
)

function pokaz ()
if guiGetVisible ( okno ) == false then
showCursor ( true )
guiSetVisible ( okno, true)
setElementData ( localPlayer, "shader", true )
  setPlayerHudComponentVisible ( "all", false) 
  showChat(false) 
else
showCursor ( false)
setElementData ( localPlayer, "shader", false)
guiSetVisible ( okno, false)
  setPlayerHudComponentVisible ( "all", true ) 
  showChat(true) 
end
end
 addCommandHandler("browser",pokaz)

