-- GUI variables

local GUI = {}
local state = false
addEventHandler ( "onClientResourceStart", resourceRoot,
function ()
	apps[19][8] = openYoutube
	apps[19][9] = closeYoutube
end
)


local buttonWidth, buttonHeight = 0.5*BGWidth,15
local x, y = guiGetScreenSize()
createYoutubeGUI = function ()

	GUI = {
		guiCreateStaticImage((x / 2) - (850 / 2), (y / 2) - (600 / 2), 547, 598, "Icons/flash.png", false),
	}


	for i=1,#GUI do
		myBrowser = guiCreateBrowser(40,40,457, 528,false, false, false,GUI[i])
		theBrowser = guiGetBrowser(myBrowser)
		guiSetProperty(GUI[i],"AlwaysOnTop","True")

	end
end

addEventHandler("onClientBrowserCreated",root,function()
	if source == theBrowser then
		loadBrowserURL(theBrowser, "http://www.youtube.com")
	end
end)


local openMainGUI = function ()
	if isElement(GUI[1]) then
		for i=1,#GUI do
			guiSetVisible(GUI[i],true)
			guiBringToFront(GUI[i])
			guiSetProperty( GUI[i], "AlwaysOnTop", "True" )
		end
	else
		createYoutubeGUI()
	end
	if theBrowser then
		setBrowserRenderingPaused (theBrowser,false)
	end
end

function closeYoutube ()
	apps[19][7] = false
	state = false
	for i=1,#GUI do
		if isElement ( GUI[i] ) then guiSetVisible ( GUI[i], false ) end
		guiSetProperty( GUI[i], "AlwaysOnTop", "False" )
	end
	setBrowserRenderingPaused (theBrowser,true)
end


function openYoutube ()
	openMainGUI()
	apps[19][7] = true
	state = true
end


