function createf2a (player)
	fetchRemote ("https://aurorarpg.com/server2fa/2fa.php?type=create", setdb2fa, "", false, player)
end

function setdb2fa (responseData, errno, player)
    if errno == 0 then
        if (not exports.AURcurtmisc:getPlayerAccountData((player), "2fa.secret") or exports.AURcurtmisc:getPlayerAccountData((player), "2fa.secret") == "") then
			exports.AURcurtmisc:setPlayerAccountData((player), "2fa.secret", responseData)
			outputChatBox("AuroraRPG: Didn't got the QR code? ", player, 255, 0, 0)
			outputChatBox("AuroraRPG: Just add this Manual entry on Google Authenticator:", player, 255, 0, 0)
			outputChatBox("Account: play.aurorarpg.com:22003", player, 255, 0, 0)
			outputChatBox("Key: "..responseData, player, 255, 0, 0)
			fetchRemote ("https://aurorarpg.com/server2fa/2fa.php?type=create_withimg&secret="..responseData, sendImageToClientAndOpenGUI, "", false, player)
			return 
		end
		outputChatBox("AuroraRPG: You already have 2FA enabled. To disable type /2fa disable.", player, 255, 255, 0)
    end
end

function sendImageToClientAndOpenGUI (responseData, errno, player)
	if errno == 0 then 
		triggerClientEvent(player, "AUR2fa.createQR", resourceRoot, responseData)
	end 
end 

function verifytest (player, code)
	local secret = exports.AURcurtmisc:getPlayerAccountData(player, "2fa.secret")
	fetchRemote ("https://aurorarpg.com/server2fa/2fa.php?type=authenticate&secret="..secret.."&code="..code, function(responseData, errno, player)
		if errno == 0 then 
			if (responseData == "OK") then
				triggerClientEvent(player, "AUR2fa.verifytest_setstatus", resourceRoot, "OK")
			else
				triggerClientEvent(player, "AUR2fa.verifytest_setstatus", resourceRoot, "Something is wrong with your code. Please try again.")
			end
		else
			outputChatBox("AuroraRPG: Error! Can't reach to our Authenticator Server.", player, 255, 0, 0)
			triggerClientEvent(player, "AUR2fa.verifytest_setstatus", resourceRoot, "Error! Can't reach to our Authenticator Server.")
		end
	end, "", false, player)
end
addEvent("AUR2fa.verifytest", true)
addEventHandler("AUR2fa.verifytest", resourceRoot, verifytest)

function real2faverify (player, code)
	local secret = exports.AURcurtmisc:getPlayerAccountData(player, "2fa.secret")
	fetchRemote ("https://aurorarpg.com/server2fa/2fa.php?type=authenticate&secret="..secret.."&code="..code, function(responseData, errno, player)
		if errno == 0 then 
			if (responseData == "OK") then
				triggerClientEvent(player, "AUR2fa.verify2fa", resourceRoot, "OK")
				reanableAllThings(player)
			else
				triggerClientEvent(player, "AUR2fa.verify2fa", resourceRoot, "Something is wrong with your code. Please try again.")
			end
		else
			outputChatBox("AuroraRPG: Error! Can't reach to our Authenticator Server.", player, 255, 0, 0)
			triggerClientEvent(player, "AUR2fa.verify2fa", resourceRoot, "Error! Can't reach to our Authenticator Server.")
		end
	end, "", false, player)
end
addEvent("AUR2fa.real2faverify", true)
addEventHandler("AUR2fa.real2faverify", resourceRoot, real2faverify)

function disableverify (player, code)
	local secret = exports.AURcurtmisc:getPlayerAccountData(player, "2fa.secret")
	fetchRemote ("https://aurorarpg.com/server2fa/2fa.php?type=authenticate&secret="..secret.."&code="..code, function(responseData, errno, player)
		if errno == 0 then 
			if (responseData == "OK") then
				triggerClientEvent(player, "AUR2fa.verifytest_setstatus", resourceRoot, "OK")
				outputChatBox("AuroraRPG: Your account is unsecured, you disabled 2FA on your account. To enable it again type /2fa create.", player, 255, 0, 0)
				exports.AURcurtmisc:setPlayerAccountData((player), "2fa.secret", "")
			else
				triggerClientEvent(player, "AUR2fa.verifytest_setstatus", resourceRoot, "Something is wrong with your code. Please try again.")
			end
		else
			outputChatBox("AuroraRPG: Error! Can't reach to our Authenticator Server.", player, 255, 0, 0)
			triggerClientEvent(player, "AUR2fa.verifytest_setstatus", resourceRoot, "Error! Can't reach to our Authenticator Server.")
		end
	end, "", false, player)
end
addEvent("AUR2fa.disableverify", true)
addEventHandler("AUR2fa.disableverify", resourceRoot, disableverify)

function theCommand (theplr, thecmd, var1)
	if (var1 == "create") then 
		outputChatBox("AuroraRPG: Generating QR Code. An interface will pop up and showing your QR code. Be ready with your phone and 'Google Authenticator' or ' Authenticator' open.", theplr, 255, 255, 0)
		createf2a(theplr)
	elseif (var1 == "test") then 
		if (not exports.AURcurtmisc:getPlayerAccountData(theplr, "2fa.secret") or exports.AURcurtmisc:getPlayerAccountData(theplr, "2fa.secret") == "") then
			outputChatBox("AuroraRPG: To enable/create 2FA, please type /2fa create.", theplr, 255, 255, 0)
			return
		end 
		triggerClientEvent(theplr, "AUR2fa.test", resourceRoot)
	elseif (var1 == "disable") then 
		if (not exports.AURcurtmisc:getPlayerAccountData(theplr, "2fa.secret") or exports.AURcurtmisc:getPlayerAccountData(theplr, "2fa.secret") == "") then
			outputChatBox("AuroraRPG: Your 2FA is diabled. To enable/create 2FA, please type /2fa create.", theplr, 255, 255, 0)
			return
		end 
		triggerClientEvent(theplr, "AUR2fa.disable", resourceRoot)
	else
		outputChatBox("Turn on 2-Step Verification. When you enable 2-Step Verification (also known as two-factor authentication), you", theplr, 255, 255, 0)
		outputChatBox("add an extra layer of security to your account. You sign in with something you know (your password) and something you have (a code sent to your phone).", theplr, 255, 255, 0)
		outputChatBox("Please download these apps on your phone: Google Authenticator (Search in App Store or Play Store)", theplr, 255, 0, 0)
		outputChatBox("To enable 2FA for your account type /2fa create.", theplr, 255, 0, 0)
		outputChatBox("To disable 2FA for your account type /2fa disable.", theplr, 255, 0, 0)
		outputChatBox("To test 2FA code for your account type /2fa test.", theplr, 255, 0, 0)
	end 
	
end 
addCommandHandler("2fa", theCommand)


function disabelThingy ()
	cancelEvent()
end

function reanableAllThings (player)
	removeEventHandler("onPlayerCommand", player, disabelThingy)
	removeEventHandler("onPlayerChangeNick", player, disabelThingy)
	triggerClientEvent(player, "AUR2fa.toggleDisableThings", resourceRoot, false)
	toggleAllControls (player, true, true, true) 
	setPlayerMuted (player, false)
	showChat (player, true)
	setElementFrozen(player, false)
	fadeCamera (player, true)
	toggleControl(player, "jump", true)
	toggleControl(player, "fire", true)
	toggleControl(player, "next_weapon", true)
	toggleControl(player, "previous_weapon", true)
	toggleControl(player, "forwards", true)
	toggleControl(player, "backwards", true)
	toggleControl(player, "left", true)
	toggleControl(player, "right", true)
	toggleControl(player, "zoom_in", true)
	toggleControl(player, "zoom_out", true)
	toggleControl(player, "sprint", true)
	toggleControl(player, "look_behind", true)
	toggleControl(player, "crouch", true)
	toggleControl(player, "action", true)
	toggleControl(player, "walk", true)
	toggleControl(player, "aim_weapon", true)
	toggleControl(player, "conversation_yes", true)
	toggleControl(player, "conversation_no", true)
	toggleControl(player, "group_control_forwards", true)
	toggleControl(player, "group_control_back", true)
	toggleControl(player, "enter_exit", true)
end 


addEventHandler( "onServerPlayerLogin", root, function ()
	if (not exports.AURcurtmisc:getPlayerAccountData(source, "2fa.secret") or exports.AURcurtmisc:getPlayerAccountData(source, "2fa.secret") == "") then
		return false
	end 
	addEventHandler("onPlayerCommand", source, disabelThingy)
	addEventHandler("onPlayerChangeNick", source, disabelThingy)
	toggleAllControls (source, false, false, false) 
	triggerClientEvent(source, "AUR2fa.show2FA", resourceRoot, true)
	triggerClientEvent(source, "AUR2fa.toggleDisableThings", resourceRoot, true)
	setPlayerMuted (source, true)
	showChat (source, false)
	setElementFrozen(source, true)
	fadeCamera (source, false)
	toggleControl(source, "jump", false)
	toggleControl(source, "fire", false)
	toggleControl(source, "next_weapon", false)
	toggleControl(source, "previous_weapon", false)
	toggleControl(source, "forwards", false)
	toggleControl(source, "backwards", false)
	toggleControl(source, "left", false)
	toggleControl(source, "right", false)
	toggleControl(source, "zoom_in", false)
	toggleControl(source, "zoom_out", false)
	toggleControl(source, "sprint", false)
	toggleControl(source, "look_behind", false)
	toggleControl(source, "crouch", false)
	toggleControl(source, "action", false)
	toggleControl(source, "walk", false)
	toggleControl(source, "aim_weapon", false)
	toggleControl(source, "conversation_yes", false)
	toggleControl(source, "conversation_no", false)
	toggleControl(source, "group_control_forwards", false)
	toggleControl(source, "group_control_back", false)
	toggleControl(source, "enter_exit", false)
end)


function loltesting(player)
	if (not exports.AURcurtmisc:getPlayerAccountData(player, "2fa.secret") or exports.AURcurtmisc:getPlayerAccountData(player, "2fa.secret") == "") then
		return false
	end 
	--addEventHandler("onPlayerCommand", player, disabelThingy)
	addEventHandler("onPlayerChangeNick", player, disabelThingy)
	toggleAllControls (player, false, false, false) 
	triggerClientEvent(player, "AUR2fa.show2FA", resourceRoot, true)
	triggerClientEvent(player, "AUR2fa.toggleDisableThings", resourceRoot, true)
	setPlayerMuted (player, true)
	showChat (player, false)
	setElementFrozen(player, true)
	fadeCamera (player, false)
	toggleControl(player, "jump", false)
	toggleControl(player, "fire", false)
	toggleControl(player, "next_weapon", false)
	toggleControl(player, "previous_weapon", false)
	toggleControl(player, "forwards", false)
	toggleControl(player, "backwards", false)
	toggleControl(player, "left", false)
	toggleControl(player, "right", false)
	toggleControl(player, "zoom_in", false)
	toggleControl(player, "zoom_out", false)
	toggleControl(player, "sprint", false)
	toggleControl(player, "look_behind", false)
	toggleControl(player, "crouch", false)
	toggleControl(player, "action", false)
	toggleControl(player, "walk", false)
	toggleControl(player, "aim_weapon", false)
	toggleControl(player, "conversation_yes", false)
	toggleControl(player, "conversation_no", false)
	toggleControl(player, "group_control_forwards", false)
	toggleControl(player, "group_control_back", false)
	toggleControl(player, "enter_exit", false)
end 
addCommandHandler("testf2alol", loltesting)