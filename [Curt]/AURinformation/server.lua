--[[
Server Name: AuroraRPG
Resource Name: AURinformation
Version: 1.0
Developer/s: Curt
]]--

local messages = {
	{"Press F1 for the Aurora's Extensive Documentation."},
	{"You can trade your items by pressing F10."},
	{"Join our community forums, it's aurorarpg.com."},
	{"To know the illegal race status. Type /iracetime."},
	{"You can change weather, type /sunny, /rainy, /fogy, and /sandstorm"},
	{"Edit your settings by pressing N and click the settings icon."}
}

function postMessages ()
	local randomPick = math.random(#messages)
	--exports.NGCdxmsg:createNewDxMessage(getPlayerFromName("Curt"), "Test", 244, 116, 66)
	outputChatBox("Test", root, 244, 116, 66)
	--exports.NGCdxmsg:createNewDxMessage(getPlayerFromName("Curt"), "YT", 255, 0, 0)
end 
postMessages()