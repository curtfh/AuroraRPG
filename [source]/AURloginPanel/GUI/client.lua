local crasher = {{{{{ {}, {{{}}}, {{{{{{{},{}}}}}}}}}}}}

-- Get the username and/or password is saved
function getAccountXMLData ()
	local theFile = xmlLoadFile ( "@account.xml" )
	if not ( theFile ) then
		theFile = xmlCreateFile( "@account.xml","accounts" )
		xmlCreateChild( theFile, "username" )
		xmlCreateChild( theFile, "password" )
		xmlSaveFile( theFile )
		return "", ""
	else
		usernameNode = xmlFindChild( theFile, "username", 0 )
		username = xmlNodeGetValue ( usernameNode )
		passwordNode = xmlFindChild( theFile, "password", 0 )
		password = xmlNodeGetValue ( passwordNode )
		return username, password
	end
	xmlUnloadFile(theFile)
end

-- Update the XML file with the new data
addEvent ( "updateAccountXMLData", true )
addEventHandler( "updateAccountXMLData", root,
	function ( username, password, usernameTick, passwordTick )
		local theFile = xmlLoadFile ( "@account.xml" )
		if not ( theFile ) then
			theFile = xmlCreateFile( "@account.xml","accounts" )
			xmlCreateChild( theFile, "username" )
			xmlCreateChild( theFile, "password" )
			xmlSaveFile( theFile )
		else
			usernameNode = xmlFindChild( theFile, "username", 0 )
			xmlNodeSetValue( usernameNode, username )
			passwordNode = xmlFindChild( theFile, "password", 0 )
			xmlNodeSetValue( passwordNode, password )

			if not ( usernameTick ) then
				usernameNode = xmlFindChild( theFile, "username", 0 )
				xmlNodeSetValue( usernameNode, "" )
			end

			if not ( passwordTick ) then
				passwordNode = xmlFindChild( theFile, "password", 0 )
				xmlNodeSetValue( passwordNode, "" )
			end
			xmlSaveFile( theFile )
			xmlUnloadFile(theFile)
		end
	end
)


local sw,sh =guiGetScreenSize()
local rx, ry = guiGetScreenSize()
local guiBrowser
local webBrowser

function createAccountingWindows()
	local username, password = getAccountXMLData ()
	guiBrowser = guiCreateBrowser(0, 0, rx, ry, true, true, false)
	webBrowser = guiGetBrowser(guiBrowser)
	addEventHandler("onClientBrowserCreated", webBrowser, 
	function()
		loadBrowserURL(source, "http://mta/local/CEF/index.html")
		focusBrowser(source)
	end)
	addEventHandler ( "onClientBrowserDocumentReady" , webBrowser , 
	function ()
		addEvent("AURloginpanel.onPressLogin", true)
		addEvent("AURloginpanel.onPressRegister", true)
		addEventHandler("AURloginpanel.onPressLogin", webBrowser, onClientPlayerLogin)
		addEventHandler("AURloginpanel.onPressRegister", webBrowser, onClientPlayerRegister)
		executeBrowserJavascript(webBrowser, 'setUserPassValues("'..username..'", "'..password..'");')
	end)
end

-- Create the GUI on connect or start
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
		triggerServerEvent( "doSpawnPlayer", localPlayer )
		guiSetInputMode("no_binds_when_editing")
	end
)

function openInstructionsWindow()
	executeBrowserJavascript(webBrowser, 'showAlertP("warning", "Screen Resolution Warning", "Your screen resolution doesnt support anymore. Change higher than 800x600.");')
	showCursor(true)
end
addCommandHandler("testexs", openInstructionsWindow)

-- Enable cursor
addEvent ( "setCursorEnabled", true )
function enableCursor ( state )
	if ( state ) then
		showCursor( true )
	else
		showCursor( false )
	end
end
addEventHandler( "setCursorEnabled", root, enableCursor )

-- Center the windows
function centerWindows ( theWindow )
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(theWindow,x,y,false)
end

-- Set the login window visable
addEvent ( "setLoginWindowVisable", true )
function showLoginWindow ()
	createAccountingWindows()
	screenX, screenY = guiGetScreenSize()
	if ( screenX <= 800 ) and ( screenY <= 600 ) then
		openInstructionsWindow()
	end
	enableCursor ( true )
	setPlayerHudComponentVisible("radar", false)
	setPlayerHudComponentVisible("area_name", false)
	showChat(false)
end
addEventHandler( "setLoginWindowVisable", root, showLoginWindow )

addEvent ( "setAllWindowsHided", true )
function hideAllWindows ()
	if (isElement(guiBrowser)) then 
		destroyElement(guiBrowser)
	end
	if (isElement(webBrowser)) then 
		destroyElement(webBrowser)
	end
	enableCursor ( false )
end
addEventHandler( "setAllWindowsHided", root, hideAllWindows )

-- Get all the data from the password request screen
function getPasswordWindowData ()
	return guiGetText ( CSGPasswordUsernameField ), guiGetText ( CSGPasswordEmailField )
end

-- Get all data rom the new password window
function getNewPasswordWindowData ()
	return guiGetText ( CSGNewPasswordEdit1 ), guiGetText ( CSGNewPasswordEdit2 )
end

-- Set the warning label data
addEvent ( "setWarningLabelText", true )
function setWarningLabelText ( theType, theTitle, theMessage )
	executeBrowserJavascript(webBrowser, 'showAlertP("'..theType..'", "'..theTitle..'", "'..theMessage..'");')
end
addEventHandler( "setWarningLabelText", root, setWarningLabelText )
