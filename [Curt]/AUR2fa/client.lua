GUIEditor = {
    button = {},
    window = {},
    staticimage = {},
    label = {},
	edit = {}
}
local screenW, screenH = guiGetScreenSize()

function create2fa(path)
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
		if (fileExists(path)) then 
			fileDelete(path)
		end
		return
	end 
	
	GUIEditor.window[1] = guiCreateWindow((screenW - 586) / 2, (screenH - 374) / 2, 586, 374, "AuroraRPG Security - 2 Factor Authentication", false)
	guiWindowSetMovable(GUIEditor.window[1], false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.staticimage[1] = guiCreateStaticImage(144, 84, 298, 247, path, false, GUIEditor.window[1])
	GUIEditor.button[1] = guiCreateButton(436, 335, 140, 29, "Close", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(10, 335, 140, 29, "Test 2FA", false, GUIEditor.window[1])
	GUIEditor.label[1] = guiCreateLabel(20, 26, 546, 48, "Turn on 2-Step Verification. When you enable 2-Step Verification (also known as two-factor authentication), you add an extra layer of security to your account. You sign in with something you know (your password) and something you have (a code sent to your phone).", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	addEventHandler("onClientGUIClick", GUIEditor.button[2], function()
		if (isElement(GUIEditor.window[2])) then 
			return
		end 
		test2fa()
	end, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
		create2fa("qrcode.jpg")
		if (isElement(GUIEditor.window[2])) then 
			test2fa()
		end 
	end, false)
end

function test2fa (disable)
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
		if (not isElement(GUIEditor.window[1])) then 
			showCursor(false)
		end
		return
	end 
	GUIEditor.window[2] = guiCreateWindow((screenW - 510) / 2, (screenH - 170) / 2, 510, 170, "AuroraRPG Security - Two Factor Authentication", false)
	guiWindowSetMovable(GUIEditor.window[2], false)
	guiWindowSetSizable(GUIEditor.window[2], false)

	GUIEditor.label[2] = guiCreateLabel(9, 23, 491, 31, "To continue playing please open your phone and open the app called \"Google Authenticator\" or \"Authenticator\" and get the code.", false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", true)
	GUIEditor.edit[1] = guiCreateEdit(214, 64, 79, 40, "", false, GUIEditor.window[2])
	GUIEditor.button[3] = guiCreateButton(185, 114, 137, 31, "Continue", false, GUIEditor.window[2])   
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	if (disable == true) then 
		addEventHandler("onClientGUIClick", GUIEditor.button[3], function()
			triggerServerEvent ("AUR2fa.disableverify", resourceRoot, getLocalPlayer(), guiGetText(GUIEditor.edit[1]))
		end, false)
	else
		addEventHandler("onClientGUIClick", GUIEditor.button[3], function()
			triggerServerEvent ("AUR2fa.verifytest", resourceRoot, getLocalPlayer(), guiGetText(GUIEditor.edit[1]))
		end, false)
	end 
end 

function show2falogin ()
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
		showCursor(false)
		return
	end 
	GUIEditor.window[2] = guiCreateWindow((screenW - 510) / 2, (screenH - 170) / 2, 510, 170, "AuroraRPG Security - Two Factor Authentication", false)
	guiWindowSetMovable(GUIEditor.window[2], false)
	guiWindowSetSizable(GUIEditor.window[2], false)

	GUIEditor.label[2] = guiCreateLabel(9, 23, 491, 31, "To continue playing please open your phone and open the app called \"Google Authenticator\" or \"Authenticator\" and get the code.", false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", true)
	GUIEditor.edit[1] = guiCreateEdit(214, 64, 79, 40, "", false, GUIEditor.window[2])
	GUIEditor.button[3] = guiCreateButton(185, 114, 137, 31, "Continue", false, GUIEditor.window[2])   
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
	addEventHandler("onClientGUIClick", GUIEditor.button[3], function()
		triggerServerEvent ("AUR2fa.real2faverify", resourceRoot, getLocalPlayer(), guiGetText(GUIEditor.edit[1]))
	end, false)
end 



function verifytest_setstatus (status)
	if (isElement(GUIEditor.window[2])) then 
		if (status == "OK") then 
			test2fa()
			outputChatBox("AuroraRPG: The code is right!", 255, 255, 0)
		else
			outputChatBox("AuroraRPG: "..status, 255, 0, 0)
		end 
	end 
end 
addEvent("AUR2fa.verifytest_setstatus", true)
addEventHandler("AUR2fa.verifytest_setstatus", resourceRoot, verifytest_setstatus)

function verifytestopen ()
	if (not isElement(GUIEditor.window[2])) then 
		test2fa()
	end 
	
end 
addEvent("AUR2fa.test", true)
addEventHandler("AUR2fa.test", resourceRoot, verifytestopen)

function disableAuth ()
	if (not isElement(GUIEditor.window[2])) then 
		test2fa(true)
	end 
	
end 
addEvent("AUR2fa.disable", true)
addEventHandler("AUR2fa.disable", resourceRoot, disableAuth)

function createQR (image)
	if (fileExists("qrcode.jpg")) then 
		fileDelete("qrcode.jpg")
	end
	local file = fileCreate("qrcode.jpg")
	fileWrite(file, image)
	fileClose(file)
	create2fa("qrcode.jpg")
end 
addEvent("AUR2fa.createQR", true)
addEventHandler("AUR2fa.createQR", resourceRoot, createQR)


local timer

function show2FA (status)
	if (status == false) then 
		destroyElement(GUIEditor.window[2])
		showCursor(false)
		return
	end
	if (not isElement(GUIEditor.window[2])) then 
		show2falogin()
	end 
end 
addEvent("AUR2fa.show2FA", true)
addEventHandler("AUR2fa.show2FA", resourceRoot, show2FA)

function verify2fa (status)
	if (isElement(GUIEditor.window[2])) then 
		if (status == "OK") then 
			show2FA(false)
			outputChatBox("AuroraRPG: Successfully logged in with username and password and two factor authentication code!", 255, 255, 0)
			toggleDisableThings(false)
		else
			guiSetText(GUIEditor.label[2], status)
		end 
	end 
end 
addEvent("AUR2fa.verify2fa", true)
addEventHandler("AUR2fa.verify2fa", resourceRoot, verify2fa)

function onCientBlurz()
	if (source == GUIEditor.window[2]) then
				
	elseif (source == GUIEditor.label[2]) then
	
	elseif (source == GUIEditor.edit[1]) then			
	
	elseif (source == GUIEditor.button[3]) then			
	
	else
		destroyElement (source)
	end
end 

function toggleDisableThings(status)
	if (status == true) then
		if (isTimer(timer)) then 
			killTimer(timer)
		end 
		timer = setTimer(function()
		
			
			addEventHandler("onClientGUIBlur", root, onCientBlurz, true)
			addEventHandler("onClientGUIFocus", root, onCientBlurz, true)
			
			if (isElement(GUIEditor.window[2])) then 
				if (not isCursorShowing()) then 
					showCursor(true)
				end 
			end 
		end, 500, 0)
		
		
	else
		killTimer(timer)
		removeEventHandler("onClientGUIBlur", root, onCientBlurz)
		removeEventHandler("onClientGUIFocus", root, onCientBlurz)
	end 
end 
addEvent("AUR2fa.toggleDisableThings", true)
addEventHandler("AUR2fa.toggleDisableThings", resourceRoot, toggleDisableThings)


if (fileExists("client.lua")) then 
	fileDelete("client.lua")
end 